# Compilation Guide

## Prerequisites Check

Before compiling, verify you have:

```bash
g++ --version    # Should show g++ 7.0 or later (C++17 support)
clips --version  # Should show CLIPS 6.30 or later (if using system install)
```

## Compilation Options

### Option 1: Using System CLIPS Library (Recommended)

If you have CLIPS installed via package manager:

```bash
g++ -std=c++17 -Wall -Wextra -O2 \
    src/main.cpp \
    src/InferenceEngine.cpp \
    -lclips \
    -lm \
    -o diabetes_expert_system
```

**Explanation:**
- `-std=c++17` - Use C++17 standard
- `-Wall -Wextra` - Enable all warnings
- `-O2` - Optimization level 2
- `-lclips` - Link against CLIPS library
- `-lm` - Link against math library
- `-o diabetes_expert_system` - Output executable name

### Option 2: Using CLIPS Source Files

If you have downloaded CLIPS source to `external/clips/core/`:

```bash
g++ -std=c++17 -Wall -Wextra -O2 \
    src/main.cpp \
    src/InferenceEngine.cpp \
    external/clips/core/agenda.c \
    external/clips/core/analysis.c \
    external/clips/core/argacces.c \
    external/clips/core/bload.c \
    external/clips/core/bsave.c \
    external/clips/core/classcom.c \
    external/clips/core/classexm.c \
    external/clips/core/classfun.c \
    external/clips/core/classinf.c \
    external/clips/core/classini.c \
    external/clips/core/classpsr.c \
    external/clips/core/clsltpsr.c \
    external/clips/core/commline.c \
    external/clips/core/conscomp.c \
    external/clips/core/constrct.c \
    external/clips/core/constrnt.c \
    external/clips/core/crstrtgy.c \
    external/clips/core/cstrcbin.c \
    external/clips/core/cstrccom.c \
    external/clips/core/cstrcpsr.c \
    external/clips/core/cstrnbin.c \
    external/clips/core/cstrnchk.c \
    external/clips/core/cstrncmp.c \
    external/clips/core/cstrnops.c \
    external/clips/core/cstrnpsr.c \
    external/clips/core/cstrnutl.c \
    external/clips/core/default.c \
    external/clips/core/defins.c \
    external/clips/core/developr.c \
    external/clips/core/dffctbin.c \
    external/clips/core/dffctbsc.c \
    external/clips/core/dffctcmp.c \
    external/clips/core/dffctdef.c \
    external/clips/core/dffcthsh.c \
    external/clips/core/dffctpsr.c \
    external/clips/core/dffnxbin.c \
    external/clips/core/dffnxcmp.c \
    external/clips/core/dffnxexe.c \
    external/clips/core/dffnxfun.c \
    external/clips/core/dffnxpsr.c \
    external/clips/core/dfinsbin.c \
    external/clips/core/dfinscmp.c \
    external/clips/core/drive.c \
    external/clips/core/emathfun.c \
    external/clips/core/engine.c \
    external/clips/core/envrnmnt.c \
    external/clips/core/evaluatn.c \
    external/clips/core/expressn.c \
    external/clips/core/exprnbin.c \
    external/clips/core/exprnops.c \
    external/clips/core/exprnpsr.c \
    external/clips/core/extnfunc.c \
    external/clips/core/factbin.c \
    external/clips/core/factbld.c \
    external/clips/core/factcmp.c \
    external/clips/core/factcom.c \
    external/clips/core/factfun.c \
    external/clips/core/facthsh.c \
    external/clips/core/factlhs.c \
    external/clips/core/factmch.c \
    external/clips/core/factmngr.c \
    external/clips/core/factprt.c \
    external/clips/core/factqpsr.c \
    external/clips/core/factqury.c \
    external/clips/core/factrete.c \
    external/clips/core/factrhs.c \
    external/clips/core/filecom.c \
    external/clips/core/filertr.c \
    external/clips/core/fileutil.c \
    external/clips/core/generate.c \
    external/clips/core/genrcbin.c \
    external/clips/core/genrccmp.c \
    external/clips/core/genrccom.c \
    external/clips/core/genrcexe.c \
    external/clips/core/genrcfun.c \
    external/clips/core/genrcpsr.c \
    external/clips/core/globlbin.c \
    external/clips/core/globlbsc.c \
    external/clips/core/globlcmp.c \
    external/clips/core/globlcom.c \
    external/clips/core/globldef.c \
    external/clips/core/globlpsr.c \
    external/clips/core/immthpsr.c \
    external/clips/core/incrrset.c \
    external/clips/core/inherpsr.c \
    external/clips/core/inscom.c \
    external/clips/core/insfile.c \
    external/clips/core/insfun.c \
    external/clips/core/insmngr.c \
    external/clips/core/inspsr.c \
    external/clips/core/insquery.c \
    external/clips/core/insmoddp.c \
    external/clips/core/iofun.c \
    external/clips/core/lgcldpnd.c \
    external/clips/core/memalloc.c \
    external/clips/core/miscfun.c \
    external/clips/core/modulbin.c \
    external/clips/core/modulbsc.c \
    external/clips/core/modulcmp.c \
    external/clips/core/moduldef.c \
    external/clips/core/modulpsr.c \
    external/clips/core/modulutl.c \
    external/clips/core/msgcom.c \
    external/clips/core/msgfun.c \
    external/clips/core/msgpass.c \
    external/clips/core/msgpsr.c \
    external/clips/core/multifld.c \
    external/clips/core/multifun.c \
    external/clips/core/objbin.c \
    external/clips/core/objcmp.c \
    external/clips/core/objrtbin.c \
    external/clips/core/objrtbld.c \
    external/clips/core/objrtcmp.c \
    external/clips/core/objrtfnx.c \
    external/clips/core/objrtgen.c \
    external/clips/core/objrtmch.c \
    external/clips/core/parsefun.c \
    external/clips/core/pattern.c \
    external/clips/core/pprint.c \
    external/clips/core/prccode.c \
    external/clips/core/prcdrfun.c \
    external/clips/core/prcdrpsr.c \
    external/clips/core/prdctfun.c \
    external/clips/core/prntutil.c \
    external/clips/core/proflfun.c \
    external/clips/core/reorder.c \
    external/clips/core/reteutil.c \
    external/clips/core/retract.c \
    external/clips/core/router.c \
    external/clips/core/rulebin.c \
    external/clips/core/rulebld.c \
    external/clips/core/rulebsc.c \
    external/clips/core/rulecmp.c \
    external/clips/core/rulecom.c \
    external/clips/core/rulecstr.c \
    external/clips/core/ruledef.c \
    external/clips/core/ruledlt.c \
    external/clips/core/rulelhs.c \
    external/clips/core/rulepsr.c \
    external/clips/core/scanner.c \
    external/clips/core/sortfun.c \
    external/clips/core/strngfun.c \
    external/clips/core/strngrtr.c \
    external/clips/core/symblbin.c \
    external/clips/core/symblcmp.c \
    external/clips/core/symbol.c \
    external/clips/core/sysdep.c \
    external/clips/core/textpro.c \
    external/clips/core/tmpltbin.c \
    external/clips/core/tmpltbsc.c \
    external/clips/core/tmpltcmp.c \
    external/clips/core/tmpltdef.c \
    external/clips/core/tmpltfun.c \
    external/clips/core/tmpltlhs.c \
    external/clips/core/tmpltpsr.c \
    external/clips/core/tmpltrhs.c \
    external/clips/core/tmpltutl.c \
    external/clips/core/utility.c \
    external/clips/core/watch.c \
    -Iexternal/clips/core \
    -lm \
    -o diabetes_expert_system
```

**Simplified (using wildcard):**

```bash
g++ -std=c++17 -Wall -Wextra -O2 \
    src/main.cpp \
    src/InferenceEngine.cpp \
    external/clips/core/*.c \
    -Iexternal/clips/core \
    -lm \
    -o diabetes_expert_system
```

### Option 3: Using Makefile (Easiest)

```bash
# Automatic detection
make

# Force using CLIPS source files
make with-source

# Clean and rebuild
make clean && make
```

## Verifying the Build

After compilation, verify the executable:

```bash
ls -lh diabetes_expert_system
file diabetes_expert_system
./diabetes_expert_system --help  # Should show usage
```

## Troubleshooting

### Error: "clips.h: No such file or directory"

**Solution 1:** Install CLIPS development files
```bash
sudo apt-get install libclips-dev  # Ubuntu/Debian
sudo dnf install clips-devel        # Fedora/RHEL
```

**Solution 2:** Use CLIPS source files
1. Download CLIPS from SourceForge
2. Extract to `external/clips/core/`
3. Use compilation Option 2 above

### Error: "undefined reference to CreateEnvironment"

**Solution:** Link against CLIPS library or source files
```bash
# Add -lclips flag or include CLIPS .c files
```

### Error: "undefined reference to sqrt" or similar math functions

**Solution:** Link against math library
```bash
# Add -lm flag to your compilation command
```

## Cross-Platform Notes

### Linux
- Standard compilation as shown above
- May need `sudo apt-get install build-essential`

### macOS
- Use Xcode command line tools: `xcode-select --install`
- Install CLIPS via Homebrew: `brew install clips`

### Windows (WSL/MinGW)
- Use WSL (Windows Subsystem for Linux) - recommended
- Or use MinGW-w64 with similar commands

## Optimization Levels

- `-O0` - No optimization (fastest compilation, easiest debugging)
- `-O2` - Standard optimization (recommended for production)
- `-O3` - Aggressive optimization (may increase compile time)
- `-Os` - Optimize for size

## Debug Build

For debugging with gdb:

```bash
g++ -std=c++17 -Wall -Wextra -g -O0 \
    src/main.cpp \
    src/InferenceEngine.cpp \
    -lclips -lm \
    -o diabetes_expert_system_debug

gdb ./diabetes_expert_system_debug
```
