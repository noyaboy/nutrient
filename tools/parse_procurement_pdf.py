#!/usr/bin/env python3
"""
Procurement PDF Parser for Nutrient Health Tracker

Extracts product information from procurement PDFs and converts to structured JSON.
Handles both Costco and iHerb products with flexible nutrient parsing.

The PDF is structured as a printed web page with:
- Section headers (Costco 好市多, iHerb, etc.)
- Product title + source on first line
- Brand/Origin info on second line
- Price/quantity info
- 規格 (specs) section
- 營養 (nutrition) section

Usage:
    python parse_procurement_pdf.py <pdf_path> [--output output.json]
    python parse_procurement_pdf.py --list-pages <pdf_path>
"""

import json
import sys
import argparse
import re
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, asdict, field
from collections import defaultdict


@dataclass
class Product:
    """Represents a complete product entry."""
    product_name: str
    source: str  # "Costco", "iHerb", "傳統市場", etc.
    quantity: str
    serving_size: str
    key_nutrients: Dict[str, Dict[str, str]] = field(default_factory=dict)
    brand: Optional[str] = None
    origin: Optional[str] = None
    price: Optional[str] = None
    description: Optional[str] = None
    storage_note: Optional[str] = None
    ingredients: Optional[str] = None
    specs: Optional[Dict[str, str]] = None

    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for JSON serialization."""
        result = {}
        for key, value in asdict(self).items():
            if value is not None and value != {} and value != "":
                result[key] = value
        return result


class ProcurementPDFParser:
    """Parser for supplement procurement PDFs."""

    # Common section headers in the PDF
    SECTION_HEADERS = [
        'Costco 好市多 — 保健品',
        'Costco 好市多 — 食材',
        'iHerb — 專業補充品',
        '傳統市場 / 全聯 / 頂好',
    ]

    # Source mapping
    SOURCE_MAP = {
        'Costco 好市多': 'Costco',
        'Costco': 'Costco',
        '好市多': 'Costco',
        'iHerb': 'iHerb',
        '爱赫': 'iHerb',
        '傳統市場': '傳統市場',
        '全聯': '全聯',
        '頂好': '頂好',
    }

    def __init__(self, pdf_path: str):
        """Initialize the parser with a PDF file."""
        self.pdf_path = Path(pdf_path)
        if not self.pdf_path.exists():
            raise FileNotFoundError(f"PDF not found: {pdf_path}")

        self.products: List[Product] = []
        self._text_cache: Optional[str] = None

    def extract_text(self) -> str:
        """
        Extract text from PDF using pdfplumber.
        Falls back to PyPDF2 if needed.
        """
        if self._text_cache:
            return self._text_cache

        try:
            import pdfplumber
            with pdfplumber.open(self.pdf_path) as pdf:
                text = ""
                for page_num, page in enumerate(pdf.pages, 1):
                    extracted = page.extract_text()
                    if extracted:
                        text += f"{extracted}\n"
                self._text_cache = text
                return text
        except ImportError:
            print("Warning: pdfplumber not available, attempting fallback extraction")
            return self._fallback_extract()

    def _fallback_extract(self) -> str:
        """Fallback text extraction using PyPDF2."""
        try:
            from PyPDF2 import PdfReader
            reader = PdfReader(self.pdf_path)
            text = ""
            for page in reader.pages:
                extracted = page.extract_text()
                if extracted:
                    text += f"{extracted}\n"
            self._text_cache = text
            return text
        except ImportError:
            raise ImportError(
                "No PDF library available. Install with: pip install pdfplumber"
            )

    def parse_pdf(self) -> List[Product]:
        """
        Main parsing method. Extracts products from PDF text.
        """
        text = self.extract_text()

        # Split into product blocks
        products = self._parse_all_products(text)
        self.products = products

        return products

    def _parse_all_products(self, text: str) -> List[Product]:
        """
        Parse all products from the full text.
        Products are identified by pattern: Title + Source on same line.
        """
        products = []
        lines = text.split('\n')
        current_source = None

        i = 0
        while i < len(lines):
            line = lines[i].strip()

            # Check if this is a section header
            for header in self.SECTION_HEADERS:
                if header in line:
                    current_source = self._extract_source(header)
                    break

            # Check if this is a product title line (contains product name + source)
            if current_source and self._is_product_title(line):
                # Extract product block (next ~15-20 lines until next product)
                product_lines = [line]
                i += 1

                # Collect lines for this product until next product title or section
                while i < len(lines):
                    next_line = lines[i].strip()

                    # Stop conditions
                    if self._is_section_header(next_line):
                        current_source = self._extract_source(next_line)
                        break
                    if self._is_product_title(next_line) and not self._is_continuation(product_lines, next_line):
                        break

                    product_lines.append(next_line)
                    i += 1

                # Parse the product block
                try:
                    product = self._parse_product_block(product_lines, current_source)
                    if product and product.product_name:
                        products.append(product)
                except Exception as e:
                    print(f"Warning: Failed to parse product: {e}", file=sys.stderr)
            else:
                i += 1

        return products

    def _is_section_header(self, line: str) -> bool:
        """Check if line is a section header."""
        return any(header in line for header in self.SECTION_HEADERS)

    def _is_product_title(self, line: str) -> bool:
        """
        Check if line looks like a product title.
        Product titles are typically long lines with product name.
        """
        if len(line) < 5:
            return False

        # Should not be all numbers, dates, or URLs
        if re.match(r'^\d{4}/\d{1,2}/\d{1,2}', line):  # Date
            return False
        if re.match(r'^https?://', line):  # URL
            return False
        if line.startswith('SKU') or line.startswith('首頁'):
            return False

        # Should contain at least one Chinese character or product keyword
        has_chinese = bool(re.search(r'[\u4e00-\u9fff]', line))
        has_keyword = any(keyword in line for keyword in ['粒', '錠', '克', '公斤', 'kg', 'Costco', 'iHerb', '好市多'])

        return has_chinese and (has_keyword or len(line) > 10)

    def _is_continuation(self, product_lines: List[str], next_line: str) -> bool:
        """Check if next_line is part of current product, not a new product."""
        # If it contains specs keywords, it's likely continuation
        if any(keyword in next_line for keyword in ['form:', 'count:', 'storage:', '規格', '營養']):
            return True
        # If it contains explanatory text (long line with full sentences)
        if len(next_line) > 50 and '。' in next_line:
            return True
        return False

    def _extract_source(self, line: str) -> str:
        """Extract source from header or title line."""
        for key, value in self.SOURCE_MAP.items():
            if key in line:
                return value
        return "Unknown"

    def _parse_product_block(self, lines: List[str], source: str) -> Optional[Product]:
        """
        Parse a block of lines into a Product object.
        Expected structure:
        - Line 0: Product Title
        - Line 1: Brand/Origin/Price info
        - Lines 2+: Description, specs, nutrition
        """
        if not lines or len(lines) < 1:
            return None

        # Parse the title line
        title_line = lines[0]
        product_name, source_from_title = self._parse_title_line(title_line)

        if not product_name:
            return None

        # Use source from title if available, otherwise use passed source
        if source_from_title:
            source = source_from_title

        # Parse remaining lines
        brand = None
        origin = None
        price = None
        quantity = ""
        serving_size = ""
        description_parts = []
        storage_note = None
        ingredients = None
        specs_dict = {}
        key_nutrients = {}

        block_text = '\n'.join(lines[1:] if len(lines) > 1 else [])

        # Extract structured data
        brand = self._extract_brand(product_name, block_text)
        origin = self._extract_origin(block_text)
        price = self._extract_price(block_text)
        quantity = self._extract_quantity(block_text)
        serving_size, key_nutrients = self._extract_nutrients(block_text)
        storage_note = self._extract_storage_notes(block_text)
        ingredients = self._extract_ingredients(block_text)
        specs_dict = self._extract_specs(block_text)
        description = self._extract_description(lines[1:] if len(lines) > 1 else [])

        return Product(
            product_name=product_name,
            source=source,
            quantity=quantity,
            serving_size=serving_size,
            key_nutrients=key_nutrients,
            brand=brand,
            origin=origin,
            price=price,
            description=description,
            storage_note=storage_note,
            ingredients=ingredients,
            specs=specs_dict if specs_dict else None,
        )

    def _parse_title_line(self, line: str) -> Tuple[str, Optional[str]]:
        """
        Parse product title and source from title line.
        Format: "Product Name (Brand details) Source"
        """
        # Remove leading/trailing whitespace
        line = line.strip()

        # Extract source from end
        source = None
        for key in self.SOURCE_MAP.keys():
            if line.endswith(key):
                source = self.SOURCE_MAP[key]
                line = line[:-len(key)].strip()
                break

        # Clean up parentheses and extra info
        title = re.sub(r'\s+', ' ', line).strip()

        return title, source

    def _extract_brand(self, product_name: str, text: str) -> Optional[str]:
        """Extract brand name."""
        # Common brand patterns
        brand_patterns = [
            (r'(Kirkland|科克蘭)', 'Kirkland'),
            (r'(NOW\s*Foods|諾奧)', 'NOW Foods'),
            (r'(California\s*Gold|CGN)', 'California Gold Nutrition'),
            (r'(NATURE\s*MADE|萊萃美)', 'Nature Made'),
            (r'(Tryall|TRYALL)', 'Tryall'),
            (r'(全佑牧場|QUAN-YOU)', '全佑牧場'),
        ]

        for pattern, brand_name in brand_patterns:
            if re.search(pattern, product_name + ' ' + text, re.IGNORECASE):
                return brand_name

        # Extract first capitalized word if it looks like a brand
        words = product_name.split()
        for word in words:
            if len(word) > 2 and word[0].isupper() and not re.match(r'[A-Z]{1,2}$', word):
                return word

        return None

    def _extract_origin(self, text: str) -> Optional[str]:
        """Extract country/origin of product."""
        pattern = r'·\s*([^·\n]+?)(?:\s+NT\$|$)'
        match = re.search(pattern, text)
        if match:
            origin = match.group(1).strip()
            if origin and not origin.startswith('NT'):
                return origin
        return None

    def _extract_price(self, text: str) -> Optional[str]:
        """Extract price information."""
        pattern = r'(NT\$[\d,]+(?:~[\d,]+)?|￥[\d,]+)'
        match = re.search(pattern, text)
        return match.group(1) if match else None

    def _extract_quantity(self, text: str) -> str:
        """
        Extract quantity/count.
        Patterns: 180粒, 2kg, 250錠, 30入, etc.
        """
        patterns = [
            r'(\d+\.?\d*)\s*(粒|片|錠|入|個|克|g|公斤|kg)',
            r'([\d.]+)\s*(kg|公斤|克|盎司)',
        ]

        for pattern in patterns:
            match = re.search(pattern, text, re.IGNORECASE)
            if match:
                return match.group(0)

        return ""

    def _extract_nutrients(self, text: str) -> Tuple[str, Dict[str, Dict[str, str]]]:
        """
        Extract serving size and key nutrients.
        Looks for 營養 section and key nutrient patterns.
        """
        nutrients = {}
        serving_size = ""

        # Nutrient patterns (simplified for key values only)
        nutrient_patterns = {
            'protein': r'(protein|蛋白)[\s：]*(\d+\.?\d*)\s*(克|g|毫克|mg)',
            'omega3': r'(Omega-?3|omega3|魚油)[\s：~]*(\d+\.?\d*)\s*(毫克|mg|克)',
            'epa': r'(EPA|epa)[\s：~]*(\d+\.?\d*)\s*(毫克|mg)',
            'dha': r'(DHA|dha)[\s：~]*(\d+\.?\d*)\s*(毫克|mg)',
            'calcium': r'(calcium|鈣)[\s：]*(\d+\.?\d*)\s*(毫克|mg|克|g)',
            'vitamin_d3': r'(vitamin_d3|維生素\s*D3|Vitamin\s*D3)[\s：]*(\d+\.?\d*)\s*(IU|mcg|毫克)',
            'vitamin_d': r'(vitamin_d|維生素\s*D|Vitamin\s*D)[\s：]*(\d+\.?\d*)\s*(IU|mcg|毫克)',
            'magnesium': r'(magnesium|鎂)[\s：]*(\d+\.?\d*)\s*(毫克|mg|克)',
            'zinc': r'(zinc|鋅)[\s：]*(\d+\.?\d*)\s*(毫克|mg)',
            'vitamin_c': r'(vitamin_c|維生素\s*C)[\s：]*(\d+\.?\d*)\s*(毫克|mg)',
            'lutein': r'(lutein|葉黃素)[\s：]*(\d+\.?\d*)\s*(毫克|mg)',
            'vitamin_k2': r'(vitamin_k2|維生素\s*K2|K2)[\s：]*(\d+\.?\d*)\s*(mcg|毫克)',
        }

        for nutrient_key, pattern in nutrient_patterns.items():
            match = re.search(pattern, text, re.IGNORECASE)
            if match:
                amount = match.group(2)
                unit = match.group(3)
                nutrients[nutrient_key] = {
                    "amount": amount,
                    "unit": unit,
                }

        # Extract serving size
        serving_patterns = [
            r'serving_size[\s：]*(\d+\.?\d*\s*(?:克|g|毫升|ml|粒|片|mg))',
            r'per_serving[\s：]*(\d+\.?\d*\s*(?:克|g))',
            r'每[份次][\s：]*(\d+\.?\d*\s*(?:克|g|毫升|ml|粒|片))',
        ]

        for pattern in serving_patterns:
            match = re.search(pattern, text, re.IGNORECASE)
            if match:
                serving_size = match.group(1)
                break

        return serving_size, nutrients

    def _extract_storage_notes(self, text: str) -> Optional[str]:
        """Extract storage and handling notes."""
        patterns = [
            r'(storage[\s：]*[^\n]+)',
            r'(請(?:置於|存放於|冷藏|冷凍)[^。\n]{10,})',
        ]

        for pattern in patterns:
            match = re.search(pattern, text, re.IGNORECASE)
            if match:
                note = match.group(1)
                # Clean up
                note = re.sub(r'^(storage[\s：]*)', '', note, flags=re.IGNORECASE)
                return note.strip()

        return None

    def _extract_ingredients(self, text: str) -> Optional[str]:
        """Extract ingredients from text."""
        pattern = r'ingredients[\s：]*([^\n]+)'
        match = re.search(pattern, text, re.IGNORECASE)
        if match:
            return match.group(1).strip()
        return None

    def _extract_specs(self, text: str) -> Dict[str, str]:
        """Extract specification details."""
        specs = {}

        # Look for spec pattern: "key: value"
        spec_patterns = [
            (r'form[\s：]*([^\n]+)', 'form'),
            (r'count[\s：]*([^\n]+)', 'count'),
            (r'weight[\s：]*([^\n]+)', 'weight'),
            (r'serving[\s：]*(\d+(?:\.\d+)?)', 'serving'),
        ]

        for pattern, key in spec_patterns:
            match = re.search(pattern, text, re.IGNORECASE)
            if match:
                specs[key] = match.group(1).strip()

        return specs

    def _extract_description(self, lines: List[str]) -> Optional[str]:
        """
        Extract description from product detail lines.
        Usually the first meaningful paragraph.
        """
        # Skip brand/origin line and find first descriptive paragraph
        for i, line in enumerate(lines):
            # Skip lines with just metadata
            if any(keyword in line for keyword in ['form:', 'count:', 'storage:', '規格', '營養', 'NT$']):
                continue
            if len(line) > 20 and '。' in line:
                # This looks like a description
                return line[:200]

        return None

    def to_json(self, pretty: bool = True) -> str:
        """Convert parsed products to JSON string."""
        products_data = [p.to_dict() for p in self.products]
        indent = 2 if pretty else None
        return json.dumps(products_data, ensure_ascii=False, indent=indent)

    def save_json(self, output_path: str, pretty: bool = True) -> None:
        """Save parsed products to JSON file."""
        output_file = Path(output_path)
        output_file.parent.mkdir(parents=True, exist_ok=True)

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(self.to_json(pretty=pretty))

        print(f"Saved {len(self.products)} products to {output_path}")

    def print_summary(self) -> None:
        """Print a summary of parsed products."""
        print(f"\n{'='*70}")
        print(f"Parsed {len(self.products)} products")
        print(f"{'='*70}\n")

        by_source = defaultdict(list)
        for product in self.products:
            by_source[product.source].append(product)

        for source in sorted(by_source.keys()):
            products = by_source[source]
            print(f"\n{source} ({len(products)} products):")
            print("-" * 70)
            for i, product in enumerate(products, 1):
                print(f"{i}. {product.product_name}")
                if product.brand:
                    print(f"   Brand: {product.brand}")
                if product.origin:
                    print(f"   Origin: {product.origin}")
                if product.quantity:
                    print(f"   Quantity: {product.quantity}")
                if product.serving_size:
                    print(f"   Serving: {product.serving_size}")
                if product.key_nutrients:
                    print(f"   Nutrients: {json.dumps(product.key_nutrients, ensure_ascii=False)}")
                if product.price:
                    print(f"   Price: {product.price}")
                print()


def main():
    """Main CLI entry point."""
    parser = argparse.ArgumentParser(
        description="Parse supplement procurement PDFs to structured JSON",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf
  python parse_procurement_pdf.py 健康長壽追蹤器採購.pdf --output procurement.json
  python parse_procurement_pdf.py --list-pages 健康長壽追蹤器採購.pdf
        """
    )

    parser.add_argument(
        'pdf_path',
        nargs='?',
        help='Path to PDF file'
    )
    parser.add_argument(
        '--output', '-o',
        help='Output JSON file path (default: procurement_output.json)'
    )
    parser.add_argument(
        '--list-pages',
        action='store_true',
        help='List page count and exit'
    )

    args = parser.parse_args()

    if not args.pdf_path:
        parser.print_help()
        sys.exit(1)

    try:
        pdf_parser = ProcurementPDFParser(args.pdf_path)

        if args.list_pages:
            try:
                import pdfplumber
                with pdfplumber.open(args.pdf_path) as pdf:
                    print(f"PDF: {args.pdf_path}")
                    print(f"Pages: {len(pdf.pages)}")
            except ImportError:
                print("pdfplumber not available for page count")
            sys.exit(0)

        print(f"Parsing {args.pdf_path}...")
        products = pdf_parser.parse_pdf()

        pdf_parser.print_summary()

        output_path = args.output or "procurement_output.json"
        pdf_parser.save_json(output_path, pretty=True)

    except FileNotFoundError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
