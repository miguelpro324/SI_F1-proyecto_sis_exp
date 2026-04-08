# Diabetes Expert System - Rule-Based Medical Diagnosis

A production-rule expert system for diagnosing Type 2 Diabetes using C++ and CLIPS (C Language Integrated Production System).

## 🏥 System Overview

This expert system implements forward-chaining inference to diagnose diabetes based on clinical biomarkers:
- **Fasting Plasma Glucose (FPG)** - measured in mg/dL
- **Hemoglobin A1c (HbA1c)** - measured in %

The system follows American Diabetes Association (ADA) diagnostic criteria and employs a multi-phase reasoning approach.

## 📁 Project Structure

```
SI_F1-proyecto_sis_exp/
├── knowledge_base/           # CLIPS Production Rules
│   ├── 00_templates.clp     # Fact templates (patient, diagnosis, etc.)
│   ├── 01_validation.clp    # Input validation rules
│   ├── 02_abstraction.clp   # Data interpretation rules
│   └── 03_diagnostic.clp    # Diagnostic conclusion rules
├── src/                      # C++ Application
│   ├── InferenceEngine.hpp  # CLIPS C API wrapper interface
│   ├── InferenceEngine.cpp  # CLIPS wrapper implementation
│   └── main.cpp             # CLI application entry point
├── test/
│   └── run_tests.sh         # Automated test suite
├── external/                 # External dependencies (CLIPS)
├── Makefile                  # Build configuration
└── README.md                # This file
```

## 🔧 Prerequisites

### Required
- **C++ Compiler:** g++ with C++17 support
- **CLIPS:** Version 6.30+ (C Language Integrated Production System)

### Installing CLIPS

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install clips libclips-dev
```

**Fedora/RHEL:**
```bash
sudo dnf install clips clips-devel
```

**macOS (via Homebrew):**
```bash
brew install clips
```

**Manual Installation:**
Download CLIPS 6.40 from [SourceForge](https://sourceforge.net/projects/clipsrules/files/CLIPS/6.40/) and extract source files to `external/clips/core/`

## 🚀 Building the System

### Quick Start (using system CLIPS library)
```bash
make
```

### Using CLIPS Source Files
```bash
make with-source
```

### Manual Compilation
```bash
g++ -std=c++17 -Wall -Wextra \
    src/main.cpp \
    src/InferenceEngine.cpp \
    -lclips -lm \
    -o diabetes_expert_system
```

**OR** (with CLIPS source):
```bash
g++ -std=c++17 -Wall -Wextra \
    src/main.cpp \
    src/InferenceEngine.cpp \
    external/clips/core/*.c \
    -Iexternal/clips/core \
    -lm \
    -o diabetes_expert_system
```

## 📊 Running the System

### Interactive Mode
```bash
./diabetes_expert_system
```

You will be prompted to enter:
1. Patient ID (integer)
2. Fasting Plasma Glucose (FPG) in mg/dL
3. Hemoglobin A1c (HbA1c) in %

### Example Session
```
========================================
  DIABETES DIAGNOSIS EXPERT SYSTEM
  Rule-Based Medical Inference Engine
========================================

--- Patient Data Entry ---
Enter Patient ID: 1001
Enter Fasting Plasma Glucose (FPG) in mg/dL: 145.0
Enter Hemoglobin A1c (HbA1c) in %: 7.2

========== DIAGNOSIS REPORT ==========
Patient ID: 1001
Classification: type-2-diabetes
Justification: Both FPG >= 126 mg/dL and HbA1c >= 6.5% meet diagnostic criteria for Type 2 Diabetes Mellitus
======================================
```

## 🧪 Test Cases

Run the automated test suite:
```bash
./test/run_tests.sh
```

### Predefined Test Cases

| Test | Patient ID | FPG (mg/dL) | HbA1c (%) | Expected Diagnosis |
|------|-----------|-------------|-----------|-------------------|
| 1    | 1001      | 145.0       | 7.2       | Type 2 Diabetes   |
| 2    | 1002      | 110.0       | 6.0       | Prediabetes       |
| 3    | 1003      | 90.0        | 5.2       | Normal            |
| 4    | 1004      | -50.0       | 6.0       | Validation Error  |
| 5    | 1005      | 126.0       | 6.5       | Type 2 Diabetes   |

## 📚 Knowledge Base Architecture

### Phase-Based Execution Model

The system uses a **state machine** pattern with distinct reasoning phases:

1. **Validation Phase** (`01_validation.clp`)
   - Detects negative or physiologically impossible values
   - Halts execution with error state if invalid data detected
   - Transitions to abstraction phase if validation passes

2. **Abstraction Phase** (`02_abstraction.clp`)
   - Transforms raw biomarker values into clinical interpretations
   - Classifies values as: `diabetic-range`, `prediabetic-range`, or `normal-range`
   - Applies ADA clinical thresholds

3. **Diagnostic Phase** (`03_diagnostic.clp`)
   - Synthesizes clinical findings into final diagnosis
   - Requires BOTH markers in diabetic range for Type 2 Diabetes
   - Generates justification for diagnosis

### Diagnostic Criteria (ADA Standards)

**Type 2 Diabetes:**
- FPG ≥ 126 mg/dL **AND** HbA1c ≥ 6.5%

**Prediabetes:**
- FPG 100-125 mg/dL **OR** HbA1c 5.7-6.4%
- One marker in diabetic range but not both

**Normal:**
- FPG < 100 mg/dL **AND** HbA1c < 5.7%

## 🏗️ Technical Architecture

### Separation of Concerns

| Component | Responsibility | Technology |
|-----------|---------------|------------|
| **Knowledge Base** | Medical domain logic, diagnostic rules | CLIPS (Production Rules) |
| **Inference Engine** | Rule execution, pattern matching, conflict resolution | CLIPS C API |
| **Application Layer** | User I/O, data collection, result presentation | C++ |

### CLIPS C API Integration

The `InferenceEngine` class provides a clean C++ wrapper around CLIPS:

```cpp
// Core lifecycle methods
InferenceEngine();                              // CreateEnvironment()
~InferenceEngine();                             // DestroyEnvironment()
bool loadKnowledgeBase(vector<string>& files);  // EnvLoad()
bool reset();                                   // EnvReset()
bool assertPatientData(int id, float fpg, float hba1c); // EnvAssertString()
long run(long maxRules = -1);                   // EnvRun()
void printDiagnosis();                          // EnvGetNextFact(), EnvGetFactSlot()
```

## 🔍 Inference Trace Example

For Patient ID 1001 with FPG=145.0, HbA1c=7.2:

```
1. Load knowledge base (4 files)
2. Reset environment → assert (initial-fact)
3. Assert (patient (id 1001) (fpg 145.0) (hba1c 7.2))
4. Assert (system-state (phase validation))
5. Run inference engine:
   → validate-fpg-negative: NO MATCH (145.0 > 0)
   → validate-hba1c-negative: NO MATCH (7.2 > 0)
   → validation-passed: MATCH → assert (system-state (phase abstraction))
   → abstract-fpg-diabetic: MATCH → assert (clinical-finding fpg diabetic-range)
   → abstract-hba1c-diabetic: MATCH → assert (clinical-finding hba1c diabetic-range)
   → abstraction-complete: MATCH → assert (system-state (phase diagnostic))
   → diagnose-type2-diabetes: MATCH → assert (diagnosis type-2-diabetes)
   → diagnostic-complete: MATCH → assert (system-state (phase complete))
6. Extract diagnosis fact and display
```

## 🛡️ Error Handling

The system includes comprehensive validation:

- **Negative values:** Rejected (e.g., FPG < 0)
- **Extreme values:** Rejected (FPG > 600 mg/dL, HbA1c > 15%)
- **Missing CLIPS files:** Build-time error
- **Fact assertion failures:** Runtime error with diagnostic message

## 📖 References

- **American Diabetes Association (ADA):** Standards of Medical Care in Diabetes
- **CLIPS Documentation:** [CLIPS Reference Manual](https://www.clipsrules.net/Documentation.html)
- **Expert Systems:** Jackson, P. (1998). Introduction to Expert Systems (3rd ed.)

## 🤝 Contributing

This is an educational project for demonstrating rule-based expert systems. Suggestions for improvements:

1. Add support for additional biomarkers (Oral Glucose Tolerance Test)
2. Implement explanation facility (trace rule firing)
3. Add confidence factors for uncertain data
4. Extend to Type 1 Diabetes and gestational diabetes

## 📄 License

Educational project - Universidad Católica de Santa María (UCSM)

---

**Developed for:** Sistemas Inteligentes - Semestre 7  
**Institution:** UCSM, Arequipa, Perú
Repository for the source code of the expert system.
