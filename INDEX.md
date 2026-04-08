# 📑 Project Index - Diabetes Expert System

## Quick Navigation

### 🚀 Getting Started
1. **Start Here:** [`QUICKSTART.md`](QUICKSTART.md) - Get running in 5 minutes
2. **Main Documentation:** [`README.md`](README.md) - Comprehensive project guide
3. **Setup Options:** [`README_SETUP.md`](README_SETUP.md) - Installation prerequisites

### 🔨 Building the System
1. **Build Instructions:** [`COMPILATION.md`](COMPILATION.md) - Detailed compilation guide
2. **Build System:** [`Makefile`](Makefile) - Automated build configuration

### 📖 Understanding the Implementation
1. **Project Overview:** [`PROJECT_OVERVIEW.md`](PROJECT_OVERVIEW.md) - Complete system summary
2. **Technical Details:** [`IMPLEMENTATION_SUMMARY.md`](IMPLEMENTATION_SUMMARY.md) - Implementation verification
3. **File Listing:** [`FILES_MANIFEST.md`](FILES_MANIFEST.md) - Complete file catalog
4. **Delivery Summary:** [`DELIVERY_SUMMARY.txt`](DELIVERY_SUMMARY.txt) - Final delivery checklist

### 💻 Source Code

#### CLIPS Knowledge Base (Production Rules)
1. [`knowledge_base/00_templates.clp`](knowledge_base/00_templates.clp) - Fact templates
2. [`knowledge_base/01_validation.clp`](knowledge_base/01_validation.clp) - Input validation rules
3. [`knowledge_base/02_abstraction.clp`](knowledge_base/02_abstraction.clp) - Data interpretation rules
4. [`knowledge_base/03_diagnostic.clp`](knowledge_base/03_diagnostic.clp) - Diagnostic conclusion rules

#### C++ Application
1. [`src/InferenceEngine.hpp`](src/InferenceEngine.hpp) - CLIPS wrapper interface
2. [`src/InferenceEngine.cpp`](src/InferenceEngine.cpp) - CLIPS wrapper implementation
3. [`src/main.cpp`](src/main.cpp) - CLI application

### 🧪 Testing
1. [`test/quick_test.sh`](test/quick_test.sh) - Quick validation test
2. [`test/run_tests.sh`](test/run_tests.sh) - Comprehensive test suite

---

## Document Purpose Guide

### For First-Time Users
→ Read **QUICKSTART.md** to get started quickly

### For Installation Help
→ Read **README_SETUP.md** for prerequisites  
→ Read **COMPILATION.md** for build troubleshooting

### For Understanding the System
→ Read **README.md** for architecture and usage  
→ Read **PROJECT_OVERVIEW.md** for complete system summary

### For Developers
→ Read **IMPLEMENTATION_SUMMARY.md** for technical details  
→ Read **FILES_MANIFEST.md** for file dependencies  
→ Review source files in `src/` and `knowledge_base/`

### For Project Reviewers
→ Read **DELIVERY_SUMMARY.txt** for requirements compliance  
→ Read **IMPLEMENTATION_SUMMARY.md** for verification checklist

---

## 📊 Quick Stats

- **Source Files:** 7 (4 CLIPS + 3 C++)
- **Lines of Code:** 614 lines
- **Production Rules:** 16 defrules
- **Documentation Files:** 8 files
- **Test Cases:** 5 scenarios

---

## 🎯 Common Tasks

### Build the System
```bash
make
```
See: `Makefile`, `COMPILATION.md`

### Run the System
```bash
./diabetes_expert_system
```
See: `QUICKSTART.md`, `README.md`

### Test the System
```bash
./test/quick_test.sh
```
See: `test/run_tests.sh`

### Understand the Knowledge Base
1. Start with `knowledge_base/00_templates.clp`
2. Read `knowledge_base/01_validation.clp`
3. Read `knowledge_base/02_abstraction.clp`
4. Read `knowledge_base/03_diagnostic.clp`

See: `README.md` Section "Knowledge Base Architecture"

### Understand C++ Integration
1. Read `src/InferenceEngine.hpp` (interface)
2. Read `src/InferenceEngine.cpp` (implementation)
3. Read `src/main.cpp` (application)

See: `IMPLEMENTATION_SUMMARY.md` Section "C++ Application"

---

## 📚 Documentation Map

```
INDEX.md (this file)
├── QUICKSTART.md .................. 5-minute getting started
├── README.md ...................... Main documentation
├── PROJECT_OVERVIEW.md ............ Complete system summary
├── IMPLEMENTATION_SUMMARY.md ...... Technical verification
├── COMPILATION.md ................. Build instructions
├── FILES_MANIFEST.md .............. File catalog
├── README_SETUP.md ................ Setup prerequisites
└── DELIVERY_SUMMARY.txt ........... Final delivery checklist
```

---

## 🔗 External Resources

- **CLIPS Official Site:** https://www.clipsrules.net/
- **CLIPS Documentation:** https://www.clipsrules.net/Documentation.html
- **CLIPS Download:** https://sourceforge.net/projects/clipsrules/
- **ADA Diabetes Guidelines:** https://diabetes.org/

---

**Last Updated:** 2026-04-07  
**Project Status:** ✅ Complete and Ready
