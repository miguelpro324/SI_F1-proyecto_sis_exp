#!/bin/bash
# Sistema Experto Interactivo CLIPS - Diagnóstico de Diabetes
# Proporciona una interfaz amigable para el sistema experto

cd "$(dirname "$0")"

echo ""
echo "========================================================"
echo "   SISTEMA EXPERTO PARA DIAGNÓSTICO DE DIABETES"
echo "   Usando Arquitectura de Encadenamiento Progresivo"
echo "========================================================"
echo ""

# Leer entrada del paciente con bucle de validación
while true; do
    read -p "Ingrese ID del Paciente (símbolo, ej: P001): " PATIENT_ID
    if [ -z "$PATIENT_ID" ]; then
        echo "ERROR: El ID del paciente no puede estar vacío. Intente de nuevo."
        continue
    fi
    break
done

while true; do
    read -p "Ingrese Glucosa Plasmática en Ayunas - FPG (mg/dL, ej: 140.5): " FPG
    if [[ "$FPG" =~ ^[0-9]+([.][0-9]+)?$ ]] && (( $(echo "$FPG >= 0 && $FPG <= 800" | bc -l) )); then
        break
    else
        echo "ERROR: FPG debe estar entre 0 y 800 mg/dL. Intente de nuevo."
    fi
done

while true; do
    read -p "Ingrese Hemoglobina A1c - HbA1c (%, ej: 7.2): " HBAIC
    if [[ "$HBAIC" =~ ^[0-9]+([.][0-9]+)?$ ]] && (( $(echo "$HBAIC >= 0 && $HBAIC <= 15" | bc -l) )); then
        break
    else
        echo "ERROR: HbA1c debe estar entre 0 y 15%. Intente de nuevo."
    fi
done

echo ""
echo ">> Procesando datos del paciente..."
echo ""

# Convertir FPG y HbA1c para asegurar que se traten como flotantes en CLIPS
# Si no tienen punto decimal, agregar .0
FPG_FLOAT=$(echo "$FPG" | grep -q '\.' && echo "$FPG" || echo "$FPG.0")
HBAIC_FLOAT=$(echo "$HBAIC" | grep -q '\.' && echo "$HBAIC" || echo "$HBAIC.0")

# Ejecutar CLIPS con los datos del paciente
clips << EOFCLIPS
(load "00_templates.clp")
(load "01_validation_es.clp")
(load "02_abstraction_es.clp")
(load "03_diagnostic_es.clp")
(load "04_cli_es.clp")
(reset)
(assert (patient (id $PATIENT_ID) (fpg $FPG_FLOAT) (hba1c $HBAIC_FLOAT)))
(assert (system-state (phase validation)))
(run)
(exit)
EOFCLIPS

echo ""
echo "========================================================"
echo "Análisis completado."
echo "========================================================"
echo ""
