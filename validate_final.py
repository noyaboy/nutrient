#!/usr/bin/env python3
"""Final validation: match by name, handle shared URLs."""

import json
import re
import sys

def load_json(path):
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def parse_tsx_items(tsx_path):
    """Parse ShoppingItem objects from page.tsx."""
    with open(tsx_path, 'r', encoding='utf-8') as f:
        content = f.read()

    items = []
    in_item = False
    current = {}
    for line in content.split('\n'):
        line = line.strip()
        if line == '{':
            in_item = True
            current = {}
        elif line.startswith('},') or line == '},':
            if in_item and current.get('name'):
                items.append(current)
            in_item = False
            current = {}
        elif in_item:
            for field in ['name', 'description', 'usage', 'price', 'url', 'store']:
                m = re.match(rf"{field}:\s*'(.*)',?\s*$", line)
                if m:
                    val = m.group(1).replace("\\'", "'")
                    current[field] = val
    return items

def main():
    db = load_json('/tmp/db_products.json')
    tsx_items = parse_tsx_items('/tmp/original_page.tsx')

    errors = []
    warnings = []

    # Match by name (exact match)
    db_by_name = {p['name']: p for p in db}

    print("=" * 70)
    print("FINAL VALIDATION: All 31 items field-by-field")
    print("=" * 70)

    unmatched_tsx = []
    for tsx in tsx_items:
        name = tsx['name']
        db_item = db_by_name.get(name)

        if not db_item:
            unmatched_tsx.append(name)
            continue

        prefix = f"[#{db_item['sort_order']:2d}]"

        for field in ['name', 'description', 'usage', 'price', 'url', 'store']:
            tsx_val = tsx.get(field, '')
            db_val = db_item.get(field, '')
            if tsx_val != db_val:
                errors.append(f"{prefix} {field.upper()}: tsx='{tsx_val[:60]}' vs DB='{db_val[:60]}'")

    if unmatched_tsx:
        for name in unmatched_tsx:
            errors.append(f"TSX item not found in DB by name: '{name}'")

    # Check for DB items not in tsx
    tsx_names = {item['name'] for item in tsx_items}
    for p in db:
        if p['name'] not in tsx_names:
            errors.append(f"DB item not in original tsx: #{p['sort_order']} '{p['name']}'")

    # Print results
    if errors:
        print(f"\n❌ ERRORS ({len(errors)}):")
        for e in errors:
            print(f"  {e}")
    else:
        print(f"\n✅ ALL 31 ITEMS: name, description, usage, price, url, store — PERFECT MATCH")

    print(f"\nMatched: {len(tsx_items) - len(unmatched_tsx)}/{len(tsx_items)}")
    return 1 if errors else 0

if __name__ == '__main__':
    sys.exit(main())
