;; ARCHIVO: 03_diagnostic_es.clp
;; DESCRIPCIÓN: Reglas de diagnóstico - Aplica criterios WHO/ADA para 
;;              diagnosticar Diabetes Tipo 2 y transiciona a reporte.

;; Regla: Diagnosticar Diabetes Tipo 2 (ambos biomarkers en rango diabético)
(defrule MAIN::diagnose-type-2-diabetes
   (declare (salience 75))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Type-2-Diabetes)
                      (justification (str-cat "Paciente cumple criterios diagnósticos para Diabetes Tipo 2: FPG=" ?fpg "mg/dL (>= 126), HbA1c=" ?hba1c "% (>= 6.5)"))))
   (printout t "."))

;; Regla: Diagnosticar No-Diabetes (ambos biomarkers en rango no-diabético)
(defrule MAIN::diagnose-no-diabetes
   (declare (salience 75))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition non-diabetic-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition non-diabetic-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification No-Diabetes)
                      (justification (str-cat "Paciente NO cumple criterios diagnósticos para diabetes: FPG=" ?fpg "mg/dL (< 126), HbA1c=" ?hba1c "% (< 6.5)"))))
   (printout t "."))

;; Regla: Diagnosticar Inconcluso (biomarkers discordantes)
(defrule MAIN::diagnose-inconclusive
   (declare (salience 75))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition ?fpg-condition))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition ?hba1c-condition))
   (test (neq ?fpg-condition ?hba1c-condition))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Inconclusive)
                      (justification (str-cat "Inconcluso: Los biomarkers son discordantes. FPG=" ?fpg "mg/dL, HbA1c=" ?hba1c "%. Se recomienda repetir pruebas y correlación clínica."))))
   (printout t "."))

;; Regla: Transicionar a fase de reporte después del diagnóstico
(defrule MAIN::diagnostic-transition-to-reporting
   (declare (salience -50))
   (system-state (phase diagnostic))
   (patient (id ?pid))
   (diagnosis (patient-id ?pid))
   =>
   (assert (system-state (phase reporting)))
   (printout t crlf ">> Fase de Diagnóstico COMPLETA. Procediendo a Generación de Reporte..." crlf))
