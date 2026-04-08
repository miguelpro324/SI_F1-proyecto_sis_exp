# Quick Start Guide

## 🚀 Getting Started in 5 Minutes

### Step 1: Verify Prerequisites

```bash
# Check C++ compiler
g++ --version

# Check if CLIPS is installed (optional - can use source files)
clips --version
```

### Step 2: Build the System

**Option A - Automatic Build (Recommended):**
```bash
make
```

**Option B - Manual Build:**
```bash
g++ -std=c++17 -Wall -Wextra \
    src/main.cpp \
    src/InferenceEngine.cpp \
    -lclips -lm \
    -o diabetes_expert_system
```

If you don't have CLIPS installed, download it from:
https://sourceforge.net/projects/clipsrules/files/CLIPS/6.40/

Then extract to `external/clips/core/` and run:
```bash
make with-source
```

### Step 3: Run the Expert System

```bash
./diabetes_expert_system
```

**Example Interaction:**
```
Enter Patient ID: 1001
Enter Fasting Plasma Glucose (FPG) in mg/dL: 145.0
Enter Hemoglobin A1c (HbA1c) in %: 7.2
```

**Expected Output:**
```
DIAGNOSIS REPORT
Patient ID: 1001
Classification: type-2-diabetes
Justification: Both FPG >= 126 mg/dL and HbA1c >= 6.5% meet diagnostic criteria for Type 2 Diabetes Mellitus
```

### Step 4: Run Tests

```bash
./test/quick_test.sh
```

## 📋 Sample Test Data

Try these test cases:

**Type 2 Diabetes:**
- Patient ID: `1001`
- FPG: `145.0` mg/dL
- HbA1c: `7.2` %

**Prediabetes:**
- Patient ID: `1002`
- FPG: `110.0` mg/dL
- HbA1c: `6.0` %

**Normal:**
- Patient ID: `1003`
- FPG: `90.0` mg/dL
- HbA1c: `5.2` %

## 🔧 Troubleshooting

**Problem:** `clips.h: No such file or directory`

**Solution 1:** Install CLIPS
```bash
# Ubuntu/Debian
sudo apt-get install clips libclips-dev

# Fedora/RHEL
sudo dnf install clips clips-devel
```

**Solution 2:** Use CLIPS source files
```bash
# Download CLIPS 6.40 and extract to external/clips/core/
make with-source
```

---

**Problem:** `undefined reference to CreateEnvironment`

**Solution:** Link against CLIPS
```bash
# Add -lclips flag or use make with-source
```

---

**Problem:** Build errors

**Solution:** Check compiler version
```bash
g++ --version  # Should be 7.0+ for C++17 support
```

## 📚 Documentation

For more details, see:
- `README.md` - Full project documentation
- `COMPILATION.md` - Detailed build instructions
- `IMPLEMENTATION_SUMMARY.md` - Technical implementation details

## 🎯 What This System Does

The Diabetes Expert System:
1. **Collects** patient biomarker data (FPG and HbA1c)
2. **Validates** input for physiological correctness
3. **Interprets** biomarker values using ADA clinical criteria
4. **Diagnoses** diabetes status (Type 2 Diabetes, Prediabetes, or Normal)
5. **Explains** the diagnostic reasoning

## 🏗️ System Architecture

```
┌─────────────────────────────────────┐
│     User (Command Line)             │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   C++ Application (main.cpp)        │
│   - Input validation                │
│   - User interface                  │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   Inference Engine Wrapper          │
│   (InferenceEngine.cpp)             │
│   - CLIPS C API integration         │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   CLIPS Inference Engine            │
│   - Pattern matching                │
│   - Rule execution                  │
│   - Working memory management       │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│   Knowledge Base (.clp files)       │
│   00_templates.clp                  │
│   01_validation.clp                 │
│   02_abstraction.clp                │
│   03_diagnostic.clp                 │
└─────────────────────────────────────┘
```

## ✅ Verification Checklist

After building, verify:
- [ ] Executable `diabetes_expert_system` exists
- [ ] All 4 `.clp` files are in `knowledge_base/` directory
- [ ] System responds to input
- [ ] Diagnosis is displayed correctly
- [ ] Invalid input is rejected with error messages

## 🎓 Learning Resources

**Understanding the Knowledge Base:**
1. Open `knowledge_base/00_templates.clp` - See data structures
2. Open `knowledge_base/01_validation.clp` - See validation logic
3. Open `knowledge_base/02_abstraction.clp` - See interpretation rules
4. Open `knowledge_base/03_diagnostic.clp` - See diagnostic logic

**Understanding the C++ Integration:**
1. Open `src/InferenceEngine.hpp` - See the API interface
2. Open `src/InferenceEngine.cpp` - See CLIPS C API usage
3. Open `src/main.cpp` - See the application flow

## 🤝 Support

For questions or issues:
1. Check `COMPILATION.md` for build problems
2. Check `README.md` for usage information
3. Check `IMPLEMENTATION_SUMMARY.md` for technical details

---

**Developed for:** Universidad Católica de Santa María (UCSM)  
**Course:** Sistemas Inteligentes - Semestre 7  
**Topic:** Rule-Based Expert Systems
