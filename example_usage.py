#!/usr/bin/env python3
"""
Example usage of the Procurement PDF Parser

Demonstrates how to:
1. Parse the procurement PDF
2. Filter products by source
3. Extract nutritional data
4. Cross-reference with supplement schedule
"""

import json
from pathlib import Path
from parse_procurement_pdf import ProcurementPDFParser


def example_1_basic_parsing():
    """Example 1: Basic PDF parsing and output"""
    print("=" * 70)
    print("EXAMPLE 1: Basic PDF Parsing")
    print("=" * 70)

    parser = ProcurementPDFParser('健康長壽追蹤器採購.pdf')
    products = parser.parse_pdf()

    print(f"\nParsed {len(products)} products")
    print(f"\nFirst product:")
    if products:
        first = products[0]
        print(f"  Name: {first.product_name}")
        print(f"  Source: {first.source}")
        print(f"  Brand: {first.brand}")
        print(f"  Quantity: {first.quantity}")
        print(f"  Price: {first.price}")

    # Save to JSON
    parser.save_json('procurement_data.json')


def example_2_filter_by_source():
    """Example 2: Filter products by source"""
    print("\n" + "=" * 70)
    print("EXAMPLE 2: Filter Products by Source")
    print("=" * 70)

    with open('procurement_data.json') as f:
        products = json.load(f)

    # Group by source
    sources = {}
    for product in products:
        source = product.get('source', 'Unknown')
        if source not in sources:
            sources[source] = []
        sources[source].append(product)

    for source, items in sorted(sources.items()):
        print(f"\n{source}: {len(items)} products")
        # Show first 3 products from each source
        for product in items[:3]:
            print(f"  - {product['product_name']}")
            if product.get('price'):
                print(f"    Price: {product['price']}")


def example_3_extract_nutrients():
    """Example 3: Extract and analyze nutrients"""
    print("\n" + "=" * 70)
    print("EXAMPLE 3: Extract and Analyze Nutrients")
    print("=" * 70)

    with open('procurement_data.json') as f:
        products = json.load(f)

    # Find products with Omega-3
    print("\nProducts with Omega-3:")
    omega3_products = [
        p for p in products
        if 'omega3' in p.get('key_nutrients', {})
    ]

    for product in omega3_products[:5]:
        nutrients = product.get('key_nutrients', {})
        omega3_data = nutrients.get('omega3', {})
        print(f"\n  {product['product_name']}")
        print(f"    Source: {product['source']}")
        print(f"    Omega-3: {omega3_data.get('amount')} {omega3_data.get('unit')}")
        if 'epa' in nutrients:
            epa = nutrients['epa']
            print(f"    EPA: {epa.get('amount')} {epa.get('unit')}")
        if 'dha' in nutrients:
            dha = nutrients['dha']
            print(f"    DHA: {dha.get('amount')} {dha.get('unit')}")


def example_4_supplement_schedule_mapping():
    """Example 4: Map to supplement schedule"""
    print("\n" + "=" * 70)
    print("EXAMPLE 4: Supplement Schedule Mapping")
    print("=" * 70)

    with open('procurement_data.json') as f:
        products = json.load(f)

    # Supplement categories we're tracking
    supplement_schedule = {
        'Omega-3': ['omega3'],
        'Magnesium': ['magnesium'],
        'Zinc': ['zinc'],
        'Vitamin D3': ['vitamin_d3', 'vitamin_d'],
        'Vitamin K2': ['vitamin_k2'],
        'Calcium': ['calcium'],
        'Lutein': ['lutein'],
    }

    # Find matching products
    schedule_matched = {}

    for category, nutrient_keys in supplement_schedule.items():
        matching = []
        for product in products:
            nutrients = product.get('key_nutrients', {})
            if any(key in nutrients for key in nutrient_keys):
                matching.append({
                    'name': product['product_name'],
                    'source': product['source'],
                    'brand': product.get('brand'),
                    'quantity': product.get('quantity'),
                    'price': product.get('price'),
                    'nutrients': {k: v for k, v in nutrients.items()
                                if k in nutrient_keys}
                })
        if matching:
            schedule_matched[category] = matching

    # Print schedule
    for category, products_list in sorted(schedule_matched.items()):
        print(f"\n{category}:")
        for product in products_list[:2]:  # Show first 2 per category
            print(f"  • {product['name']}")
            print(f"    Source: {product['source']}")
            print(f"    Quantity: {product['quantity']}")
            if product.get('price'):
                print(f"    Price: {product['price']}")


def example_5_data_validation():
    """Example 5: Validate data quality"""
    print("\n" + "=" * 70)
    print("EXAMPLE 5: Data Validation")
    print("=" * 70)

    with open('procurement_data.json') as f:
        products = json.load(f)

    stats = {
        'total': len(products),
        'with_price': 0,
        'with_nutrients': 0,
        'with_description': 0,
        'with_storage_notes': 0,
        'by_source': {},
    }

    for product in products:
        if product.get('price'):
            stats['with_price'] += 1
        if product.get('key_nutrients'):
            stats['with_nutrients'] += 1
        if product.get('description'):
            stats['with_description'] += 1
        if product.get('storage_note'):
            stats['with_storage_notes'] += 1

        source = product.get('source', 'Unknown')
        if source not in stats['by_source']:
            stats['by_source'][source] = 0
        stats['by_source'][source] += 1

    print(f"\nTotal Products: {stats['total']}")
    print(f"With Price: {stats['with_price']} ({100*stats['with_price']//stats['total']}%)")
    print(f"With Nutrients: {stats['with_nutrients']} ({100*stats['with_nutrients']//stats['total']}%)")
    print(f"With Description: {stats['with_description']} ({100*stats['with_description']//stats['total']}%)")
    print(f"With Storage Notes: {stats['with_storage_notes']} ({100*stats['with_storage_notes']//stats['total']}%)")

    print(f"\nProducts by Source:")
    for source, count in sorted(stats['by_source'].items()):
        print(f"  {source}: {count}")


def example_6_search_products():
    """Example 6: Search for specific products"""
    print("\n" + "=" * 70)
    print("EXAMPLE 6: Search Products")
    print("=" * 70)

    with open('procurement_data.json') as f:
        products = json.load(f)

    # Search for specific keywords
    search_keywords = ['Kirkland', 'NOW Foods', '膠原']

    for keyword in search_keywords:
        print(f"\nSearching for: {keyword}")
        matches = [
            p for p in products
            if keyword.lower() in p['product_name'].lower()
            or (p.get('brand') and keyword.lower() in p.get('brand', '').lower())
        ]

        for product in matches[:3]:  # Show first 3 matches
            print(f"  • {product['product_name']}")
            if product.get('brand'):
                print(f"    Brand: {product['brand']}")
            if product.get('price'):
                print(f"    Price: {product['price']}")


def main():
    """Run all examples"""
    # Check if PDF exists
    if not Path('健康長壽追蹤器採購.pdf').exists():
        print("Error: PDF file not found!")
        print("Please ensure '健康長壽追蹤器採購.pdf' exists in the current directory")
        return

    try:
        # Run first example to generate JSON if needed
        if not Path('procurement_data.json').exists():
            print("Generating procurement_data.json...")
            example_1_basic_parsing()

        # Run other examples with existing JSON
        example_2_filter_by_source()
        example_3_extract_nutrients()
        example_4_supplement_schedule_mapping()
        example_5_data_validation()
        example_6_search_products()

        print("\n" + "=" * 70)
        print("Examples completed!")
        print("=" * 70)

    except Exception as e:
        print(f"\nError: {e}")
        import traceback
        traceback.print_exc()


if __name__ == '__main__':
    main()
