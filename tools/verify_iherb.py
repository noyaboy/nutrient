"""
Scrape iHerb product pages using Playwright + stealth to bypass Cloudflare.

Strategy:
1. Launch Chromium with stealth patches (hide navigator.webdriver, etc.)
2. Visit iHerb homepage first → wait for Cloudflare challenge to resolve
3. Navigate to each product page with random delays (5-12s)
4. Extract data from __NEXT_DATA__ (Next.js), JSON-LD, and DOM fallback
5. Save results to JSON
"""

import asyncio
import json
import random
import re
from playwright.async_api import async_playwright
from playwright_stealth import Stealth

IHERB_URLS = [
    {"name": "肌酸 CGN", "url": "https://tw.iherb.com/pr/california-gold-nutrition-sport-creatine-monohydrate-unflavored-1-lb-454-g/71026"},
    {"name": "甘胺酸鎂 NOW", "url": "https://tw.iherb.com/pr/now-foods-magnesium-glycinate-180-tablets-100-mg-per-tablet/88819"},
    {"name": "葉黃素 CGN", "url": "https://tw.iherb.com/pr/california-gold-nutrition-lutein-with-zeaxanthin-from-marigold-extract-120-veggie-softgels/94824"},
    {"name": "鋅 NOW", "url": "https://tw.iherb.com/pr/now-foods-zinc-picolinate-50-mg-120-veg-capsules/878"},
    {"name": "銅 Solaray", "url": "https://tw.iherb.com/pr/solaray-copper-2-mg-100-vegcaps/70102"},
    {"name": "D3 Doctor's Best", "url": "https://tw.iherb.com/pr/doctor-s-best-vitamin-d3-125-mcg-5-000-iu-360-softgels/36580"},
    {"name": "L-Theanine NOW", "url": "https://tw.iherb.com/pr/now-foods-double-strength-l-theanine-200-mg-120-veg-capsules/54096"},
    {"name": "CollagenUP CGN", "url": "https://tw.iherb.com/pr/california-gold-nutrition-collagenup-marine-hydrolyzed-collagen-hyaluronic-acid-vitamin-c-unflavored-7-26-oz-206-g/64903"},
    {"name": "CoQ10 NOW", "url": "https://tw.iherb.com/pr/now-foods-ubiquinol-200-mg-60-softgels/23657"},
    {"name": "B-50 NOW", "url": "https://tw.iherb.com/pr/now-foods-b-50-100-veg-capsules/39670"},
    {"name": "豌豆蛋白 NOW", "url": "https://tw.iherb.com/pr/now-foods-sports-pea-protein-pure-unflavored-2-lbs-907-g/9858"},
    {"name": "甘胺酸粉 NOW", "url": "https://tw.iherb.com/pr/now-foods-glycine-pure-powder-1-lb-454-g/615"},
    {"name": "蘇糖酸鎂 NOW", "url": "https://tw.iherb.com/pr/now-foods-magtein-magnesium-l-threonate-90-veg-capsules/57577"},
    {"name": "Ashwagandha NOW", "url": "https://tw.iherb.com/pr/now-foods-ashwagandha-standardized-extract-450-mg-90-veg-capsules/310"},
    {"name": "電解質粉 CGN", "url": "https://tw.iherb.com/pr/california-gold-nutrition-hydrationup-electrolyte-drink-mix-variety-pack-20-packets-0-14-oz-0-17-oz-4-g-4-8-g-each/94823"},
]


async def extract_next_data(page):
    """Extract product data from Next.js __NEXT_DATA__ script tag."""
    try:
        data = await page.evaluate("""() => {
            const el = document.querySelector('#__NEXT_DATA__');
            if (el) return JSON.parse(el.textContent);
            if (window.__NEXT_DATA__) return window.__NEXT_DATA__;
            return null;
        }""")
        if data:
            return data
    except Exception:
        pass
    return None


async def extract_json_ld(page):
    """Extract JSON-LD structured data (schema.org Product)."""
    try:
        items = await page.evaluate("""() => {
            const scripts = document.querySelectorAll('script[type="application/ld+json"]');
            return Array.from(scripts).map(s => {
                try { return JSON.parse(s.textContent); }
                catch { return null; }
            }).filter(Boolean);
        }""")
        return items or []
    except Exception:
        return []


async def extract_dom_data(page):
    """Fallback: extract product info directly from DOM."""
    info = {}

    # Title
    try:
        el = await page.query_selector("h1")
        if el:
            info["title"] = (await el.inner_text()).strip()
    except Exception:
        pass

    # Price
    try:
        for sel in [
            "[data-testid='product-price']",
            ".product-price",
            "#price",
            "section .price",
            "b.s24",
            "[itemprop='price']",
        ]:
            el = await page.query_selector(sel)
            if el:
                text = (await el.inner_text()).strip()
                if any(c.isdigit() for c in text):
                    info["price"] = text
                    break
    except Exception:
        pass

    # Supplement facts from body text
    try:
        body_text = await page.inner_text("body")

        # Nutrition keywords
        nutrition_kw = [
            "份量", "Serving Size", "每份", "Amount Per Serving",
            "營養成分", "Supplement Facts", "Nutrition Facts",
            "蛋白質", "Protein", "脂肪", "Fat", "碳水", "Carb",
            "熱量", "Calories", "鈣", "Calcium", "維生素", "Vitamin",
            "EPA", "DHA", "鎂", "Magnesium", "鋅", "Zinc", "銅", "Copper",
            "肌酸", "Creatine", "茶氨酸", "Theanine", "葉黃素", "Lutein",
            "玉米黃素", "Zeaxanthin", "D3", "IU",
            "mg", "mcg",
        ]
        relevant = []
        for line in body_text.split("\n"):
            line = line.strip()
            if line and any(kw in line for kw in nutrition_kw):
                relevant.append(line)
        if relevant:
            info["nutrition_lines"] = "\n".join(relevant[:60])

        # Description keywords
        desc_kw = [
            "產品描述", "說明", "建議用量", "其他成份", "注意事項",
            "Description", "Suggested Use", "Other Ingredients",
        ]
        desc = []
        for line in body_text.split("\n"):
            line = line.strip()
            if line and any(kw in line for kw in desc_kw):
                desc.append(line)
        if desc:
            info["description_lines"] = "\n".join(desc[:30])
    except Exception:
        pass

    return info


def extract_product_from_next_data(next_data):
    """Dig into __NEXT_DATA__ to find product details."""
    if not next_data:
        return {}

    info = {}
    try:
        # Next.js stores page props in various locations
        props = next_data.get("props", {})
        page_props = props.get("pageProps", {})

        # Try common patterns for product data
        product = (
            page_props.get("product")
            or page_props.get("productData")
            or page_props.get("initialData", {}).get("product")
            or page_props.get("data", {}).get("product")
        )

        if product:
            info["title"] = product.get("name") or product.get("title", "")
            price_info = product.get("price") or product.get("pricing", {})
            if isinstance(price_info, dict):
                info["price"] = price_info.get("salePrice") or price_info.get("price") or price_info.get("listPrice")
            elif isinstance(price_info, (int, float, str)):
                info["price"] = str(price_info)

            info["brand"] = product.get("brand", {}).get("name", "") if isinstance(product.get("brand"), dict) else product.get("brand", "")
            info["weight"] = product.get("weight") or product.get("packageQuantity", "")
            info["serving_size"] = product.get("servingSize", "")
            info["servings_per_container"] = product.get("servingsPerContainer", "")

            # Supplement facts
            supp_facts = product.get("supplementFacts") or product.get("nutritionFacts")
            if supp_facts:
                info["supplement_facts"] = supp_facts

        # Dump the full pageProps keys for debugging
        info["_pageProps_keys"] = list(page_props.keys()) if page_props else []

    except Exception as e:
        info["_next_data_error"] = str(e)

    return info


def extract_product_from_json_ld(json_ld_items):
    """Extract product info from JSON-LD structured data."""
    info = {}
    for item in json_ld_items:
        # Handle @graph arrays
        items_to_check = [item]
        if isinstance(item, dict) and "@graph" in item:
            items_to_check = item["@graph"]
        elif isinstance(item, list):
            items_to_check = item

        for obj in items_to_check:
            if not isinstance(obj, dict):
                continue
            obj_type = obj.get("@type", "")
            if obj_type == "Product" or "Product" in str(obj_type):
                info["title"] = obj.get("name", "")
                info["brand"] = obj.get("brand", {}).get("name", "") if isinstance(obj.get("brand"), dict) else obj.get("brand", "")
                info["description"] = obj.get("description", "")[:500]
                info["sku"] = obj.get("sku", "")
                info["image"] = obj.get("image", "")

                offers = obj.get("offers", {})
                if isinstance(offers, dict):
                    info["price"] = offers.get("price", "")
                    info["currency"] = offers.get("priceCurrency", "")
                    info["availability"] = offers.get("availability", "")
                elif isinstance(offers, list) and offers:
                    info["price"] = offers[0].get("price", "")
                    info["currency"] = offers[0].get("priceCurrency", "")

                # Aggregate rating
                rating = obj.get("aggregateRating", {})
                if rating:
                    info["rating"] = rating.get("ratingValue", "")
                    info["review_count"] = rating.get("reviewCount", "")

                break
    return info


async def wait_for_cloudflare(page, timeout=30):
    """Wait for Cloudflare challenge to resolve."""
    print("  等待 Cloudflare 驗證...", flush=True)
    for i in range(timeout):
        # Check if we're past the challenge
        title = await page.title()
        url = page.url

        # Cloudflare challenge pages have specific titles
        if "just a moment" in title.lower() or "checking" in title.lower():
            await asyncio.sleep(1)
            continue

        # Check for cf_clearance cookie
        cookies = await page.context.cookies()
        has_clearance = any(c["name"] == "cf_clearance" for c in cookies)
        if has_clearance:
            print(f"  Cloudflare 通過！（{i+1}s）", flush=True)
            return True

        # If page has real content (not challenge), we're good
        content_len = len(await page.content())
        if content_len > 5000 and "challenge" not in title.lower():
            print(f"  頁面已載入（{i+1}s，{content_len} bytes）", flush=True)
            return True

        await asyncio.sleep(1)

    print(f"  Cloudflare 超時（{timeout}s）", flush=True)
    return False


async def scrape_product(page, item):
    """Visit a single iHerb product page and extract all data."""
    result = {
        "name": item["name"],
        "url": item["url"],
        "status": None,
        "data": {},
    }

    try:
        resp = await page.goto(item["url"], wait_until="domcontentloaded", timeout=30000)

        if resp and resp.status == 403:
            # Might be Cloudflare challenge — wait for it
            passed = await wait_for_cloudflare(page)
            if not passed:
                result["status"] = "CLOUDFLARE_BLOCKED"
                return result

        if resp and resp.status >= 400:
            result["status"] = f"HTTP {resp.status}"
            return result

        # Wait for page to fully render
        await page.wait_for_timeout(3000)

        # Try to wait for product content
        try:
            await page.wait_for_selector("h1", timeout=10000)
        except Exception:
            pass

        # Strategy 1: __NEXT_DATA__
        next_data = await extract_next_data(page)
        next_info = extract_product_from_next_data(next_data)

        # Strategy 2: JSON-LD
        json_ld = await extract_json_ld(page)
        ld_info = extract_product_from_json_ld(json_ld)

        # Strategy 3: DOM fallback
        dom_info = await extract_dom_data(page)

        # Merge (priority: JSON-LD > NEXT_DATA > DOM)
        merged = {}
        for d in [dom_info, next_info, ld_info]:
            for k, v in d.items():
                if v and (k not in merged or not merged[k]):
                    merged[k] = v

        result["data"] = merged
        result["status"] = "OK" if merged.get("title") or merged.get("price") else "NO_DATA"

        # Store raw sources for debugging
        if next_data:
            # Only store pageProps keys, not the full blob
            result["_sources"] = {"next_data_keys": list(next_data.get("props", {}).get("pageProps", {}).keys())}
        if json_ld:
            result["_json_ld_types"] = [
                item.get("@type", "unknown") if isinstance(item, dict) else "array"
                for item in json_ld
            ]

    except Exception as e:
        result["status"] = f"ERROR: {str(e)[:200]}"

    return result


async def main():
    print("=" * 60)
    print("iHerb 產品頁面爬取（Playwright + Stealth）")
    print("=" * 60)

    async with async_playwright() as p:
        # Launch with stealth-friendly settings
        browser = await p.chromium.launch(
            headless=True,
            args=[
                "--disable-blink-features=AutomationControlled",
                "--disable-features=IsolateOrigins,site-per-process",
                "--no-sandbox",
                "--disable-setuid-sandbox",
                "--disable-dev-shm-usage",
                "--disable-accelerated-2d-canvas",
                "--disable-gpu",
            ],
        )

        context = await browser.new_context(
            locale="zh-TW",
            timezone_id="Asia/Taipei",
            user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
            viewport={"width": 1440, "height": 900},
            java_script_enabled=True,
            # Extra HTTP headers
            extra_http_headers={
                "Accept-Language": "zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7",
                "Sec-CH-UA": '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
                "Sec-CH-UA-Mobile": "?0",
                "Sec-CH-UA-Platform": '"macOS"',
            },
        )

        # Apply stealth patches to the context
        stealth = Stealth(
            navigator_languages_override=("zh-TW", "zh"),
            navigator_platform_override="MacIntel",
            navigator_vendor_override="Google Inc.",
        )
        await stealth.apply_stealth_async(context)

        page = await context.new_page()

        # Step 1: Visit homepage to get cf_clearance cookie
        print("\n[1/2] 訪問 iHerb 首頁取得 Cloudflare cookie...", flush=True)
        try:
            await page.goto("https://tw.iherb.com/", wait_until="domcontentloaded", timeout=30000)
            passed = await wait_for_cloudflare(page)
            if passed:
                # Let cookies settle
                delay = random.uniform(3, 5)
                print(f"  等待 {delay:.1f}s 後開始爬取...", flush=True)
                await page.wait_for_timeout(int(delay * 1000))

                # Print cookies for debugging
                cookies = await context.cookies()
                cf_cookies = [c["name"] for c in cookies if "cf" in c["name"].lower()]
                print(f"  Cloudflare cookies: {cf_cookies}", flush=True)
            else:
                print("  首頁 Cloudflare 未通過，仍嘗試繼續...", flush=True)
        except Exception as e:
            print(f"  首頁載入失敗: {e}", flush=True)

        # Step 2: Scrape each product page
        print(f"\n[2/2] 開始爬取 {len(IHERB_URLS)} 個產品頁面...\n", flush=True)
        results = []

        for i, item in enumerate(IHERB_URLS):
            print(f"[{i+1}/{len(IHERB_URLS)}] {item['name']}", flush=True)

            result = await scrape_product(page, item)
            results.append(result)

            # Print summary
            d = result["data"]
            print(f"  Status: {result['status']}")
            if d.get("title"):
                print(f"  Title:  {d['title']}")
            if d.get("price"):
                price = d["price"]
                currency = d.get("currency", "")
                print(f"  Price:  {currency}{price}")
            if d.get("brand"):
                print(f"  Brand:  {d['brand']}")
            if d.get("nutrition_lines"):
                lines = d["nutrition_lines"].split("\n")[:5]
                for l in lines:
                    print(f"    {l[:80]}")

            # Random delay between requests (5-12 seconds)
            if i < len(IHERB_URLS) - 1:
                delay = random.uniform(5, 12)
                print(f"  等待 {delay:.1f}s...\n", flush=True)
                await page.wait_for_timeout(int(delay * 1000))

        await browser.close()

    # Save results
    out_path = "/home/noah/project/nutrient/iherb_verification.json"
    with open(out_path, "w") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)
    print(f"\n結果已存到 {out_path}")

    # Summary table
    print("\n" + "=" * 60)
    print("摘要")
    print("=" * 60)
    ok = sum(1 for r in results if r["status"] == "OK")
    print(f"成功: {ok}/{len(results)}")
    for r in results:
        status_icon = "✓" if r["status"] == "OK" else "✗"
        price = r["data"].get("price", "N/A")
        title = (r["data"].get("title", "")[:30] + "...") if r["data"].get("title") else "N/A"
        print(f"  {status_icon} {r['name']:<20} {r['status']:<20} {price}")


if __name__ == "__main__":
    asyncio.run(main())
