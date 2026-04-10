#!/bin/bash
# Interactive CLIPS Expert System Wrapper
# This script provides proper I/O handling for the diabetes diagnosis system

cd "$(dirname "$0")"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "======================================================"
echo "   EXPERT SYSTEM FOR DIABETES DIAGNOSIS"
echo "   Using Forward-Chaining Architecture in CLIPS"
echo "======================================================"
echo -e "${NC}"
echo ""

# Read patient input
read -p "Enter Patient ID (symbol, e.g., P001): " PATIENT_ID
read -p "Enter Fasting Plasma Glucose - FPG (mg/dL, e.g., 140.5): " FPG
read -p "Enter Hemoglobin A1c - HbA1c (%, e.g., 7.2): " HBAIC

# Validate numeric input
if ! [[ "$FPG" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "ERROR: FPG must be a number"
    exit 1
fi

if ! [[ "$HBAIC" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "ERROR: HbA1c must be a number"
    exit 1
fi

echo ""
echo ">> Initialization COMPLETE. Entering Validation Phase..."
echo ""

# Create CLIPS script with the patient data
clips << EOFCLIPS
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")
(reset)
(assert (patient (id $PATIENT_ID) (fpg $FPG) (hba1c $HBAIC)))
(assert (system-state (phase validation)))
(run)
(exit)
EOFCLIPS
