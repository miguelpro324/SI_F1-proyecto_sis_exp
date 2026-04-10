#!/bin/bash
# Comprehensive test suite for all diagnostic categories

cd "$(dirname "$0")"

PASS=0
FAIL=0

run_test() {
    local test_name="$1"
    local patient_id="$2"
    local fpg="$3"
    local hbaic="$4"
    local type1="$5"
    local expected="$6"

    cat > /tmp/test_input.txt << EOFTEST
$patient_id
$fpg
$hbaic
$type1
EOFTEST

    result=$(timeout 20 bash run_interactive.sh < /tmp/test_input.txt 2>&1 | grep "DIAGNOSIS:" | head -1 | sed 's/.*DIAGNOSIS: //')
    
    if [[ "$result" == "$expected" ]]; then
        echo "✓ $test_name ... PASS"
        ((PASS++))
    else
        echo "✗ $test_name ... FAIL (Expected: $expected, Got: $result)"
        ((FAIL++))
    fi
}

echo ""
echo "======================================================"
echo "  DIABETES DIAGNOSIS EXPERT SYSTEM - TEST SUITE"
echo "======================================================"
echo ""

# HEALTHY TESTS
echo "HEALTHY (Normal glucose control):"
run_test "H1: Both normal" "H1" "90" "5.5" "no" "Healthy"
run_test "H2: Both at lower boundaries" "H2" "80" "5.0" "no" "Healthy"
run_test "H3: FPG borderline" "H3" "99" "5.6" "no" "Healthy"

# PREDIABETES TESTS
echo ""
echo "PREDIABETES (Impaired fasting glucose or impaired A1c):"
run_test "P1: FPG prediabetic" "P1" "110" "5.5" "no" "Prediabetes"
run_test "P2: HbA1c prediabetic" "P2" "95" "6.0" "no" "Prediabetes"
run_test "P3: Both prediabetic" "P3" "110" "6.0" "no" "Prediabetes"
run_test "P4: FPG upper boundary" "P4" "125" "5.8" "no" "Prediabetes"

# INCONCLUSIVE TESTS
echo ""
echo "INCONCLUSIVE (Discordant biomarkers):"
run_test "I1: FPG diabetic, HbA1c prediabetic" "I1" "140" "6.2" "no" "Inconclusive"
run_test "I2: FPG diabetic, HbA1c normal" "I2" "150" "5.5" "no" "Inconclusive"
run_test "I3: FPG prediabetic, HbA1c diabetic" "I3" "110" "7.0" "no" "Inconclusive"

# TYPE-2-DIABETES TESTS
echo ""
echo "TYPE-2-DIABETES (Both diabetic range, no Type-1 indicators):"
run_test "T2-1: Both diabetic" "T2-1" "135" "7.2" "no" "Type-2-Diabetes"
run_test "T2-2: FPG high" "T2-2" "180" "6.8" "no" "Type-2-Diabetes"
run_test "T2-3: Both at boundaries" "T2-3" "126" "6.5" "no" "Type-2-Diabetes"

# TYPE-1-DIABETES TESTS
echo ""
echo "TYPE-1-DIABETES (Both diabetic range, with Type-1 indicators):"
run_test "T1-1: Type-1 indicators present" "T1-1" "200" "8.5" "yes" "Type-1-Diabetes"
run_test "T1-2: Early presentation" "T1-2" "250" "9.0" "yes" "Type-1-Diabetes"
run_test "T1-3: At diagnostic boundaries" "T1-3" "126" "6.5" "yes" "Type-1-Diabetes"

echo ""
echo "======================================================"
echo "  TEST RESULTS: $PASS PASSED, $FAIL FAILED"
echo "======================================================"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "✓ All tests passed!"
    exit 0
else
    echo "✗ $FAIL test(s) failed."
    exit 1
fi
