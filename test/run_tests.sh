#!/bin/bash
# Test script for the Diabetes Expert System

echo "========================================"
echo "  DIABETES EXPERT SYSTEM - AUTOMATED TESTS"
echo "========================================"
echo ""

# Check if executable exists
if [ ! -f "./diabetes_expert_system" ]; then
    echo "ERROR: diabetes_expert_system executable not found"
    echo "Please run 'make' first to build the system"
    exit 1
fi

# Test Case 1: Type 2 Diabetes
echo "========== TEST CASE 1: Type 2 Diabetes =========="
echo "Input: Patient ID=1001, FPG=145.0 mg/dL, HbA1c=7.2%"
echo "Expected: Type 2 Diabetes diagnosis"
echo ""
echo -e "1001\n145.0\n7.2" | ./diabetes_expert_system
echo ""
echo "Press Enter to continue..."
read

# Test Case 2: Prediabetes
echo "========== TEST CASE 2: Prediabetes =========="
echo "Input: Patient ID=1002, FPG=110.0 mg/dL, HbA1c=6.0%"
echo "Expected: Prediabetes diagnosis"
echo ""
echo -e "1002\n110.0\n6.0" | ./diabetes_expert_system
echo ""
echo "Press Enter to continue..."
read

# Test Case 3: Normal
echo "========== TEST CASE 3: Normal Glucose Metabolism =========="
echo "Input: Patient ID=1003, FPG=90.0 mg/dL, HbA1c=5.2%"
echo "Expected: Normal diagnosis"
echo ""
echo -e "1003\n90.0\n5.2" | ./diabetes_expert_system
echo ""
echo "Press Enter to continue..."
read

# Test Case 4: Validation Error (Negative FPG)
echo "========== TEST CASE 4: Validation Error =========="
echo "Input: Patient ID=1004, FPG=-50.0 mg/dL, HbA1c=6.0%"
echo "Expected: Error detection and halt"
echo ""
echo -e "1004\n-50.0\n6.0" | ./diabetes_expert_system
echo ""
echo "Press Enter to continue..."
read

# Test Case 5: Edge Case (Exactly at threshold)
echo "========== TEST CASE 5: Threshold Edge Case =========="
echo "Input: Patient ID=1005, FPG=126.0 mg/dL, HbA1c=6.5%"
echo "Expected: Type 2 Diabetes (both at diagnostic threshold)"
echo ""
echo -e "1005\n126.0\n6.5" | ./diabetes_expert_system
echo ""

echo "========================================"
echo "  ALL TESTS COMPLETED"
echo "========================================"
