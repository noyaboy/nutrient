# Procurement PDF Parser

A Python script for parsing supplement procurement PDFs and extracting structured nutritional data into JSON format.

## Overview

This parser automatically extracts product information from the procurement PDF (健康長壽追蹤器採購.pdf) including:
- Product name and source (Costco, iHerb, traditional markets, etc.)
- Brand and origin country
- Price and quantity
- Serving size and key nutrients
- Storage notes and ingredients
- Full specifications

## Installation

### Requirements
- Python 3.7+
- pdfplumber (for PDF text extraction)

### Setup

```bash
# Install dependencies
pip install pdfplumber

# Verify script is executable
chmod +x parse_procurement_pdf.py
```

## Usage

### Basic Usage

Parse the procurement PDF and save to JSON:

```bash
python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf
```

### With Custom Output File

```bash
python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf --output my_output.json
```

### List PDF Pages

Check the number of pages in the PDF:

```bash
python parse_procurement_pdf.py --list-pages 健康長壽追蹤器採購.pdf
```

### Interactive Mode (Future Enhancement)

```bash
python parse_procurement_pdf.py --interactive 健康長壽追蹤器採購.pdf
```

## Output Format

The parser generates JSON with the following structure:

```json
[
  {
    "product_name": "緩釋魚油（Kirkland 新型緩釋 Omega-3）",
    "source": "Costco",
    "brand": "Kirkland",
    "origin": "加拿大",
    "quantity": "180粒",
    "serving_size": "每1200毫克濃縮魚油",
    "price": "NT$579",
    "key_nutrients": {
      "omega3": {
        "amount": "700",
        "unit": "mg"
      },
      "epa": {
        "amount": "419",
        "unit": "mg"
      },
      "dha": {
        "amount": "281",
        "unit": "mg"
      }
    },
    "description": "Omega-3 supplementation with enteric coating",
    "storage_note": "Please store in cool, dry place",
    "ingredients": "Fish oil (sardine, anchovy, mackerel)",
    "specs": {
      "form": "soft capsule",
      "count": "180粒"
    }
  }
]
```

## Key Fields Explained

| Field | Description | Example |
|-------|-------------|---------|
| `product_name` | Full product title | "緩釋魚油（Kirkland 新型緩釋 Omega-3）" |
| `source` | Where to purchase from | "Costco", "iHerb", "傳統市場" |
| `brand` | Manufacturer brand | "Kirkland", "NOW Foods" |
| `origin` | Country of origin | "加拿大", "美國" |
| `quantity` | Package size/count | "180粒", "2kg", "250錠" |
| `serving_size` | Amount per serving | "30g", "每1200毫克" |
| `price` | Cost in TWD | "NT$579" |
| `key_nutrients` | Nutritional values extracted | Object with nutrient amounts |
| `description` | Product details | Main benefits and features |
| `storage_note` | Storage instructions | Temperature and handling notes |
| `ingredients` | Ingredient list | Raw materials |
| `specs` | Technical specifications | Form, count, weight, etc. |

## Supported Nutrients

The parser automatically extracts these nutrients when present in the PDF:

- **Macronutrients**: protein, fat, carbohydrates
- **Omega-3**: omega3, epa, dha
- **Minerals**: calcium, magnesium, zinc, copper, iron
- **Vitamins**: vitamin_c, vitamin_d, vitamin_d3, vitamin_k2
- **Other**: lutein, creatine, collagen, coq10, b_complex

## Data Sources Recognized

The parser handles multiple sources:

- **Costco**: "Costco", "好市多", "科克蘭 Kirkland"
- **iHerb**: "iHerb", "爱赫"
- **Traditional Markets**: "傳統市場", "全聯", "頂好"
- **Convenience Stores**: "7-Eleven", "全家便利店", "OK便利店"
- **Online**: "Amazon", "momo", "蝦皮"

## Integration with Database

To cross-reference with the existing Supabase database:

1. Parse the PDF:
   ```bash
   python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf --output procurement_data.json
   ```

2. Load and match with existing products:
   ```python
   import json
   from pathlib import Path

   # Load parsed procurement data
   with open('procurement_data.json') as f:
       procurement = json.load(f)

   # Match with database products by name
   for product in procurement:
       print(f"{product['product_name']} - {product['source']}")
       print(f"  Nutrients: {product.get('key_nutrients', {})}")
       print(f"  Serving: {product.get('serving_size', '')}")
   ```

## Features

### Current Features
- PDF text extraction (pdfplumber)
- Product name, brand, and source identification
- Price and quantity parsing
- Nutrient value extraction with units
- Origin country detection
- Storage instructions extraction
- Section-based categorization
- JSON output with pretty-printing

### Nutrient Parsing
- Recognizes Chinese and English labels
- Handles various unit formats (mg, g, IU, mcg)
- Extracts numerical values with decimals
- Maintains unit information for calculations

### Flexible Extraction
- Case-insensitive pattern matching
- Supports both Chinese and English terminology
- Handles special characters and traditional Chinese
- Fallback patterns for varied formatting

## Troubleshooting

### Issue: "pdfplumber not available"

**Solution**: Install pdfplumber
```bash
pip install pdfplumber
```

### Issue: No products found

**Reasons**:
- PDF file path is incorrect
- PDF is corrupted or unreadable
- PDF structure doesn't match expected format

**Solution**:
1. Verify PDF exists: `ls -la 健康長壽追蹤器採購.pdf`
2. Check PDF is readable: `python parse_procurement_pdf.py --list-pages <pdf_path>`
3. Review sample output: `python parse_procurement_pdf.py <pdf_path> 2>&1 | head -50`

### Issue: Missing nutrients in output

**Reasons**:
- Nutrient format differs from expected patterns
- Unit abbreviation not recognized
- Nutrient name in different language/format

**Solution**:
- Check raw PDF text for exact nutrient labels
- Add custom patterns to `nutrient_patterns` dict in the script
- Run with sample product to verify extraction

## Advanced Usage

### Custom Nutrient Patterns

To add support for additional nutrients, edit the `_extract_nutrients` method:

```python
nutrient_patterns = {
    'custom_nutrient': r'(custom pattern)[\s：]*(\d+\.?\d*)\s*(unit)',
    # ... other patterns
}
```

### Filtering Results

```python
import json

with open('procurement_data.json') as f:
    products = json.load(f)

# Filter by source
iherb_products = [p for p in products if p['source'] == 'iHerb']

# Filter by nutrient presence
omega3_products = [p for p in products if 'omega3' in p.get('key_nutrients', {})]

# Filter by price range
budget_products = [p for p in products if 'NT$' in (p.get('price', '') or '')]
```

### Data Transformation for Database

```python
# Transform to database format
for product in products:
    db_entry = {
        'name': product['product_name'],
        'store': product['source'],
        'brand': product.get('brand'),
        'origin': product.get('origin'),
        'nutrition': product.get('key_nutrients', {}),
        'price': product.get('price'),
        'quantity': product.get('quantity'),
    }
    # Insert into database...
```

## Performance

- PDF with 21 pages: ~2-3 seconds parsing time
- Output JSON: ~50-100 KB file size
- Memory usage: Minimal (< 50MB)

## Limitations

1. **PDF-specific**: Works with procurement PDFs generated by the web app
2. **Text extraction**: May have issues with scanned or image-based PDFs
3. **Nutrient accuracy**: Relies on specific formatting in PDF
4. **Languages**: Optimized for Traditional Chinese and English
5. **Product boundaries**: May struggle with unusual product layouts

## Future Enhancements

- [ ] Interactive mode for manual mapping of unclear products
- [ ] Support for scanned PDFs (OCR)
- [ ] Batch processing of multiple PDFs
- [ ] Direct database integration
- [ ] Validation against existing database
- [ ] Automated discrepancy reporting
- [ ] Chart generation for nutrient analysis
- [ ] Historical tracking across procurement updates

## Contributing

To improve the parser:

1. Submit PDF samples of problematic products
2. Suggest additional nutrient patterns to recognize
3. Report parsing errors with specific products
4. Propose new features or improvements

## License

Internal tool for Nutrient Health Tracker project

## Contact & Support

For issues or questions about the parser, refer to the main project documentation or create an issue in the project repository.
