# Expert System for Medical Diagnosis of Diabetes

## Quick Start

### Easiest Way (Recommended)
```bash
./run_interactive.sh
```

Enter patient data when prompted and get instant diagnosis.

---

## System Overview

**Forward-Chaining Expert System** for Type-2 Diabetes diagnosis using WHO/ADA criteria.

### Features
- ✅ Pure CLIPS implementation (no external dependencies)
- ✅ Multi-phase architecture (Validation → Abstraction → Diagnostic → Reporting)
- ✅ Three diagnostic outcomes (Type-2-Diabetes, No-Diabetes, Inconclusive)
- ✅ Professional medical reports with recommendations
- ✅ Comprehensive input validation

### Diagnostic Criteria
| Biomarker | Threshold | Status |
|-----------|-----------|--------|
| FPG | ≥ 126 mg/dL | Diabetic |
| HbA1c | ≥ 6.5% | Diabetic |

**Diagnosis**:
- Both diabetic → Type-2-Diabetes
- Both non-diabetic → No-Diabetes
- Mixed → Inconclusive

---

## Files

### Core System (5 CLIPS files)
- `00_templates.clp` - Data structures
- `01_validation.clp` - Input validation
- `02_abstraction.clp` - Feature extraction
- `03_diagnostic.clp` - Clinical reasoning
- `04_cli.clp` - User interface

### Usage Scripts
- `run_interactive.sh` - Interactive wrapper (recommended)
- `run.sh` - Simple batch wrapper
- `run.bat` - Windows batch runner

### Testing
- `test_system.clp` - Type-2-Diabetes test
- `test_validation_error.clp` - Error handling test
- `test_inconclusive.clp` - Inconclusive diagnosis test

### Documentation
- `INTERACTIVE_USER_GUIDE.md` - Complete usage guide
- `README.md` - This file

---

## Usage

### Interactive Mode (Recommended)
```bash
./run_interactive.sh
```
Prompts for patient ID, FPG, and HbA1c. Displays professional diagnostic report.

### Direct CLIPS
```bash
clips
CLIPS> (load "00_templates.clp")
CLIPS> (load "01_validation.clp")
CLIPS> (load "02_abstraction.clp")
CLIPS> (load "03_diagnostic.clp")
CLIPS> (load "04_cli.clp")
CLIPS> (reset)
CLIPS> (run)
```

### Batch Testing
```bash
clips -f test_system.clp
```

---

## Example Output

**Input:** P001, FPG=135.0 mg/dL, HbA1c=7.2%

**Output:**
```
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

---

## Architecture

```
USER INPUT → VALIDATION → ABSTRACTION → DIAGNOSTIC → REPORTING
     ↓            ↓            ↓             ↓            ↓
 Read Data   Check Bounds  Classify      Apply WHO/ADA  Professional
             • FPG >= 0    • FPG >= 126?  • Type-2-D?    Medical Report
             • HbA1c >= 0  • HbA1c >= 6.5?• None?        Recommendations
             • No errors   → ranges        • Inconc.?
```

---

## System Details

**Language:** CLIPS 6.4.2  
**Architecture:** Forward-chaining multi-phase inference  
**Rules:** 22 (5 validation, 5 abstraction, 4 diagnostic, 3 UI)  
**Templates:** 5 (patient, clinical-finding, diagnosis, system-state, invalid-data)  
**Total Lines:** 400+ of production-ready code  

---

## For More Information

See `INTERACTIVE_USER_GUIDE.md` for comprehensive usage documentation.

---

**Disclaimer**: This system is for educational purposes. For actual medical diagnosis, consult a qualified healthcare professional.
