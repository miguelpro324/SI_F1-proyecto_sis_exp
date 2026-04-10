# Interactive User Guide

## Running the Expert System

The expert system provides three ways to run the diabetes diagnosis application:

---

## Method 1: Interactive Shell Script (Recommended for Most Users)

The easiest way to use the system is through the interactive shell wrapper:

### Unix/Linux:
```bash
./run_interactive.sh
```

### What It Does:
1. Displays a friendly welcome header
2. Prompts you to enter patient information with validation
3. Runs the expert system inference
4. Displays the diagnostic report

### Example Session:
```
======================================================
   EXPERT SYSTEM FOR DIABETES DIAGNOSIS
   Using Forward-Chaining Architecture in CLIPS
======================================================

Enter Patient ID (symbol, e.g., P001): P001
Enter Fasting Plasma Glucose - FPG (mg/dL, e.g., 140.5): 135.0
Enter Hemoglobin A1c - HbA1c (%, e.g., 7.2): 7.2

>> Processing patient data...

[diagnostic report displayed]
```

---

## Method 2: Direct CLIPS Interactive Mode

For advanced users who want direct access to CLIPS:

### Start CLIPS:
```bash
clips
```

### Load the Knowledge Base:
```clips
CLIPS> (load "00_templates.clp")
CLIPS> (load "01_validation.clp")
CLIPS> (load "02_abstraction.clp")
CLIPS> (load "03_diagnostic.clp")
CLIPS> (load "04_cli.clp")
```

### Initialize and Run:
```clips
CLIPS> (reset)
CLIPS> (run)
```

When prompted, enter patient information:
```
Enter Patient ID (symbol, e.g., P001): P001
Enter Fasting Plasma Glucose - FPG (mg/dL, e.g., 140.5): 135.0
Enter Hemoglobin A1c - HbA1c (%, e.g., 7.2): 7.2
```

---

## Method 3: Batch/Scripted Mode

For automated testing or batch processing:

### Create CLIPS Script:
```clips
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")
(reset)

;; Assert patient data directly
(assert (patient (id P001) (fpg 135.0) (hba1c 7.2)))
(assert (system-state (phase validation)))

(run)
(exit)
```

### Run Script:
```bash
clips -f script.clp
```

---

## Input Requirements

### Patient ID
- Must be a CLIPS symbol
- Examples: `P001`, `patient1`, `JOHN_DOE`

### FPG (Fasting Plasma Glucose)
- Numeric value in mg/dL
- Valid range: 0 to 800
- Examples: `135.0`, `100`, `126.5`
- Invalid values will be detected:
  - Negative numbers
  - Values > 800 mg/dL

### HbA1c (Hemoglobin A1c)
- Numeric value as percentage
- Valid range: 0 to 15
- Examples: `7.2`, `6.5`, `5.0`
- Invalid values will be detected:
  - Negative numbers
  - Values > 15%

---

## Output Examples

### Example 1: Type-2-Diabetes Diagnosis
```
Input:  P001, FPG=135.0, HbA1c=7.2

DIAGNOSIS: Type-2-Diabetes

JUSTIFICATION:
  Patient meets diagnostic criteria for Type-2 Diabetes: 
  FPG=135.0mg/dL (>= 126), HbA1c=7.2% (>= 6.5%)

CLINICAL RECOMMENDATION:
  - Schedule comprehensive endocrine evaluation
  - Initiate lifestyle modification program
  - Consider pharmacological management
  - Arrange follow-up testing in 3 months
```

### Example 2: Validation Error
```
Input:  P002, FPG=-50.0 (INVALID), HbA1c=6.5

ERROR: Negative FPG value detected (-50.0 mg/dL).

ERROR TYPE: Negative FPG

DETAILS:
  One or more input values are clinically implausible.
  Please verify the following constraints:

  - FPG must be non-negative (>= 0 mg/dL)
  - FPG should typically be < 800 mg/dL
  - HbA1c must be non-negative (>= 0%)
  - HbA1c should typically be < 15%

ACTION REQUIRED:
  Please re-run the system with corrected input values.
```

### Example 3: Inconclusive Diagnosis
```
Input:  P003, FPG=140.0, HbA1c=6.2

DIAGNOSIS: Inconclusive

JUSTIFICATION:
  Inconclusive: Biomarkers are discordant. FPG=140.0mg/dL, HbA1c=6.2%. 
  Recommend repeat testing and clinical correlation.

CLINICAL RECOMMENDATION:
  - Repeat diagnostic testing within 1-2 weeks
  - Consider oral glucose tolerance test (OGTT)
  - Discuss risk factors with healthcare provider
```

---

## Diagnostic Criteria

The expert system uses WHO/ADA diagnostic criteria:

| Test | Diagnostic Threshold | Result |
|------|----------------------|--------|
| FPG | ≥ 126 mg/dL | Diabetic |
| HbA1c | ≥ 6.5% | Diabetic |

### Diagnosis Rules:
- **Both diabetic** → Type-2-Diabetes
- **Both non-diabetic** → No-Diabetes  
- **Mixed results** → Inconclusive (repeat testing needed)

---

## Troubleshooting

### Issue: Prompts don't appear in interactive mode
**Solution**: The CLIPS interactive mode requires proper terminal configuration. Use the shell wrapper script (`run_interactive.sh`) instead.

### Issue: Error "Missing function declaration"
**Solution**: Make sure all files are loading correctly. Check that all .clp files are in the same directory.

### Issue: Invalid input error
**Solution**: 
- Check that Patient ID is a valid CLIPS symbol (no spaces or special characters)
- Ensure FPG and HbA1c are numeric values
- Verify values are within valid ranges

### Issue: "Inconclusive" diagnosis when expecting clear result
**Solution**: This is correct behavior when biomarkers disagree. The system requires repeat testing to confirm diagnosis.

---

## Advanced Usage

### Running Multiple Cases in Batch:
```bash
for patient in P001 P002 P003; do
    echo "Processing $patient..."
    # Create custom script for each patient
done
```

### Automated Test Suite:
```bash
# Test 1: Type-2-Diabetes
clips -f test_system.clp

# Test 2: Validation Error
clips -f test_validation_error.clp

# Test 3: Inconclusive
clips -f test_inconclusive.clp
```

---

## Support Information

- **System**: Expert System for Medical Diagnosis of Diabetes
- **Language**: Pure CLIPS (6.4.2+)
- **Architecture**: Forward-chaining multi-phase inference
- **Files**: 5 core .clp files + documentation

For questions or issues, refer to:
- `README.md` - System overview and architecture
- `TEST_RESULTS.md` - Detailed test scenarios
- `DELIVERY_SUMMARY.md` - Complete project documentation

---

**Note**: This system is for educational and demonstration purposes. For actual medical diagnosis, always consult a qualified healthcare professional.
