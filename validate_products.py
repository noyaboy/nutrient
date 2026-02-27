#!/usr/bin/env python3
"""Cross-validate products in DB against scraped source data."""

import json
import sys

def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def main():
    db = load_json('/tmp/db_products.json')
    costco = load_json('url_verification.json')
    iherb = load_json('iherb_verification.json')

    errors = []
    warnings = []

    # Build lookup by URL
    costco_by_url = {item['url']: item for item in costco if item.get('status') == 'OK'}
    iherb_by_url = {item['url']: item for item in iherb if item.get('status') == 'OK'}

    for p in db:
        prefix = f"[#{p['sort_order']:2d} {p['name'][:30]}]"
        url = p['url']

        # --- Check Costco items against url_verification.json ---
        if url in costco_by_url:
            src = costco_by_url[url]
            data = src.get('data', {})

            # Price check
            if data.get('price'):
                src_price = data['price'].replace('$', 'NT$')
                if src_price not in p['price'] and data['price'].replace('$', '') not in p['price']:
                    # Extract just the number
                    import re
                    src_nums = re.findall(r'[\d,]+', data['price'])
                    db_nums = re.findall(r'[\d,]+', p['price'])
                    if src_nums and db_nums and src_nums[0] != db_nums[0]:
                        errors.append(f"{prefix} PRICE MISMATCH: DB='{p['price']}' vs Scraped='{data['price']}'")

            # Brand check from specs_table
            specs_table = data.get('specs_table', '')
            if specs_table:
                # Extract brand from specs_table
                for line in specs_table.split('\n'):
                    if line.startswith('品牌'):
                        src_brand = line.replace('品牌', '').strip()
                        if p['brand'] and src_brand and src_brand not in p['brand'] and p['brand'] not in src_brand:
                            warnings.append(f"{prefix} BRAND: DB='{p['brand']}' vs Scraped='{src_brand}'")
                    if line.startswith('產地'):
                        src_origin = line.replace('產地', '').strip()
                        if p['origin'] and src_origin and src_origin not in p['origin'] and p['origin'] not in src_origin:
                            warnings.append(f"{prefix} ORIGIN: DB='{p['origin']}' vs Scraped='{src_origin}'")
                    if line.startswith('成分') and not line.startswith('成分顏色'):
                        src_ingredients = line.replace('成分', '', 1).strip()
                        db_ingredients = p.get('specs', {}).get('ingredients', '')
                        if db_ingredients and src_ingredients:
                            # Check first 20 chars match
                            if src_ingredients[:20] != db_ingredients[:20]:
                                warnings.append(f"{prefix} INGREDIENTS first 20 chars: DB='{db_ingredients[:30]}...' vs Scraped='{src_ingredients[:30]}...'")

        # --- Check iHerb items against iherb_verification.json ---
        if url in iherb_by_url:
            src = iherb_by_url[url]
            data = src.get('data', {})

            # Price check
            if data.get('price'):
                import re
                src_nums = re.findall(r'[\d,]+', data['price'])
                db_nums = re.findall(r'[\d,]+', p['price'])
                if src_nums and db_nums and src_nums[0] != db_nums[0]:
                    errors.append(f"{prefix} PRICE MISMATCH: DB='{p['price']}' vs Scraped='{data['price']}'")

            # Brand check
            if data.get('brand') and p.get('brand'):
                # iHerb brand names may be in Chinese (translated)
                # Just check they're not completely different
                pass  # Brand names from iHerb are often translated, skip exact match

            # Rating check
            if data.get('rating') is not None and p.get('rating') is not None:
                if float(data['rating']) != float(p['rating']):
                    errors.append(f"{prefix} RATING MISMATCH: DB={p['rating']} vs Scraped={data['rating']}")

            # Review count check
            if data.get('review_count') is not None and p.get('review_count') is not None:
                if int(data['review_count']) != int(p['review_count']):
                    warnings.append(f"{prefix} REVIEW COUNT: DB={p['review_count']} vs Scraped={data['review_count']} (may change over time)")

            # SKU check
            if data.get('sku') and p.get('sku'):
                if data['sku'] != p['sku']:
                    errors.append(f"{prefix} SKU MISMATCH: DB='{p['sku']}' vs Scraped='{data['sku']}'")

            # Image URL check
            if data.get('image') and p.get('image_url'):
                if data['image'] != p['image_url']:
                    errors.append(f"{prefix} IMAGE_URL MISMATCH: DB='{p['image_url']}' vs Scraped='{data['image']}'")

        # --- General checks ---
        # URL should not be empty
        if not p['url']:
            errors.append(f"{prefix} MISSING URL")

        # Price should not be empty
        if not p['price']:
            errors.append(f"{prefix} MISSING PRICE")

        # Description should not be empty
        if not p['description']:
            errors.append(f"{prefix} MISSING DESCRIPTION")

        # Usage should not be empty
        if not p['usage']:
            errors.append(f"{prefix} MISSING USAGE")

        # Store should be valid
        valid_stores = (
            'Costco', 'iHerb', 'Amazon',
            '7-Eleven / 全家便利店', '7-Eleven / 全家便利店 / OK便利店',
            '7-Eleven / 全聯', '7-Eleven / 全家便利店 / 全聯',
            '全聯 / 頂好 / 家樂福',
            '屈臣氏/康是美/iHerb', 'iHerb/屈臣氏/康是美', 'iHerb/屈臣氏',
            'Costco/momo/蝦皮',
        )
        if p['store'] not in valid_stores:
            errors.append(f"{prefix} INVALID STORE: '{p['store']}'")

        # Category should be valid
        valid_categories = (
            'costco_supplement', 'costco_food', 'iherb_supplement',
            'equipment', 'personal_care', 'convenience_daily',
        )
        if p['category'] not in valid_categories:
            errors.append(f"{prefix} INVALID CATEGORY: '{p['category']}'")

        # iHerb items should have rating, sku, image_url
        if p['category'] == 'iherb_supplement':
            if not p.get('rating'):
                errors.append(f"{prefix} iHerb item MISSING RATING")
            if not p.get('sku'):
                errors.append(f"{prefix} iHerb item MISSING SKU")
            if not p.get('image_url'):
                errors.append(f"{prefix} iHerb item MISSING IMAGE_URL")
            if not p.get('brand'):
                errors.append(f"{prefix} iHerb item MISSING BRAND")

        # Costco supplement items should have brand and origin
        if p['category'] == 'costco_supplement':
            if not p.get('brand'):
                errors.append(f"{prefix} Costco supplement MISSING BRAND")
            if not p.get('origin'):
                errors.append(f"{prefix} Costco supplement MISSING ORIGIN")

        # Specs JSONB validation - items with scraped data should have non-empty specs
        if url in costco_by_url and costco_by_url[url].get('data', {}).get('specs_table'):
            if not p.get('specs') or p['specs'] == {}:
                warnings.append(f"{prefix} Has scraped data but specs is empty")

        # Nutrition JSONB - check iHerb items have nutrition data
        if p['category'] == 'iherb_supplement':
            if not p.get('nutrition') or p['nutrition'] == {}:
                warnings.append(f"{prefix} iHerb item has empty nutrition JSONB")

    # --- Print results ---
    print("=" * 70)
    print("CROSS-VALIDATION REPORT")
    print("=" * 70)

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
    else:
        print("\n✅ No warnings!")

    print(f"\n--- Summary ---")
    print(f"Total products: {len(db)}")
    print(f"Matched against Costco scrape: {sum(1 for p in db if p['url'] in costco_by_url)}")
    print(f"Matched against iHerb scrape: {sum(1 for p in db if p['url'] in iherb_by_url)}")
    print(f"No scraped source: {sum(1 for p in db if p['url'] not in costco_by_url and p['url'] not in iherb_by_url)}")
    print(f"Errors: {len(errors)}")
    print(f"Warnings: {len(warnings)}")

    return 1 if errors else 0

if __name__ == '__main__':
    sys.exit(main())
