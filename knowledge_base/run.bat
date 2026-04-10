@echo off
REM ============================================================================
REM          EXPERT SYSTEM FOR DIABETES DIAGNOSIS - BATCH RUNNER
REM                    CLIPS Forward-Chaining Architecture
REM ============================================================================
REM
REM This batch script orchestrates the loading and execution of the expert
REM system components in the correct order. Each file corresponds to a distinct
REM phase of the forward-chaining engine.
REM
REM Phase Order:
REM   1. Templates (00_templates.clp)   - Data structure definitions
REM   2. Validation (01_validation.clp) - Input validation rules
REM   3. Abstraction (02_abstraction.clp) - Feature extraction rules
REM   4. Diagnostic (03_diagnostic.clp) - Clinical reasoning rules
REM   5. CLI Interface (04_cli.clp)     - User I/O and reporting
REM
REM ============================================================================

echo.
echo Loading Expert System for Diabetes Diagnosis...
echo.

REM Invoke CLIPS with file loading and execution commands
clips -f - << EOF

;; Load all knowledge base files in dependency order
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")

;; Reset the system to initialize the fact base with initial-fact
(reset)

;; Execute the forward-chaining inference engine
(run)

;; Exit CLIPS after inference engine completion
(exit)

EOF

echo.
echo Expert System execution completed.
echo.
pause
