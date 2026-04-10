#!/bin/bash
# Interactive CLIPS Expert System - Diabetes Diagnosis
# Provides a user-friendly interface for the expert system

cd "$(dirname "$0")"

echo ""
echo "======================================================"
echo "   EXPERT SYSTEM FOR DIABETES DIAGNOSIS"
echo "   Using Forward-Chaining Architecture in CLIPS"
echo "======================================================"
echo ""

# Read patient input with validation loop
while true; do
    read -p "Enter Patient ID (symbol, e.g., P001): " PATIENT_ID
    if [ -z "$PATIENT_ID" ]; then
        echo "ERROR: Patient ID cannot be empty. Please try again."
        continue
    fi
    break
done

while true; do
    read -p "Enter Fasting Plasma Glucose - FPG (mg/dL, e.g., 140.5): " FPG
    if [[ "$FPG" =~ ^[0-9]+([.][0-9]+)?$ ]] && (( $(echo "$FPG >= 0 && $FPG <= 800" | bc -l) )); then
        break
    else
        echo "ERROR: FPG must be between 0 and 800 mg/dL. Please try again."
    fi
done

while true; do
    read -p "Enter Hemoglobin A1c - HbA1c (%, e.g., 7.2): " HBAIC
    if [[ "$HBAIC" =~ ^[0-9]+([.][0-9]+)?$ ]] && (( $(echo "$HBAIC >= 0 && $HBAIC <= 15" | bc -l) )); then
        break
    else
        echo "ERROR: HbA1c must be between 0 and 15%. Please try again."
    fi
done

while true; do
    read -p "Type-1 Diabetes Indicators present? (family history, early onset, autoimmune markers) (yes/no): " TYPE1_IND
    if [[ "$TYPE1_IND" =~ ^(yes|no)$ ]]; then
        break
    else
        echo "ERROR: Please answer yes or no."
    fi
done

echo ""
echo ">> Processing patient data..."
echo ""

# Convert FPG and HbA1c to ensure they are treated as floats by CLIPS
FPG_FLOAT=$(echo "$FPG" | grep -q '\.' && echo "$FPG" || echo "$FPG.0")
HBAIC_FLOAT=$(echo "$HBAIC" | grep -q '\.' && echo "$HBAIC" || echo "$HBAIC.0")

# Run CLIPS with the patient data
clips << EOFCLIPS
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")
(reset)
(assert (patient (id $PATIENT_ID) (fpg $FPG_FLOAT) (hba1c $HBAIC_FLOAT) (type-1-indicators $TYPE1_IND)))
(assert (system-state (phase validation)))
(run)
(exit)
EOFCLIPS

echo ""
echo "======================================================"
echo "Analysis complete."
echo "======================================================"
echo ""
