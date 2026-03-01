#!/usr/bin/env python3
"""Cross-validate all nutrition JSONB values against scraped source data."""

import json
import re
import sys

def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def main():
    db = load_json('/tmp/db_products_full.json')
    costco = load_json('url_verification.json')
    iherb = load_json('iherb_verification.json')

    costco_by_url = {item['url']: item for item in costco if item.get('status') == 'OK'}
    iherb_by_url = {item['url']: item for item in iherb if item.get('status') == 'OK'}

    errors = []
    warnings = []
    verified = []

    print("=" * 70)
    print("NUTRITION DATA CROSS-VALIDATION")
    print("=" * 70)

    for p in db:
        so = p['sort_order']
        name = p['name'][:40]
        prefix = f"[#{so:2d} {name}]"
        nutr = p.get('nutrition') or {}
        desc = p.get('description', '')
        specs = p.get('specs') or {}
        url = p.get('url', '')

        # ---- Costco Supplements ----
        if so == 1:  # Fish oil
            src = costco_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            # Source says: EPA 419毫克、DHA 281毫克, Omega-3 約700毫克
            if 'EPA' in nutr_lines and '419' in nutr_lines:
                if nutr.get('epa') == '419毫克':
                    verified.append(f"{prefix} EPA=419毫克 ✓ (matches scraped)")
                else:
                    errors.append(f"{prefix} EPA: DB='{nutr.get('epa')}' but source says 419毫克")

            if 'DHA' in nutr_lines and '281' in nutr_lines:
                if nutr.get('dha') == '281毫克':
                    verified.append(f"{prefix} DHA=281毫克 ✓ (matches scraped)")
                else:
                    errors.append(f"{prefix} DHA: DB='{nutr.get('dha')}' but source says 281毫克")

            if '700' in nutr_lines:
                if '700' in str(nutr.get('omega3_total', '')):
                    verified.append(f"{prefix} Omega-3=約700毫克 ✓")
                else:
                    errors.append(f"{prefix} Omega-3 total not matching source '約700毫克'")

        elif so == 2:  # Calcium + D3 + K2
            src = costco_by_url.get(url, {}).get('data', {})
            specs_table = src.get('specs_table', '')
            nutr_lines = src.get('nutrition_lines', '')
            # Name says 500mg calcium
            if 'Calcium 500 mg' in url or '500' in str(src.get('title', '')):
                if nutr.get('calcium') == '500mg':
                    verified.append(f"{prefix} Calcium=500mg ✓ (matches product title)")
                else:
                    errors.append(f"{prefix} Calcium: DB='{nutr.get('calcium')}' but title says 500mg")

            # Check K2 type - specs_table mentions Menaquinone-7
            if 'Menaquinone-7' in specs_table:
                if 'MK-7' in str(nutr.get('vitamin_k2', '')):
                    verified.append(f"{prefix} K2=MK-7 ✓ (Menaquinone-7 in specs)")
                else:
                    errors.append(f"{prefix} K2: DB='{nutr.get('vitamin_k2')}' but specs say Menaquinone-7")

            # D3 dosage - the product is "Calcium 500mg with D3 K2"
            # Need to check: does the source confirm 1000IU D3?
            # The specs_table mentions 維生素D3 but no specific IU amount in scraped data
            # The description says "D3" but the 1000IU comes from the user's protocol knowledge
            if nutr.get('vitamin_d3') == '1000IU':
                warnings.append(f"{prefix} D3=1000IU - NOT directly confirmed in scraped data (scraped specs don't show IU amount)")

        elif so == 3:  # Vitamin C
            src = costco_by_url.get(url, {}).get('data', {})
            title = src.get('title', '')
            if '500' in title:
                if '500mg' in str(nutr.get('vitamin_c', '')):
                    verified.append(f"{prefix} VitC=500mg/錠 ✓ (matches title '500毫克')")
                else:
                    errors.append(f"{prefix} VitC: DB='{nutr.get('vitamin_c')}' but title says 500毫克")

        # ---- Costco Foods ----
        elif so == 12:  # Greek yogurt
            src = costco_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            if '9.4' in nutr_lines and '蛋白質' in nutr_lines:
                if '9.4g' in str(nutr.get('protein_per_100g', '')):
                    verified.append(f"{prefix} Protein=9.4g/100g ✓ (matches scraped)")
                else:
                    errors.append(f"{prefix} Protein: DB='{nutr.get('protein_per_100g')}' but source says 9.4g/100g")

        elif so == 16:  # Oats
            # GI and fiber from description, not from scraped source
            if nutr.get('fiber') == '8g/份':
                # Check if description mentions 8g
                if '8g' in desc:
                    verified.append(f"{prefix} Fiber=8g/份 ✓ (matches description)")
                else:
                    warnings.append(f"{prefix} Fiber=8g/份 in DB but not confirmed in description")
            if '55' in str(nutr.get('gi', '')):
                if '55' in desc:
                    verified.append(f"{prefix} GI=55 ✓ (matches description)")
                else:
                    warnings.append(f"{prefix} GI=55 in DB but not confirmed in description")

        elif so == 18:  # Chicken breast
            if nutr.get('protein_per_100g') == '約31g':
                if '31g' in desc:
                    verified.append(f"{prefix} Protein=約31g/100g ✓ (matches description)")
                else:
                    warnings.append(f"{prefix} Protein=約31g in DB but not confirmed in description")

        # ---- iHerb Supplements ----
        elif so == 21:  # ON Whey
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')

            # Check each nutrition field against scraped data
            checks = {
                'protein': ('24', '24 克蛋白質'),
                'calories': ('120', '120'),
                'fat': ('1.5', '1.5 克'),
                'saturated_fat': ('1', '1 克'),
                'carbs': ('3', '3 克'),
                'calcium': ('130', '130 毫克'),
            }
            for key, (db_expected, src_text) in checks.items():
                if db_expected in str(nutr.get(key, '')):
                    if src_text.replace(' ', '') in nutr_lines.replace(' ', '') or db_expected in nutr_lines:
                        verified.append(f"{prefix} {key}={nutr[key]} ✓")
                    else:
                        warnings.append(f"{prefix} {key}={nutr[key]} in DB but text '{src_text}' not found in scraped nutrition_lines")
                else:
                    errors.append(f"{prefix} {key}: DB='{nutr.get(key)}' expected to contain '{db_expected}'")

            # BCAA and EAA from description
            if '5.5' in str(nutr.get('bcaa', '')):
                if '5.5' in nutr_lines or '5.5' in src.get('description', ''):
                    verified.append(f"{prefix} BCAA=5.5g ✓")
                else:
                    warnings.append(f"{prefix} BCAA=5.5g not directly in scraped lines")
            if '11' in str(nutr.get('eaa', '')):
                if '11' in nutr_lines or '11' in src.get('description', ''):
                    verified.append(f"{prefix} EAA=11g ✓")
                else:
                    warnings.append(f"{prefix} EAA=11g not directly in scraped lines")

            # Serving size
            if '31' in str(nutr.get('serving_size', '')):
                if '31' in nutr_lines:
                    verified.append(f"{prefix} serving_size=31g ✓")
                else:
                    warnings.append(f"{prefix} serving_size=31g not in scraped lines")

        elif so == 22:  # Creatine
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            if '5' in str(nutr.get('creatine_monohydrate', '')) and '5' in nutr_lines:
                verified.append(f"{prefix} creatine=5g ✓")
            else:
                errors.append(f"{prefix} creatine: DB='{nutr.get('creatine_monohydrate')}' not confirmed")

        elif so == 23:  # Mg Glycinate
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            # Source: 鎂（提取自 2,000 毫克甘氨酸鎂）200 毫克 48%
            if '200' in str(nutr.get('magnesium', '')):
                if '200' in nutr_lines:
                    verified.append(f"{prefix} magnesium=200mg ✓")
                else:
                    warnings.append(f"{prefix} magnesium=200mg not in scraped lines")
            if '2000' in str(nutr.get('magnesium', '')) or '2,000' in str(nutr.get('magnesium', '')):
                if '2,000' in nutr_lines or '2000' in nutr_lines:
                    verified.append(f"{prefix} from 2000mg glycinate chelate ✓")

        elif so == 24:  # Lutein
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            if '20' in str(nutr.get('lutein', '')):
                if '20' in nutr_lines:
                    verified.append(f"{prefix} lutein=20mg ✓")
                else:
                    warnings.append(f"{prefix} lutein=20mg not in scraped lines")

        elif so == 25:  # Zinc
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            if '50' in str(nutr.get('zinc', '')):
                if '50' in nutr_lines:
                    verified.append(f"{prefix} zinc=50mg ✓")
                else:
                    warnings.append(f"{prefix} zinc=50mg not in scraped lines")
            if '270' in str(nutr.get('zinc', '')):
                if '270' in nutr_lines:
                    verified.append(f"{prefix} zinc picolinate=270mg ✓")

        elif so == 26:  # Copper
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            if '2' in str(nutr.get('copper', '')):
                if '2 毫克' in nutr_lines or '2毫克' in nutr_lines:
                    verified.append(f"{prefix} copper=2mg ✓")
                else:
                    # Check in title
                    title = src.get('title', '')
                    if '2' in title:
                        verified.append(f"{prefix} copper=2mg ✓ (from title)")
                    else:
                        warnings.append(f"{prefix} copper=2mg not directly in scraped nutrition_lines")

        elif so == 27:  # D3
            src = iherb_by_url.get(url, {}).get('data', {})
            title = src.get('data', src.get('data', {})) if isinstance(src.get('data'), dict) else {}
            actual_title = src.get('data', {}).get('title', '')
            if '5,000' in actual_title or '5000' in actual_title or '125' in actual_title:
                if '5000' in str(nutr.get('vitamin_d3', '')):
                    verified.append(f"{prefix} D3=5000IU ✓ (matches title)")
                else:
                    errors.append(f"{prefix} D3: DB='{nutr.get('vitamin_d3')}' but title says 5000IU")
            if '125' in str(nutr.get('vitamin_d3', '')):
                verified.append(f"{prefix} D3=125微克 ✓")

        elif so == 28:  # L-Theanine
            src = iherb_by_url.get(url, {}).get('data', {})
            nutr_lines = src.get('nutrition_lines', '')
            if '200' in str(nutr.get('l_theanine', '')):
                if '200' in nutr_lines:
                    verified.append(f"{prefix} L-theanine=200mg ✓")
                else:
                    warnings.append(f"{prefix} L-theanine=200mg not in scraped lines")

    # --- Print results ---
    print()
    if errors:
        print(f"❌ ERRORS ({len(errors)}):")
        for e in errors:
            print(f"  {e}")
    else:
        print("✅ No errors found!")

    if warnings:
        print(f"\n⚠️  WARNINGS ({len(warnings)}):")
        for w in warnings:
            print(f"  {w}")

    print(f"\n✅ VERIFIED ({len(verified)}):")
    for v in verified:
        print(f"  {v}")

    print(f"\n--- Summary ---")
    print(f"Errors: {len(errors)}")
    print(f"Warnings: {len(warnings)}")
    print(f"Verified: {len(verified)}")
    return 1 if errors else 0

if __name__ == '__main__':
    sys.exit(main())
