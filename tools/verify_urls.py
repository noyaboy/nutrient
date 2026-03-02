"""
Verify all shopping item URLs using Playwright.
Extracts: product name, price, weight, servings, nutritional info, full specs.
"""

import asyncio
import json
import re
from playwright.async_api import async_playwright

URLS = [
    # Costco 保健品 (4)
    {"category": "Costco 保健品", "name": "緩釋魚油", "url": "https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Enteric-Omega-3-Fish-Oil-180-Softgel/p/240669"},
    {"category": "Costco 保健品", "name": "鈣+D3+K2", "url": "https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453"},
    {"category": "Costco 保健品", "name": "維他命C", "url": "https://www.costco.com.tw/Health-Beauty/Supplements/Multi-Letter-Vitamins/Kirkland-Signature-Vitamin-C-500-mg-500-Tablet/p/684654"},
    {"category": "Costco 保健品", "name": "乳清蛋白 Tryall", "url": "https://www.costco.com.tw/Health-Beauty/Supplements/Sports-Performance/Tryall-Whey-Protein-Isolate-Unflavored-2-kg/p/155648"},
    # Costco 食材 - only specific product URLs (skip category pages)
    {"category": "Costco 食材", "name": "平飼雞蛋", "url": "https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/QUAN-YOU-FARM-Cage-Free-Eggs-LL-30-Count/p/128970"},
    {"category": "Costco 食材", "name": "冷凍鮭魚排", "url": "https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/Kirkland-Signature-Frozen-Atlantic-Salmon-136-kg/p/1286092"},
    {"category": "Costco 食材", "name": "冷凍綠花椰菜", "url": "https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Fruits-Vegetables/Natures-Touch-Frozen-Broccoli-454-g-X-4-Pack/p/122199"},
    {"category": "Costco 食材", "name": "碘鹽", "url": "https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/Uni-President-Iodized-Solar-Sea-Salt-2-kg/p/283283"},
    {"category": "Costco 食材", "name": "綜合堅果", "url": "https://www.costco.com.tw/Food-Dining/Snacks/Nuts-Jerky/Kirkland-Signature-Mixed-Nuts-113-kg/p/1669722"},
    {"category": "Costco 食材", "name": "希臘優格", "url": "https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/Kirkland-Signature-Chilled-Nonfat-Greek-Yogurt-907-g-X-2-Count/p/599369"},
    {"category": "Costco 食材", "name": "泡菜", "url": "https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/JONGGA-Sliced-Kimchi-120-g-X-6-Pack/p/137728"},
    {"category": "Costco 食材", "name": "燕麥", "url": "https://www.costco.com.tw/Food-Dining/Drinks/Powdered-Drink-Mix-Cereal-Oats/Quaker-Organic-Whole-Oats-935-g-X-2-Count/p/116958"},
    {"category": "Costco 食材", "name": "雞胸肉", "url": "https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/DaChan-Taiwan-Frozen-Chicken-Breast-25-kg-X-2-Count/p/133602"},
    {"category": "Costco 食材", "name": "糙米", "url": "https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Greenme-Organic-Brown-Rice-3-kg/p/124095"},
]


async def scrape_costco(page):
    """Extract detailed info from a Costco product page."""
    info = {}

    # Product title (h1)
    try:
        el = await page.query_selector("h1")
        if el:
            info["title"] = (await el.inner_text()).strip()
    except:
        pass

    # Price
    try:
        for sel in [".notranslate", ".price", ".product-price"]:
            el = await page.query_selector(sel)
            if el:
                text = (await el.inner_text()).strip()
                if "$" in text or any(c.isdigit() for c in text):
                    info["price_raw"] = text.replace("\n", " | ")
                    # Extract just the number
                    m = re.search(r'\$[\d,]+', text)
                    if m:
                        info["price"] = m.group()
                    break
    except:
        pass

    # Product description / specs - get ALL text from description area
    try:
        # Costco uses various containers for product details
        for sel in [
            ".product-details-content",
            ".product-description",
            "#defined-tabs-content",
            ".tab-content",
            ".product-details",
            "#productDescription",
        ]:
            els = await page.query_selector_all(sel)
            for el in els:
                text = (await el.inner_text()).strip()
                if text and len(text) > 20:
                    info["description"] = text[:3000]
                    break
            if "description" in info:
                break
    except:
        pass

    # Try to get the structured specs table
    try:
        rows = await page.query_selector_all("table tr, .spec-row, .attribute-row")
        specs = []
        for row in rows:
            text = (await row.inner_text()).strip()
            if text:
                specs.append(text)
        if specs:
            info["specs_table"] = "\n".join(specs[:50])
    except:
        pass

    # Get ALL visible text that might contain nutrition info
    try:
        body_text = await page.inner_text("body")
        # Look for nutrition-related keywords
        nutrition_keywords = ["熱量", "蛋白質", "脂肪", "碳水", "鈉", "糖", "膳食纖維",
                              "EPA", "DHA", "維生素", "維他命", "鈣", "Calories", "Protein",
                              "營養標示", "營養成分", "每份", "份量", "每100"]
        relevant_lines = []
        for line in body_text.split("\n"):
            line = line.strip()
            if line and any(kw in line for kw in nutrition_keywords):
                relevant_lines.append(line)
        if relevant_lines:
            info["nutrition_lines"] = "\n".join(relevant_lines[:40])
    except:
        pass

    return info


async def scrape_iherb(page):
    """Extract detailed info from an iHerb product page."""
    info = {}

    # Product title
    try:
        for sel in ["h1", "[data-testid='product-title']", ".product-title"]:
            el = await page.query_selector(sel)
            if el:
                text = (await el.inner_text()).strip()
                if text and len(text) > 3:
                    info["title"] = text
                    break
    except:
        pass

    # Price
    try:
        for sel in [
            "[data-testid='product-price']",
            ".product-price",
            "#price",
            "section .price",
            "b.s24",
        ]:
            el = await page.query_selector(sel)
            if el:
                text = (await el.inner_text()).strip()
                if any(c.isdigit() for c in text):
                    info["price"] = text
                    break
    except:
        pass

    # Supplement facts / nutrition
    try:
        body_text = await page.inner_text("body")

        # Look for supplement facts section
        nutrition_keywords = [
            "份量", "Serving Size", "每份", "Amount Per Serving",
            "營養成分", "Supplement Facts", "Nutrition Facts",
            "蛋白質", "Protein", "脂肪", "Fat", "碳水", "Carb",
            "熱量", "Calories", "鈣", "Calcium", "維生素", "Vitamin",
            "EPA", "DHA", "鎂", "Magnesium", "鋅", "Zinc", "銅", "Copper",
            "肌酸", "Creatine", "茶氨酸", "Theanine", "葉黃素", "Lutein",
            "mg", "mcg", "IU", "g ",
        ]
        relevant_lines = []
        for line in body_text.split("\n"):
            line = line.strip()
            if line and any(kw in line for kw in nutrition_keywords):
                relevant_lines.append(line)
        if relevant_lines:
            info["nutrition_lines"] = "\n".join(relevant_lines[:60])

        # Also grab product overview / description
        desc_keywords = ["產品描述", "說明", "建議用量", "其他成份", "注意事項",
                         "Description", "Suggested Use", "Other Ingredients"]
        desc_lines = []
        for line in body_text.split("\n"):
            line = line.strip()
            if line and any(kw in line for kw in desc_keywords):
                desc_lines.append(line)
        if desc_lines:
            info["description_lines"] = "\n".join(desc_lines[:30])
    except:
        pass

    return info


async def check_url(context, item):
    """Visit a URL and extract all product details."""
    url = item["url"]
    result = {
        "category": item["category"],
        "name": item["name"],
        "url": url,
        "status": None,
        "data": {},
    }

    page = await context.new_page()
    try:
        resp = await page.goto(url, wait_until="domcontentloaded", timeout=25000)
        if resp and resp.status >= 400:
            result["status"] = f"HTTP {resp.status}"
            await page.close()
            return result

        # Wait longer for JS rendering
        await page.wait_for_timeout(5000)

        if "costco.com.tw" in url:
            result["data"] = await scrape_costco(page)
        elif "iherb.com" in url:
            result["data"] = await scrape_iherb(page)

        result["status"] = "OK" if result["data"].get("title") else "NO_DATA"

    except Exception as e:
        result["status"] = f"ERROR: {str(e)[:100]}"

    await page.close()
    return result


async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context(
            locale="zh-TW",
            user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36",
            viewport={"width": 1280, "height": 900},
        )

        results = []
        for item in URLS:
            print(f"[{item['category']}] {item['name']} ...", flush=True)
            result = await check_url(context, item)
            results.append(result)

            d = result["data"]
            title = d.get("title", "N/A")
            price = d.get("price", d.get("price_raw", "N/A"))
            print(f"  Status: {result['status']}")
            print(f"  Title:  {title}")
            print(f"  Price:  {price}")
            if d.get("nutrition_lines"):
                lines = d["nutrition_lines"].split("\n")[:8]
                for l in lines:
                    print(f"    {l}")
            print()

        await browser.close()

        # Save full JSON
        out_path = "/home/noah/project/nutrient/url_verification.json"
        with open(out_path, "w") as f:
            json.dump(results, f, ensure_ascii=False, indent=2)
        print(f"\nFull results saved to {out_path}")


if __name__ == "__main__":
    asyncio.run(main())
