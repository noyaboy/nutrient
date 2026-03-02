# Procurement PDF Parser - Quick Start Guide

## Installation (5 minutes)

```bash
# 1. Install dependency
pip install pdfplumber

# 2. Verify scripts exist
ls -l parse_procurement_pdf.py example_usage.py

# 3. Test the parser
python parse_procurement_pdf.py --list-pages 健康長壽追蹤器採購.pdf
```

## Basic Usage (1 minute)

```bash
# Parse PDF and save to JSON
python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf

# Custom output filename
python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf --output my_data.json
```

## View Results

```bash
# Pretty-print first 20 products
head -200 procurement_output.json | python -m json.tool

# Count products by source
python -c "
import json
with open('procurement_output.json') as f:
    data = json.load(f)
from collections import Counter
sources = Counter(p.get('source', 'Unknown') for p in data)
for source, count in sorted(sources.items()):
    print(f'{source}: {count}')
"
```

## Common Tasks

### 1. Find Omega-3 Products
```bash
python -c "
import json
with open('procurement_output.json') as f:
    products = json.load(f)
omega3 = [p for p in products if 'omega3' in p.get('key_nutrients', {})]
for p in omega3[:3]:
    print(f'{p[\"product_name\"]} ({p[\"source\"]}) - {p[\"price\"]}')"
```

### 2. Filter by Source
```bash
python -c "
import json
with open('procurement_output.json') as f:
    products = json.load(f)
iherb = [p for p in products if p.get('source') == 'iHerb']
print(f'Found {len(iherb)} iHerb products')
for p in iherb[:5]:
    print(f'  - {p[\"product_name\"]}')"
```

### 3. Search Products
```bash
python -c "
import json
keyword = 'Kirkland'
with open('procurement_output.json') as f:
    products = json.load(f)
matches = [p for p in products if keyword in p.get('product_name', '')]
print(f'Found {len(matches)} products with \"{keyword}\"')
for p in matches[:5]:
    print(f'  - {p[\"product_name\"]}')"
```

### 4. Get Nutrient Summary
```bash
python -c "
import json
from collections import defaultdict
with open('procurement_output.json') as f:
    products = json.load(f)
nutrients = defaultdict(int)
for p in products:
    for n in p.get('key_nutrients', {}):
        nutrients[n] += 1
for nutrient, count in sorted(nutrients.items(), key=lambda x: -x[1])[:10]:
    print(f'{nutrient}: {count} products')"
```

## Run Examples

```bash
# Run all 6 examples
python example_usage.py

# Or run specific Python examples directly
python -c "
from example_usage import example_2_filter_by_source
example_2_filter_by_source()
"
```

## Files Created

| File | Purpose | Size |
|------|---------|------|
| `parse_procurement_pdf.py` | Main parser script | 21 KB |
| `example_usage.py` | 6 runnable examples | 8.1 KB |
| `PROCUREMENT_PARSER_README.md` | Full documentation | 10 KB |
| `PARSER_IMPLEMENTATION_SUMMARY.md` | Technical details | 12 KB |
| `QUICK_START.md` | This file | 2 KB |
| `procurement_output.json` | Generated data | ~100 KB |

## Output Format

Each product has:
- `product_name`: Full product title
- `source`: Where to buy (Costco, iHerb, etc.)
- `brand`: Manufacturer name
- `quantity`: Package size (180粒, 2kg, etc.)
- `price`: Cost in TWD
- `serving_size`: Amount per serving
- `key_nutrients`: {nutrient: {amount, unit}}

Example:
```json
{
  "product_name": "Omega-3 Fish Oil",
  "source": "Costco",
  "brand": "Kirkland",
  "quantity": "180粒",
  "price": "NT$579",
  "key_nutrients": {
    "omega3": {"amount": "700", "unit": "mg"}
  }
}
```

## Troubleshooting

**Script not found?**
```bash
ls -la parse_procurement_pdf.py
```

**PDF not found?**
```bash
ls -la 健康長壽追蹤器採購.pdf
```

**pdfplumber not installed?**
```bash
pip install pdfplumber
```

**JSON not valid?**
```bash
python -m json.tool procurement_output.json
```

## Next Steps

1. **Review output**: Check `procurement_output.json` for accuracy
2. **Cross-reference**: Match with database products
3. **Validate**: Use existing validation scripts
4. **Analyze**: Run examples to understand data
5. **Integrate**: Feed into supplement schedule matching

## More Information

- Full docs: `PROCUREMENT_PARSER_README.md`
- Technical specs: `PARSER_IMPLEMENTATION_SUMMARY.md`
- Example code: `example_usage.py`
- Source code: `parse_procurement_pdf.py`

## Command Cheat Sheet

```bash
# Parse PDF
python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf

# Custom output
python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf -o data.json

# Check pages
python parse_procurement_pdf.py --list-pages 健康長壽追蹤器採購.pdf

# Run examples
python example_usage.py

# Validate JSON
python -m json.tool procurement_output.json | head -20

# Count products
python -c "import json; print(len(json.load(open('procurement_output.json'))))"

# List sources
python -c "
import json
from collections import Counter
data = json.load(open('procurement_output.json'))
sources = Counter(p.get('source') for p in data)
print('\\n'.join(f'{s}: {c}' for s, c in sources.most_common()))"
```

---

**Version**: 1.0.0 | **Status**: Ready to use | **Last updated**: 2026-02-28
