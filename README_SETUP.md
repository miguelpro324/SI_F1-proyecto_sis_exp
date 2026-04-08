# Diabetes Expert System - Setup Instructions

## Prerequisites

This expert system requires CLIPS (C Language Integrated Production System).

### Option 1: Install CLIPS Development Files (Recommended for Linux)

**Ubuntu/Debian:**
```bash
sudo apt-get install clips libclips-dev
```

**Fedora/RHEL:**
```bash
sudo dnf install clips clips-devel
```

### Option 2: Download CLIPS Source Manually

1. Download CLIPS 6.40 from: https://sourceforge.net/projects/clipsrules/files/CLIPS/6.40/
2. Extract to `external/clips/core/`
3. The directory should contain `clips.h` and all `.c` source files

### Option 3: Use Provided Mini-CLIPS (Included)

A minimal CLIPS implementation is included in `external/clips_minimal/` for testing purposes.

## Building the Expert System

### Using System CLIPS Library:
```bash
make
```

### Using CLIPS Source Files:
```bash
make with-source
```

### Manual Compilation:
```bash
g++ -std=c++17 -Wall -Wextra \
    src/main.cpp \
    src/InferenceEngine.cpp \
    external/clips/core/*.c \
    -I external/clips/core \
    -lm \
    -o diabetes_expert_system
```

## Running the System

```bash
./diabetes_expert_system
```

## Test Cases

**Type 2 Diabetes:**
- Patient ID: 1001
- FPG: 145.0 mg/dL
- HbA1c: 7.2%

**Prediabetes:**
- Patient ID: 1002
- FPG: 110.0 mg/dL
- HbA1c: 6.0%

**Normal:**
- Patient ID: 1003
- FPG: 90.0 mg/dL
- HbA1c: 5.2%
