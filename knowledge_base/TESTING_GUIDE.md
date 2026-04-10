# Testing Guide for Diabetes Diagnosis Expert System

This guide provides complete instructions for testing the Expert System for Diabetes Diagnosis, including both manual interactive testing and automated test suites.

## Architecture Overview

The system uses a forward-chaining, multi-phase architecture:

1. **Validation Phase**: Checks for clinically impossible values
2. **Abstraction Phase**: Classifies biomarkers into ranges (normal, prediabetic, diabetic)
3. **Diagnostic Phase**: Applies clinical decision rules to produce diagnoses
4. **Reporting Phase**: Generates professional output reports

## Quick Start Testing

### For English Users

```bash
cd knowledge_base

# Option 1: Interactive manual testing
./run_interactive.sh

# Option 2: Automated test suite (16 tests)
./test_all_diagnostics.sh
```

### For Spanish Users

```bash
cd knowledge_base

# Option 1: Interactive manual testing (Spanish)
./run_interactive_es.sh

# Option 2: Automated test suite (7 tests)
./test_all_diagnostics_es.sh
```

---

## Manual Interactive Testing

### Running Interactive Mode

The interactive wrapper provides a user-friendly interface:

```bash
./run_interactive.sh    # English
./run_interactive_es.sh # Spanish
```

### What to Expect

```
Enter Patient ID (symbol, e.g., P001): P001
Enter Fasting Plasma Glucose - FPG (mg/dL, e.g., 140.5): 135
Enter Hemoglobin A1c - HbA1c (%, e.g., 7.2): 7.2
Type-1 Diabetes Indicators present? (family history, early onset, autoimmune markers) (yes/no): no

>> Processing patient data...

DIAGNOSIS: Type-2-Diabetes
-----------------------------------------------------
JUSTIFICATION:
  Patient meets diagnostic criteria for Type-2 Diabetes: FPG=135.0mg/dL (>= 126), HbA1c=7.2% (>= 6.5)

CLINICAL RECOMMENDATION:
  - Schedule comprehensive endocrine evaluation
  - Initiate lifestyle modification program
  - Consider pharmacological management
```

### Input Validation

The shell wrapper validates inputs before passing to CLIPS:

- **FPG**: Must be 0-800 mg/dL (realistic clinical range)
- **HbA1c**: Must be 0-15% (realistic clinical range)
- **Type-1 Indicators**: Must be "yes" or "no"

If invalid, you'll be prompted to re-enter:

```
ERROR: FPG must be between 0 and 800 mg/dL. Please try again.
Enter Fasting Plasma Glucose - FPG (mg/dL, e.g., 140.5): 
```

---

## Automated Testing

### English Test Suite

Run all 16 diagnostic tests automatically:

```bash
./test_all_diagnostics.sh
```

**Output Example:**
```
======================================================
  DIABETES DIAGNOSIS EXPERT SYSTEM - TEST SUITE
======================================================

HEALTHY (Normal glucose control):
✓ H1: Both normal ... PASS
✓ H2: Both at lower boundaries ... PASS
✓ H3: FPG borderline ... PASS

PREDIABETES (Impaired fasting glucose or impaired A1c):
✓ P1: FPG prediabetic ... PASS
...
Type-1-Diabetes (Both diabetic range, with Type-1 indicators):
✓ T1-1: Type-1 indicators present ... PASS

======================================================
  TEST RESULTS: 16 PASSED, 0 FAILED
======================================================

✓ All tests passed!
```

### Spanish Test Suite

Run 7 core diagnostic tests in Spanish:

```bash
./test_all_diagnostics_es.sh
```

---

## Complete Test Coverage

The system now supports **5 diagnostic categories**:

### 1. Healthy (Normal Glucose Control)

**Test Case:**
- Patient ID: P_Healthy_001
- FPG: 90 mg/dL
- HbA1c: 5.5%
- Type-1 Indicators: no
- Expected: **Healthy**

**CLI Command:**
```bash
./run_interactive.sh
# Input: P_Healthy_001, 90, 5.5, no
```

**Expected Output:**
```
DIAGNOSIS: Healthy
JUSTIFICATION: Patient has normal glucose control: FPG=90.0mg/dL (< 100), HbA1c=5.5% (< 5.7)
```

---

### 2. Prediabetes (Impaired Glucose Tolerance)

**Test Cases:**
- FPG 100-125 OR HbA1c 5.7-6.4 (but NOT both diabetic or discordant)

**Example:**
- Patient ID: P_Predia_001
- FPG: 110 mg/dL
- HbA1c: 5.5%
- Type-1 Indicators: no
- Expected: **Prediabetes**

**CLI Command:**
```bash
./run_interactive.sh
# Input: P_Predia_001, 110, 5.5, no
```

**Expected Output:**
```
DIAGNOSIS: Prediabetes
JUSTIFICATION: Patient has prediabetic glucose levels: FPG=110.0mg/dL, HbA1c=5.5%. Recommend lifestyle modifications and monitoring.
```

---

### 3. Inconclusive (Discordant Biomarkers)

**Diagnostic Criteria:**
- One biomarker ≥ diabetic threshold, one below
- Requires further testing

**Test Case:**
- Patient ID: P_Inconclusive_001
- FPG: 140 mg/dL (diabetic)
- HbA1c: 6.2% (prediabetic)
- Type-1 Indicators: no
- Expected: **Inconclusive**

**CLI Command:**
```bash
./run_interactive.sh
# Input: P_Inconclusive_001, 140, 6.2, no
```

**Expected Output:**
```
DIAGNOSIS: Inconclusive
JUSTIFICATION: Inconclusive: Biomarkers are discordant. FPG=140.0mg/dL, HbA1c=6.2%. Recommend repeat testing and clinical correlation.
```

---

### 4. Type-2-Diabetes (Adult-Onset Diabetes)

**Diagnostic Criteria:**
- FPG ≥ 126 AND HbA1c ≥ 6.5
- Type-1 Indicators: no

**Test Case:**
- Patient ID: P_Type2_001
- FPG: 135 mg/dL
- HbA1c: 7.2%
- Type-1 Indicators: no
- Expected: **Type-2-Diabetes**

**CLI Command:**
```bash
./run_interactive.sh
# Input: P_Type2_001, 135, 7.2, no
```

**Expected Output:**
```
DIAGNOSIS: Type-2-Diabetes
JUSTIFICATION: Patient meets diagnostic criteria for Type-2 Diabetes: FPG=135.0mg/dL (>= 126), HbA1c=7.2% (>= 6.5)
CLINICAL RECOMMENDATION:
  - Schedule comprehensive endocrine evaluation
  - Initiate lifestyle modification program
  - Consider pharmacological management
```

---

### 5. Type-1-Diabetes (Autoimmune Diabetes)

**Diagnostic Criteria:**
- FPG ≥ 126 AND HbA1c ≥ 6.5
- Type-1 Indicators: yes

**Test Case:**
- Patient ID: P_Type1_001
- FPG: 200 mg/dL
- HbA1c: 8.5%
- Type-1 Indicators: yes
- Expected: **Type-1-Diabetes**

**CLI Command:**
```bash
./run_interactive.sh
# Input: P_Type1_001, 200, 8.5, yes
```

**Expected Output:**
```
DIAGNOSIS: Type-1-Diabetes
JUSTIFICATION: Patient meets diagnostic criteria for Type-1 Diabetes: FPG=200.0mg/dL (>= 126), HbA1c=8.5% (>= 6.5). Type-1 indicators present (family history, early onset, or autoimmune markers).
CLINICAL RECOMMENDATION:
  - URGENT: Refer to endocrinologist
  - Initiate insulin therapy immediately
  - Comprehensive metabolic panel and autoimmune testing
  - Diabetes education and self-management training
  - Frequent follow-up (initially every 1-2 weeks)
```

---

## Boundary Value Testing

Test the system's accuracy at diagnostic boundaries:

| Test | FPG | HbA1c | Expected | Notes |
|------|-----|-------|----------|-------|
| B1 | 99.9 | 5.69 | Healthy | Just below all thresholds |
| B2 | 100.0 | 5.70 | Prediabetes | At prediabetic threshold |
| B3 | 125.9 | 6.49 | Prediabetes | Just below diabetic threshold |
| B4 | 126.0 | 6.50 | Type-2-Diabetes | At diabetic threshold (no Type-1) |
| B5 | 126.0 | 6.50 | Type-1-Diabetes | At diabetic threshold (with Type-1) |

**Manual Testing Boundary Values:**

```bash
./run_interactive.sh
# Test B1: P_B1, 99.9, 5.69, no -> Healthy
# Test B4: P_B4, 126.0, 6.50, no -> Type-2-Diabetes
# Test B5: P_B5, 126.0, 6.50, yes -> Type-1-Diabetes
```

---

## Error Handling Tests

### Invalid Data

The validation phase catches clinically impossible values:

**Test: Negative FPG**
```
Enter Patient ID: P_Invalid1
Enter FPG: -50
ERROR: FPG must be between 0 and 800 mg/dL. Please try again.
```

**Test: Excessive HbA1c**
```
Enter Patient ID: P_Invalid2
Enter HbA1c: 20
ERROR: HbA1c must be between 0 and 15%. Please try again.
```

### Type-1 Indicator Validation

**Test: Invalid Type-1 Response**
```
Type-1 Diabetes Indicators present? (yes/no): maybe
ERROR: Please answer yes or no.
```

---

## Performance Notes

- **Average execution time per test**: 3-5 seconds
- **Automated suite (16 tests)**: ~50-80 seconds total
- **Spanish suite (7 tests)**: ~25-35 seconds total

---

## Troubleshooting

### Script Won't Execute

```bash
# Make scripts executable
chmod +x run_interactive.sh
chmod +x run_interactive_es.sh
chmod +x test_all_diagnostics.sh
chmod +x test_all_diagnostics_es.sh
```

### CLIPS Not Found

```bash
# Install CLIPS (Ubuntu/Debian)
sudo apt-get install clips

# Or build from source: http://clipsrules.sourceforge.net/
```

### Unexpected Diagnosis

1. Check FPG and HbA1c values against diagnostic criteria (see TEST_VALUES_REFERENCE.md)
2. Verify Type-1 Indicators match expected diagnosis
3. Run `./test_all_diagnostics.sh` to validate system integrity

---

## Test Results Archive

After running test suites, results are printed to stdout. To save results:

```bash
# Save English test results
./test_all_diagnostics.sh > test_results_en.txt

# Save Spanish test results
./test_all_diagnostics_es.sh > test_results_es.txt
```

---

## Advanced Testing (Manual CLIPS)

For expert users, test CLIPS directly:

```bash
clips
CLIPS> (load "00_templates.clp")
CLIPS> (load "01_validation.clp")
CLIPS> (load "02_abstraction.clp")
CLIPS> (load "03_diagnostic.clp")
CLIPS> (load "04_cli.clp")
CLIPS> (reset)
CLIPS> (assert (patient (id P1) (fpg 135.0) (hba1c 7.2) (type-1-indicators no)))
CLIPS> (assert (system-state (phase validation)))
CLIPS> (run)
```

Expected output will display diagnosis and recommendations.

---

## Regression Testing Checklist

Use this checklist before committing changes:

- [ ] All 16 English tests pass
- [ ] All 7 Spanish tests pass
- [ ] Healthy diagnosis works correctly
- [ ] Prediabetes diagnosis works correctly
- [ ] Inconclusive diagnosis works correctly
- [ ] Type-2-Diabetes diagnosis works correctly
- [ ] Type-1-Diabetes diagnosis works correctly
- [ ] Boundary values are classified correctly
- [ ] Invalid inputs are rejected
- [ ] System transitions through all phases without error

---

## Documentation

- **System Architecture**: README.md (English), README_ES.md (Spanish)
- **Test Values**: TEST_VALUES_REFERENCE.md
- **User Guide**: INTERACTIVE_USER_GUIDE.md
- **Source Code**: See individual CLIPS files (00_templates.clp through 04_cli.clp)
