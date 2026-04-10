# Pure CLIPS Implementation - User Guide

## Overview

The diabetes expert system has been redesigned as a **pure CLIPS implementation** with no C++ wrapper. All functionality—from user interface to inference—runs entirely within the CLIPS environment.

## File Structure

```
knowledge_base/
├── 00_templates.clp                    (Fact templates)
├── 01_validation.clp                   (Validation rules)
├── 02_abstraction.clp                  (Interpretation rules)
├── 03_diagnostic.clp                   (Diagnosis rules)
├── 04_cli.clp                         (NEW - User Interface)
├── CLIPS_CONSOLE_INSTRUCTIONS.txt      (This file - console commands)
├── CLIPS_COMMANDS.sh                   (Linux/Mac execution script)
└── clips_run.bat                       (Windows execution script)
```

## Quick Start

### Option 1: Using Linux/Mac Shell Script

```bash
cd knowledge_base
clips < CLIPS_COMMANDS.sh
```

### Option 2: Using Windows Batch File

```cmd
cd knowledge_base
clips_run.bat
```

### Option 3: Manual CLIPS Console (All Platforms)

1. Start CLIPS:
   ```
   clips
   ```

2. Load all files:
   ```
   (batch knowledge_base/00_templates.clp)
   (batch knowledge_base/01_validation.clp)
   (batch knowledge_base/02_abstraction.clp)
   (batch knowledge_base/03_diagnostic.clp)
   (batch knowledge_base/04_cli.clp)
   ```

3. Initialize and run:
   ```
   (reset)
   (run)
   ```

4. Follow the prompts to enter patient data.

## New File: 04_cli.clp

The new CLI module provides:

### 1. **Startup Rule** (`startup-display-welcome`)
- Triggers automatically on `(initial-fact)`
- Displays welcome banner
- Prompts user for:
  - Patient ID (integer)
  - Fasting Plasma Glucose in mg/dL (float)
  - Hemoglobin A1c in % (float)
- Uses `(read)` to capture input
- Asserts `patient` fact with captured values
- Asserts `(system-state (phase validation))` to start inference

### 2. **Output Formatting Rules**

#### Rule: `output-diagnosis-success`
- Triggers when diagnosis is complete
- Prints formatted medical report including:
  - Patient ID
  - Classification (type-2-diabetes, prediabetes, normal)
  - Clinical justification

#### Rule: `output-validation-error`
- Triggers if validation fails (error phase)
- Prints error message explaining validation failure

#### Additional Status Rules
- `output-abstraction-status` - Prints when entering abstraction phase
- `output-diagnostic-status` - Prints when entering diagnostic phase

### 3. **Optional Debugging Rules** (Commented Out)
- `trace-validation-passed` - Shows validation completion
- `trace-clinical-findings` - Shows clinical findings as asserted

## Execution Flow

```
START CLIPS
    ↓
Load Templates (00)
    ↓
Load Validation Rules (01)
    ↓
Load Abstraction Rules (02)
    ↓
Load Diagnostic Rules (03)
    ↓
Load UI Rules (04)
    ↓
(reset) - Asserts (initial-fact)
    ↓
(run) - Starts inference
    ↓
startup-display-welcome fires
    ↓
User enters Patient ID, FPG, HbA1c
    ↓
patient fact asserted
    ↓
system-state (phase validation) asserted
    ↓
Validation rules fire
    ↓
If valid:
  → Abstraction rules fire
    → output-abstraction-status prints
    → clinical-finding facts asserted
  → Diagnostic rules fire
    → output-diagnostic-status prints
    → diagnosis fact asserted
    → system-state (phase complete)
  → output-diagnosis-success prints report
    
If invalid:
  → system-state (phase error)
  → output-validation-error prints error
```

## Example Usage Session

### Input:
```
Patient ID: 1001
FPG: 145.0
HbA1c: 7.2
```

### Output:
```
========================================
  DIABETES DIAGNOSIS EXPERT SYSTEM
  Rule-Based Medical Inference Engine
========================================

--- Patient Data Entry ---
Enter Patient ID (integer): 1001
Enter Fasting Plasma Glucose (FPG) in mg/dL (float): 145.0
Enter Hemoglobin A1c (HbA1c) in % (float): 7.2

--- Data Summary ---
Patient ID: 1001
FPG: 145.0 mg/dL
HbA1c: 7.2%

Starting inference engine...

========== ABSTRACTION PHASE ==========
Interpreting biomarker values...

========== DIAGNOSTIC PHASE ==========
Generating diagnostic conclusions...

========================================
  DIAGNOSTIC REPORT
========================================

Patient ID: 1001
Classification: type-2-diabetes
Justification: 
  Both FPG >= 126 mg/dL and HbA1c >= 6.5% meet diagnostic criteria for 
  Type 2 Diabetes Mellitus

========================================

Diagnostic reasoning complete.
```

## Test Cases

### Test 1: Type 2 Diabetes
```
Patient ID: 1001
FPG: 145.0
HbA1c: 7.2
Expected: type-2-diabetes
```

### Test 2: Prediabetes
```
Patient ID: 1002
FPG: 110.0
HbA1c: 6.0
Expected: prediabetes
```

### Test 3: Normal Glucose
```
Patient ID: 1003
FPG: 90.0
HbA1c: 5.2
Expected: normal
```

### Test 4: Validation Error (Negative FPG)
```
Patient ID: 1004
FPG: -50.0
HbA1c: 6.0
Expected: ERROR message
```

## CLIPS Commands Reference

### Core Commands Used

| Command | Purpose | Example |
|---------|---------|---------|
| `(batch file.clp)` | Load a CLIPS file | `(batch 00_templates.clp)` |
| `(reset)` | Clear memory, assert initial-fact | `(reset)` |
| `(run)` | Execute inference engine | `(run)` |
| `(read)` | Read user input | `(bind ?x (read))` |
| `(printout t ...)` | Print to console | `(printout t "Hello")` |
| `(assert fact)` | Add fact to memory | `(assert (patient ...))` |
| `(facts)` | List all facts | `(facts)` |
| `(rules)` | List all rules | `(rules)` |
| `(exit)` | Exit CLIPS | `(exit)` |

### Diagnostic Commands

```
; View working memory
(facts)

; View loaded rules
(rules)

; Get fact count
(fact-index)

; Watch rule firing
(watch rules)

; Unwatch
(unwatch all)

; Manual fact assertion
(assert (patient (id 1001) (fpg 145.0) (hba1c 7.2)))

; Manual state change
(assert (system-state (phase validation)))
```

## Advantages of Pure CLIPS Implementation

1. **No C++ Compilation** - Run directly in CLIPS interpreter
2. **Faster Development** - No compile/link cycle
3. **Educational Value** - All logic in one declarative language
4. **Portability** - Works anywhere CLIPS is installed
5. **Debugging** - Use CLIPS built-in tools (watch, trace, facts)
6. **Simplicity** - No multi-language integration complexity

## Limitations vs C++ Version

1. **Performance** - Interpreted rather than compiled
2. **User Experience** - Terminal-based rather than GUI
3. **Scale** - Works well for educational demos, not high-volume production
4. **Integration** - Can't easily embed in other systems

## Requirements

- **CLIPS** version 6.30 or later
- Terminal or command prompt
- Basic understanding of CLIPS syntax

## Installation

### Ubuntu/Debian:
```bash
sudo apt-get install clips
```

### Fedora/RHEL:
```bash
sudo dnf install clips
```

### macOS:
```bash
brew install clips
```

### Windows:
Download from https://sourceforge.net/projects/clipsrules/

## Troubleshooting

### Problem: "File not found"
**Solution:** Change to project directory first
```
clips
(chdir "/full/path/to/project")
(batch knowledge_base/00_templates.clp)
```

### Problem: "Unknown variable"
**Solution:** Load all files in order (00→04)

### Problem: CLIPS hangs during (read)
**Solution:** Enter a value and press Enter

### Problem: Can't find CLIPS command
**Solution:** Add CLIPS to PATH or use full path

## Further Customization

### Adding New Input Fields

Edit `04_cli.clp` `startup-display-welcome` rule:

```clips
(printout t "Enter new field: ")
(bind ?new-field (read))
(assert (some-fact (field ?new-field)))
```

### Adding New Output Formats

Create a new output rule in `04_cli.clp`:

```clips
(defrule output-custom
  (some-fact (id ?id) (value ?v))
  =>
  (printout t "Custom Report: ID=" ?id ", Value=" ?v crlf))
```

### Changing Diagnostic Thresholds

Edit `02_abstraction.clp` and `03_diagnostic.clp` to modify medical criteria.

## Support Resources

- CLIPS Documentation: https://www.clipsrules.net/
- CLIPS Manual: https://www.clipsrules.net/Documentation.html
- Diabetes Criteria: https://diabetes.org/

---

**Pure CLIPS Implementation - Ready for Use**
