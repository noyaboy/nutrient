#!/usr/bin/env python3
"""Deep cross-validation: DB products vs original page.tsx hardcoded values + scraped JSONB data."""

import json
import re
import sys

def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def parse_tsx_items(tsx_path):
    """Parse all ShoppingItem objects from the original page.tsx."""
    with open(tsx_path, 'r', encoding='utf-8') as f:
        content = f.read()

    items = []
    # Find all object literals within arrays
    # Pattern: { name: '...', description: '...', usage: '...', price: '...', url: '...', store: '...' }
    pattern = re.compile(
        r"\{\s*name:\s*['\"](.+?)['\"],\s*"
        r"description:\s*['\"](.+?)['\"],\s*"
        r"usage:\s*['\"](.+?)['\"],\s*"
        r"price:\s*['\"](.+?)['\"],\s*"
        r"url:\s*['\"](.+?)['\"],\s*"
        r"store:\s*['\"](.+?)['\"],?\s*\}",
        re.DOTALL
    )

    # Simpler approach: extract line by line
    in_item = False
    current = {}
    for line in content.split('\n'):
        line = line.strip()
        if line == '{':
            in_item = True
            current = {}
        elif line.startswith('},') or line == '},' or line == '}':
            if in_item and current.get('name'):
                items.append(current)
            in_item = False
            current = {}
        elif in_item:
            for field in ['name', 'description', 'usage', 'price', 'url', 'store']:
                m = re.match(rf"{field}:\s*['\"`](.+?)['\"`],?\s*$", line)
                if not m:
                    # Handle template literals or escaped quotes
                    m = re.match(rf"{field}:\s*'(.*)',?\s*$", line)
                if m:
                    val = m.group(1)
                    # Unescape
                    val = val.replace("\\'", "'")
                    current[field] = val

    return items

def main():
    db = load_json('/tmp/db_products.json')
    tsx_items = parse_tsx_items('/tmp/original_page.tsx')
    iherb = load_json('iherb_verification.json')
    costco = load_json('url_verification.json')

    errors = []
    warnings = []
    info = []

    print("=" * 70)
    print("DEEP CROSS-VALIDATION: DB vs Original page.tsx + Scraped Sources")
    print("=" * 70)

    # Build DB lookup by name (first 10 chars for fuzzy match)
    db_by_url = {p['url']: p for p in db}

    # 1. Check every original tsx item exists in DB with correct data
    print(f"\n--- Part 1: Original page.tsx ({len(tsx_items)} items) vs DB ---")
    matched = 0
    for tsx in tsx_items:
        url = tsx.get('url', '')
        db_item = db_by_url.get(url)

        if not db_item:
            errors.append(f"MISSING IN DB: '{tsx['name']}' (url: {url})")
            continue

        matched += 1
        prefix = f"[{db_item['sort_order']:2d}]"

        # Compare each field
        if tsx['name'] != db_item['name']:
            errors.append(f"{prefix} NAME: tsx='{tsx['name']}' vs DB='{db_item['name']}'")

        if tsx['description'] != db_item['description']:
            errors.append(f"{prefix} DESCRIPTION mismatch:\n      tsx: '{tsx['description'][:80]}...'\n      DB:  '{db_item['description'][:80]}...'")

        if tsx['usage'] != db_item['usage']:
            errors.append(f"{prefix} USAGE: tsx='{tsx['usage']}' vs DB='{db_item['usage']}'")

        if tsx['price'] != db_item['price']:
            errors.append(f"{prefix} PRICE: tsx='{tsx['price']}' vs DB='{db_item['price']}'")

        if tsx['store'] != db_item['store']:
            errors.append(f"{prefix} STORE: tsx='{tsx['store']}' vs DB='{db_item['store']}'")

    print(f"  Matched: {matched}/{len(tsx_items)}")

    # 2. Check iHerb JSONB data against scraped source
    print(f"\n--- Part 2: iHerb JSONB data vs iherb_verification.json ---")
    iherb_by_url = {item['url']: item for item in iherb if item.get('status') == 'OK'}

    for p in db:
        if p['category'] != 'iherb_supplement':
            continue
        prefix = f"[#{p['sort_order']} {p['name'][:25]}]"

        src = iherb_by_url.get(p['url'])
        if not src:
            warnings.append(f"{prefix} No iHerb scraped data found")
            continue

        data = src.get('data', {})

        # Check rating
        if data.get('rating') is not None:
            db_rating = float(p['rating']) if p['rating'] else None
            if db_rating != float(data['rating']):
                errors.append(f"{prefix} RATING: DB={db_rating} vs Scraped={data['rating']}")
            else:
                info.append(f"{prefix} Rating ✓ ({db_rating})")

        # Check review_count
        if data.get('review_count') is not None:
            if int(p['review_count'] or 0) != int(data['review_count']):
                warnings.append(f"{prefix} REVIEW_COUNT: DB={p['review_count']} vs Scraped={data['review_count']}")
            else:
                info.append(f"{prefix} Review count ✓ ({p['review_count']})")

        # Check SKU
        if data.get('sku'):
            if p['sku'] != data['sku']:
                errors.append(f"{prefix} SKU: DB='{p['sku']}' vs Scraped='{data['sku']}'")
            else:
                info.append(f"{prefix} SKU ✓ ({p['sku']})")

        # Check image_url
        if data.get('image'):
            if p['image_url'] != data['image']:
                errors.append(f"{prefix} IMAGE: DB='{p['image_url']}' vs Scraped='{data['image']}'")
            else:
                info.append(f"{prefix} Image URL ✓")

        # Check price
        if data.get('price'):
            src_price_num = re.findall(r'[\d,]+', data['price'])
            db_price_num = re.findall(r'[\d,]+', p['price'])
            if src_price_num and db_price_num and src_price_num[0] != db_price_num[0]:
                errors.append(f"{prefix} PRICE: DB='{p['price']}' vs Scraped='{data['price']}'")
            else:
                info.append(f"{prefix} Price ✓ ({p['price']})")

    # 3. Check Costco JSONB data against scraped source
    print(f"\n--- Part 3: Costco specs JSONB vs url_verification.json ---")
    costco_by_url = {item['url']: item for item in costco if item.get('status') == 'OK'}

    for p in db:
        if p['url'] not in costco_by_url:
            continue
        prefix = f"[#{p['sort_order']} {p['name'][:25]}]"
        src = costco_by_url[p['url']]
        data = src.get('data', {})
        specs_table = data.get('specs_table', '')

        if not specs_table:
            continue

        # Parse specs_table into key-value pairs
        parsed = {}
        for line in specs_table.split('\n'):
            for key in ['產地', '品牌', '成分', '保存方式', '過敏原資訊', '劑型', '內容量/入數', '商品重量']:
                if line.startswith(key):
                    parsed[key] = line[len(key):].strip()

        # Validate origin
        if parsed.get('產地') and p.get('origin'):
            if parsed['產地'] not in p['origin'] and p['origin'] not in parsed['產地']:
                warnings.append(f"{prefix} ORIGIN: DB='{p['origin']}' vs Scraped='{parsed['產地']}'")
            else:
                info.append(f"{prefix} Origin ✓ ({p['origin']})")

        # Validate price
        if data.get('price'):
            src_nums = re.findall(r'[\d,]+', data['price'])
            db_nums = re.findall(r'[\d,]+', p['price'])
            if src_nums and db_nums and src_nums[0] != db_nums[0]:
                errors.append(f"{prefix} PRICE: DB='{p['price']}' vs Scraped='{data['price']}'")
            else:
                info.append(f"{prefix} Price ✓ ({p['price']})")

        # Validate specs JSONB has ingredients if source has them
        if parsed.get('成分') and p.get('specs', {}).get('ingredients'):
            db_ing = p['specs']['ingredients'][:30]
            # Strip possible "成分:" or "成份:" prefix from source
            src_ing = re.sub(r'^成[分份][：:]?\s*', '', parsed['成分'])[:30]
            if src_ing[:15] != db_ing[:15]:
                warnings.append(f"{prefix} INGREDIENTS: DB starts '{db_ing}' vs Scraped starts '{src_ing}'")
            else:
                info.append(f"{prefix} Ingredients ✓")

        # Validate storage
        if parsed.get('保存方式') and p.get('specs', {}).get('storage'):
            if parsed['保存方式'][:15] != p['specs']['storage'][:15]:
                warnings.append(f"{prefix} STORAGE: DB='{p['specs']['storage'][:40]}' vs Scraped='{parsed['保存方式'][:40]}'")
            else:
                info.append(f"{prefix} Storage ✓")

    # 4. Check for items in DB not in original tsx
    print(f"\n--- Part 4: DB items not in original page.tsx ---")
    tsx_urls = {item['url'] for item in tsx_items}
    for p in db:
        if p['url'] not in tsx_urls:
            errors.append(f"[#{p['sort_order']}] IN DB BUT NOT IN ORIGINAL TSX: '{p['name']}'")

    # --- Print results ---
    print("\n" + "=" * 70)
    if errors:
        print(f"\n❌ ERRORS ({len(errors)}):")
        for e in errors:
            print(f"  {e}")
    else:
        print("\n✅ No errors found!")

    if warnings:
        print(f"\n⚠️  WARNINGS ({len(warnings)}):")
        for w in warnings:
            print(f"  {w}")

    print(f"\n✅ VERIFIED ({len(info)}):")
    for i in info:
        print(f"  {i}")

    print(f"\n--- Final Summary ---")
    print(f"Products in DB: {len(db)}")
    print(f"Products in original tsx: {len(tsx_items)}")
    print(f"Matched tsx→DB: {matched}")
    print(f"Errors: {len(errors)}")
    print(f"Warnings: {len(warnings)}")
    print(f"Verified fields: {len(info)}")

    return 1 if errors else 0

if __name__ == '__main__':
    sys.exit(main())
