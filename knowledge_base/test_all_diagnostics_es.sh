#!/bin/bash
# Conjunto de pruebas integral para diagnósticos en español

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

    cat > /tmp/test_input_es.txt << EOFTEST
$patient_id
$fpg
$hbaic
$type1
EOFTEST

    result=$(timeout 20 bash run_interactive_es.sh < /tmp/test_input_es.txt 2>&1 | grep "DIAGNÓSTICO:" | head -1 | sed 's/.*DIAGNÓSTICO: //')
    
    if [[ "$result" == "$expected" ]]; then
        echo "✓ $test_name ... PASS"
        ((PASS++))
    else
        echo "✗ $test_name ... FAIL (Esperado: $expected, Obtenido: $result)"
        ((FAIL++))
    fi
}

echo ""
echo "======================================================"
echo "  SISTEMA EXPERTO - SUITE DE PRUEBAS (ESPAÑOL)"
echo "======================================================"
echo ""

# PRUEBAS SALUDABLE
echo "SALUDABLE (Control de glucosa normal):"
run_test "S1: Ambos normales" "S1" "90" "5.5" "no" "Healthy"
run_test "S2: Frontera inferior" "S2" "99" "5.6" "no" "Healthy"

# PRUEBAS PREDIABETES
echo ""
echo "PREDIABETES (Glucosa o A1c elevada pero no diabética):"
run_test "PR1: FPG prediabético" "PR1" "110" "5.5" "no" "Prediabetes"
run_test "PR2: HbA1c prediabético" "PR2" "95" "6.0" "no" "Prediabetes"

# PRUEBAS INCONCLUSO
echo ""
echo "INCONCLUSO (Biomarkers discordantes):"
run_test "I1: FPG diabético, HbA1c prediabético" "I1" "140" "6.2" "no" "Inconclusive"

# PRUEBAS DIABETES TIPO 2
echo ""
echo "DIABETES TIPO 2 (Ambos diabéticos, sin indicadores T1):"
run_test "DT2-1: Ambos diabéticos" "DT2-1" "135" "7.2" "no" "Type-2-Diabetes"

# PRUEBAS DIABETES TIPO 1
echo ""
echo "DIABETES TIPO 1 (Ambos diabéticos, con indicadores T1):"
run_test "DT1-1: Indicadores T1 presentes" "DT1-1" "200" "8.5" "yes" "Type-1-Diabetes"

echo ""
echo "======================================================"
echo "  RESULTADOS: $PASS PASADAS, $FAIL FALLIDAS"
echo "======================================================"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "✓ ¡Todas las pruebas pasaron!"
    exit 0
else
    echo "✗ $FAIL prueba(s) fallida(s)."
    exit 1
fi
