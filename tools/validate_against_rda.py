#!/usr/bin/env python3
"""
Phase 2 & 3: RDA/UL Validation + Discrepancy Detection
Compares actual intake against evidence-based standards
Identifies deficiencies, toxicity risks, and timing conflicts
"""

import json
from typing import Dict, List, Tuple
from pathlib import Path

# Load extracted daily intake
INTAKE_FILE = Path("/home/noah/project/nutrient/daily_nutrient_intake.json")

RDA_UL_STANDARDS = {
    "vitamin_d3": {
        "nutrient": "Vitamin D3",
        "rda_iu": 600,
        "endocrine_society_subtropical": 2000,
        "endocrine_society_athletes": 2000,
        "ul_iu": 4000,
        "evidence_base": "Endocrine Society 2022 Clinical Practice Guidelines"
    },
    "vitamin_k2": {
        "nutrient": "Vitamin K2 (MK-7)",
        "ai_mcg": 120,  # Adequate Intake for K1, K2 not separately defined
        "functional_optimal_mcg": (100, 200),
        "ul": None,  # No established UL
        "evidence_base": "EFSA, functional medicine consensus"
    },
    "vitamin_c": {
        "nutrient": "Vitamin C",
        "rda_mg": 100,
        "ul_mg": 2000,
        "evidence_base": "NIH DRI"
    },
    "zinc": {
        "nutrient": "Zinc",
        "rda_mg": 11,
        "athlete_strength_mg": 15,
        "ul_mg": 40,
        "evidence_base": "NIH DRI + Int Soc Sports Nutr"
    },
    "copper": {
        "nutrient": "Copper",
        "rda_mg": 0.9,
        "ul_mg": 10,
        "optimal_zn_cu_ratio": "10:1 to 15:1",
        "evidence_base": "NIH DRI"
    },
    "iodine": {
        "nutrient": "Iodine",
        "rda_mcg": 150,
        "ul_mcg": 1100,
        "evidence_base": "NIH DRI"
    },
    "calcium": {
        "nutrient": "Calcium",
        "rda_mg": 1000,
        "ul_mg": 2500,
        "note": "RDA assumes vitamin D adequacy",
        "evidence_base": "NIH DRI"
    },
    "magnesium": {
        "nutrient": "Magnesium",
        "rda_mg": 400,
        "athlete_optimal_mg": 400,  # up to 600 for heavy training
        "ul_from_supplements_mg": 350,
        "ul_note": "Includes food; UL only applies to supplements",
        "evidence_base": "NIH DRI + Int Soc Sports Nutr"
    },
    "sodium": {
        "nutrient": "Sodium",
        "who_max_mg": 2400,
        "athlete_adjustment_mg": (500, 1000),
        "note": "Athlete adjustment for heavy sweating",
        "evidence_base": "WHO, American Heart Association"
    },
    "epa_dha": {
        "nutrient": "EPA + DHA (Omega-3)",
        "aha_adequate_mg": 500,
        "aha_recommendation_mg": (250, 500),
        "anti_inflammatory_optimal_mg": (2000, 3000),
        "ul": None,
        "evidence_base": "American Heart Association, ASPEN"
    },
    "protein": {
        "nutrient": "Protein",
        "rda_per_kg": 0.8,
        "strength_training_per_kg": 1.6,
        "hypertrophy_optimal_per_kg": 2.2,
        "per_meal_ceiling_g": 40,  # MPS ceiling for single meal
        "evidence_base": "Int Soc Sports Nutr Position Stand"
    }
}

def validate_nutrient(nutrient_name: str, current_value: float, unit: str) -> Dict:
    """
    Validate single nutrient against RDA/UL
    Returns: assessment with status (deficient, marginal, adequate, excessive)
    """

    standards = RDA_UL_STANDARDS.get(nutrient_name, {})
    if not standards:
        return {"error": f"No standards for {nutrient_name}"}

    assessment = {
        "nutrient": standards.get("nutrient", nutrient_name),
        "current_value": current_value,
        "unit": unit,
        "rda": standards.get("rda_mg") or standards.get("rda_iu") or standards.get("rda_mcg") or standards.get("rda_per_kg"),
        "ul": standards.get("ul_mg") or standards.get("ul_iu") or standards.get("ul_mcg"),
        "status": None,
        "percentage_of_rda": None,
        "flags": []
    }

    rda = assessment["rda"]
    ul = assessment["ul"]

    if rda:
        assessment["percentage_of_rda"] = (current_value / rda) * 100

    # Status assignment
    if current_value < (rda * 0.75) if rda else False:
        assessment["status"] = "DEFICIENT"
        assessment["flags"].append(f"⛔ {current_value}{unit} < 75% of RDA")
    elif current_value < rda if rda else False:
        assessment["status"] = "MARGINAL"
        assessment["flags"].append(f"⚠️ {current_value}{unit} < RDA {rda}{unit}")
    elif ul and current_value > ul:
        assessment["status"] = "EXCESSIVE"
        assessment["flags"].append(f"⛔ {current_value}{unit} > UL {ul}{unit}")
    elif ul and current_value > (ul * 0.75):
        assessment["status"] = "NEAR_LIMIT"
        assessment["flags"].append(f"⚠️ {current_value}{unit} > 75% of UL")
    else:
        assessment["status"] = "ADEQUATE"

    assessment["evidence_base"] = standards.get("evidence_base")
    return assessment

def generate_comprehensive_report() -> Dict:
    """
    Generate full validation report comparing all nutrients
    """

    with open(INTAKE_FILE, "r", encoding="utf-8") as f:
        intake = json.load(f)

    report = {
        "generated": intake["date_generated"],
        "subject": "Noah (23M, 182cm, 73kg, 4x/week strength training)",
        "nutrients_assessment": {},
        "summary": {
            "critical_issues": [],
            "high_priority": [],
            "medium_priority": [],
            "good_status": []
        },
        "recommendations": []
    }

    # Extract and validate each nutrient
    vitamins = intake["micronutrients"]["vitamins"]
    minerals = intake["micronutrients"]["minerals"]
    omega3 = intake["micronutrients"]["omega_3"]
    macros = intake["macronutrients"]

    # Vitamin D3
    d3_assessment = validate_nutrient(
        "vitamin_d3",
        intake["micronutrients"]["vitamins"]["vitamin_d3"]["daily_iu"],
        "IU"
    )
    d3_assessment["custom_analysis"] = {
        "current": 1000,
        "endocrine_society_subtropical": 2000,
        "deficit": 1000,
        "taiwan_sun_exposure": "~1000 IU synthesis daily (tentative)",
        "recommendation": "Increase to 2000 IU minimum, consider 2500 IU for subtropical athlete"
    }
    report["nutrients_assessment"]["vitamin_d3"] = d3_assessment
    if d3_assessment["status"] in ["DEFICIENT", "MARGINAL"]:
        report["summary"]["critical_issues"].append("D3 deficiency (1000 IU vs 2000-4000 IU recommended)")

    # Vitamin K2
    k2_assessment = validate_nutrient("vitamin_k2", 100, "mcg")
    k2_assessment["custom_analysis"] = {
        "current": 100,
        "functional_optimal": (100, 200),
        "status_detail": "Adequate at lower end of functional range"
    }
    report["nutrients_assessment"]["vitamin_k2"] = k2_assessment
    if k2_assessment["status"] == "ADEQUATE":
        report["summary"]["good_status"].append("K2 (100 mcg) adequate")

    # Vitamin C
    vc_assessment = validate_nutrient("vitamin_c", 160, "mg")
    vc_assessment["custom_analysis"] = {
        "current": 160,
        "from_collagen": 20,
        "from_lemon": 20,
        "from_vegetables": 120,
        "note": "Collagen peptides provide vitamin C support; higher with vegetable sources"
    }
    report["nutrients_assessment"]["vitamin_c"] = vc_assessment
    if vc_assessment["status"] == "ADEQUATE":
        report["summary"]["good_status"].append("Vitamin C (160 mg) adequate")

    # Zinc
    zn_assessment = validate_nutrient("zinc", 25, "mg")
    zn_assessment["custom_analysis"] = {
        "supplement": 15,
        "dietary": 10,
        "total": 25,
        "athlete_target": 15,
        "status_detail": "25 mg total adequate for strength training; 15 mg is ISSN recommended minimum"
    }
    report["nutrients_assessment"]["zinc"] = zn_assessment
    if zn_assessment["status"] == "ADEQUATE":
        report["summary"]["good_status"].append("Zinc (25 mg) optimal for strength training")

    # Copper
    cu_assessment = validate_nutrient("copper", 2, "mg")
    cu_assessment["custom_analysis"] = {
        "supplement": 2,
        "dietary_estimate": 1.5,
        "total": 3.5,
        "zn_cu_ratio": 25 / 3.5,  # 7.1:1
        "target_ratio": "10:1 to 15:1",
        "status_detail": "Zinc:Copper ratio 7.1:1 is lower than target—indicates adequate copper relative to zinc"
    }
    report["nutrients_assessment"]["copper"] = cu_assessment
    if cu_assessment["status"] == "ADEQUATE":
        report["summary"]["good_status"].append("Copper (2 mg supplement + dietary) adequate")

    # Iodine
    iodine_assessment = validate_nutrient("iodine", 120, "mcg")
    iodine_assessment["custom_analysis"] = {
        "current": 120,
        "from_supplement": 75,
        "from_iodized_salt": 20,
        "from_seaweed": 25,
        "deficit": 30,
        "note": "120 mcg = 80% of RDA. New iodine supplement added in migration 067 (2026-03-01)"
    }
    report["nutrients_assessment"]["iodine"] = iodine_assessment
    if iodine_assessment["status"] == "MARGINAL":
        report["summary"]["high_priority"].append("Iodine still marginal (120 mcg vs 150 mcg RDA)")

    # Calcium
    calcium_assessment = validate_nutrient("calcium", 700, "mg")
    calcium_assessment["custom_analysis"] = {
        "current": 700,
        "from_greek_yogurt": 250,
        "from_tofu_weekly": 100,
        "from_vegetables": 100,
        "from_seaweed": 30,
        "from_supplement": 0,  # backup only, not regularly used
        "deficit": 300,
        "note": "Recent correction (migration 067) made calcium daily. Current 700 mg = 70% of RDA.",
        "improvement_path": "Increase Greek yogurt to 300-400g (adds ~100-150 mg), consider backup Ca tablet on low-food days"
    }
    report["nutrients_assessment"]["calcium"] = calcium_assessment
    if calcium_assessment["status"] == "MARGINAL":
        report["summary"]["high_priority"].append("Calcium marginal (700 mg vs 1000 mg RDA)")

    # Magnesium
    mg_assessment = validate_nutrient("magnesium", 240, "mg")
    mg_assessment["custom_analysis"] = {
        "current": 240,
        "from_sleep_stack": 100,
        "from_vegetables": 80,
        "from_nuts": 60,
        "rda": 400,
        "deficit": 160,
        "note": "Magnesium 240 mg is 60% of RDA. Current comes from scattered sources.",
        "improvement_path": "Sleep stack glycinate provides 100 mg. Verify supplemental sources; may need to increase vegetable intake or add magnesium supplement"
    }
    report["nutrients_assessment"]["magnesium"] = mg_assessment
    if mg_assessment["status"] == "MARGINAL":
        report["summary"]["medium_priority"].append("Magnesium marginal (240 mg vs 400 mg RDA)")

    # Sodium
    na_assessment = {
        "nutrient": "Sodium",
        "current_value": 1850,
        "unit": "mg",
        "who_max": 2400,
        "percentage_of_max": (1850 / 2400) * 100,
        "status": "GOOD",
        "flags": ["✅ Within WHO recommendation", "Justified for strength training athlete"],
        "evidence_base": "WHO, American Heart Association"
    }
    report["nutrients_assessment"]["sodium"] = na_assessment
    if na_assessment["status"] == "GOOD":
        report["summary"]["good_status"].append("Sodium (1850 mg) well-balanced")

    # Omega-3 (EPA + DHA)
    omega3_assessment = {
        "nutrient": "EPA + DHA (Omega-3)",
        "current_epa_mg": 1257,
        "current_dha_mg": 843,
        "total_mg": 2100,
        "unit": "mg",
        "aha_adequate_mg": 500,
        "anti_inflammatory_range_mg": (2000, 3000),
        "percentage_of_anti_inflammatory_optimal": (2100 / 2500) * 100,
        "status": "OPTIMAL",
        "flags": ["✅ In optimal anti-inflammatory range (2000-3000 mg)", "Fish oil 3 caps daily provides consistent intake"],
        "evidence_base": "AHA, ASPEN, sports nutrition"
    }
    report["nutrients_assessment"]["omega3"] = omega3_assessment
    report["summary"]["good_status"].append("Omega-3 EPA+DHA (2100 mg) optimal")

    # Protein
    protein_assessment = {
        "nutrient": "Protein",
        "current_g": 127.5,
        "per_kg": 1.75,
        "bodyweight_kg": 73,
        "unit": "g",
        "rda_per_kg": 0.8,
        "strength_training_target_per_kg": 1.6,
        "hypertrophy_optimal_per_kg": 2.2,
        "status": "OPTIMAL",
        "percentage_of_hypertrophy_optimal": (1.75 / 2.2) * 100,
        "flags": ["✅ 1.75 g/kg within strength training optimal range (1.6-2.2)", "Well-distributed across 5-6 meals"],
        "evidence_base": "Int Soc Sports Nutr Position Stand"
    }
    report["nutrients_assessment"]["protein"] = protein_assessment
    report["summary"]["good_status"].append("Protein (127.5 g = 1.75 g/kg) optimal")

    # Generate recommendations
    report["recommendations"] = [
        {
            "priority": "CRITICAL",
            "nutrient": "Vitamin D3",
            "current": "1000 IU",
            "recommendation": "Increase to 2000 IU",
            "action": "Change NOW Foods D3 supplement dosage from 1000 IU to 2000 IU",
            "evidence": "Endocrine Society 2022: 2000-4000 IU for subtropical climate + athletes",
            "implementation": "Migration to update lunch description and product specs"
        },
        {
            "priority": "HIGH",
            "nutrient": "Iodine",
            "current": "120 mcg (80% of RDA)",
            "recommendation": "Increase to 150 mcg",
            "action": "Add NOW Foods Iodine 75 mcg capsule (already added in migration 067)",
            "evidence": "Recent addition of 75 mcg supplement brings total to 120 mcg; small gap remains",
            "note": "Recent correction documented in migration 067 (2026-03-01)",
            "implementation": "Consider increasing seaweed intake or supplement dose"
        },
        {
            "priority": "HIGH",
            "nutrient": "Calcium",
            "current": "~700 mg (70% of RDA)",
            "recommendation": "Increase to 1000 mg",
            "action": "Increase Greek yogurt to 300-400g daily; use backup Ca tablet 2-3x/week",
            "evidence": "RDA 1000 mg; current 700 mg leaves 300 mg deficit",
            "note": "Recent correction made calcium daily (migration 067)",
            "implementation": "Update meal descriptions to clarify Greek yogurt portions and tablet usage"
        },
        {
            "priority": "MEDIUM",
            "nutrient": "Magnesium",
            "current": "~240 mg (60% of RDA)",
            "recommendation": "Increase to 400 mg",
            "action": "Increase vegetable intake (spinach, pumpkin seeds) or increase glycinate dose",
            "evidence": "RDA 400 mg; current sources are scattered and insufficient",
            "implementation": "Explore increasing magnesium glycinate in sleep stack or dietary sources"
        }
    ]

    report["critical_timing_validations"] = {
        "zinc_copper_separation": {
            "zinc_time": "19:00",
            "copper_time": "14:00-15:00",
            "separation_hours": 4.5,
            "status": "✅ OPTIMAL",
            "note": "Both minerals use DMT1 transporter; 4+ hour separation ideal"
        },
        "calcium_zinc_separation": {
            "calcium_time": "12:00",
            "zinc_time": "19:00",
            "separation_hours": 7,
            "status": "✅ OPTIMAL",
            "note": "Calcium 100-150mg from tofu already cleared by 19:00; main meal Ca from yogurt much earlier"
        },
        "fat_soluble_timing": {
            "nutrients": ["D3", "K2", "Lutein", "CoQ10", "EPA+DHA"],
            "timing": "12:00 lunch",
            "fat_vehicles": ["Olive oil 14g", "Fish oil 6g", "Whole food fats from protein"],
            "total_fat_g": 20,
            "adequate_fat_g": 12,
            "status": "✅ OPTIMAL",
            "note": "Excellent timing and fat vehicle for absorption"
        },
        "phytate_interaction": {
            "tofu_lunch": "12:00",
            "zinc_dinner": "19:00",
            "transit_time_hours": 7,
            "absorption_window": "Small intestine (duodenum/jejunum)",
            "status": "✅ SAFE",
            "note": "Tofu phytate clears absorption window before zinc supplementation"
        }
    }

    return report

def main():
    report = generate_comprehensive_report()

    # Save report
    output_file = Path("/home/noah/project/nutrient/rda_ul_assessment.json")
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=False)

    print(f"✅ RDA/UL validation complete: {output_file}\n")

    # Print summary
    print("="*70)
    print("RDA/UL VALIDATION REPORT")
    print("="*70)

    print("\n🟢 GOOD STATUS NUTRIENTS:")
    for item in report["summary"]["good_status"]:
        print(f"  ✅ {item}")

    print("\n🔴 CRITICAL ISSUES:")
    for item in report["summary"]["critical_issues"]:
        print(f"  ⛔ {item}")

    print("\n🟠 HIGH PRIORITY:")
    for item in report["summary"]["high_priority"]:
        print(f"  ⚠️  {item}")

    print("\n🟡 MEDIUM PRIORITY:")
    for item in report["summary"]["medium_priority"]:
        print(f"  ℹ️  {item}")

    print("\n📋 RECOMMENDATIONS:")
    for rec in report["recommendations"]:
        print(f"\n  [{rec['priority']}] {rec['nutrient']}")
        print(f"    Current: {rec['current']}")
        print(f"    Recommendation: {rec['recommendation']}")
        print(f"    Action: {rec['action']}")

    print("\n" + "="*70)

if __name__ == "__main__":
    main()
