#!/bin/bash
# Quick validation test - runs one test case non-interactively

echo "========================================"
echo "  QUICK VALIDATION TEST"
echo "========================================"
echo ""

if [ ! -f "./diabetes_expert_system" ]; then
    echo "Building the system first..."
    make 2>&1 | tail -5
    echo ""
fi

if [ ! -f "./diabetes_expert_system" ]; then
    echo "ERROR: Build failed. Cannot run test."
    exit 1
fi

echo "Running Type 2 Diabetes test case..."
echo "Input: Patient ID=1001, FPG=145.0 mg/dL, HbA1c=7.2%"
echo ""

echo -e "1001\n145.0\n7.2" | ./diabetes_expert_system

echo ""
echo "Test completed."
