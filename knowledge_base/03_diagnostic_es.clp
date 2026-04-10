;; ARCHIVO: 03_diagnostic_es.clp
;; DESCRIPCIÓN: Reglas de diagnóstico - Aplica criterios WHO/ADA para 
;;              diagnosticar diabetes y transiciona a reporte.

;; Regla: Diagnosticar Saludable (ambos biomarkers normales)
;;   Criterios: FPG < 100 Y HbA1c < 5.7
(defrule MAIN::diagnose-healthy
   (declare (salience 77))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition normal-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition normal-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Healthy)
                      (justification (str-cat "Paciente tiene control de glucosa normal: FPG=" ?fpg "mg/dL (< 100), HbA1c=" ?hba1c "% (< 5.7)"))))
   (printout t "."))

;; Regla: Diagnosticar Prediabetes (uno o ambos en rango prediabético)
;; Criterios: (FPG 100-125 O HbA1c 5.7-6.4) pero NO ambos diabéticos Y NO uno diabético uno no
(defrule MAIN::diagnose-prediabetes
   (declare (salience 76))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition ?fpg-cond))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition ?hba1c-cond))
   (test (or (eq ?fpg-cond prediabetic-range) (eq ?hba1c-cond prediabetic-range)))
   (test (not (eq ?fpg-cond diabetic-range)))
   (test (not (eq ?hba1c-cond diabetic-range)))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Prediabetes)
                      (justification (str-cat "Paciente tiene niveles de glucosa prediabéticos: FPG=" ?fpg "mg/dL, HbA1c=" ?hba1c "%. Se recomienda modificación del estilo de vida y monitoreo."))))
   (printout t "."))

;; Regla: Diagnosticar Diabetes Tipo 2 (ambos diabéticos, sin indicadores Tipo 1)
;;   Criterios: FPG >= 126 Y HbA1c >= 6.5 Y type-1-indicators=no
(defrule MAIN::diagnose-type-2-diabetes
   (declare (salience 77))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c) (type-1-indicators no))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Type-2-Diabetes)
                      (justification (str-cat "Paciente cumple criterios diagnósticos para Diabetes Tipo 2: FPG=" ?fpg "mg/dL (>= 126), HbA1c=" ?hba1c "% (>= 6.5)"))))
   (printout t "."))

;; Regla: Diagnosticar Diabetes Tipo 1 (ambos diabéticos con indicadores Tipo 1)
;;   Criterios: FPG >= 126 Y HbA1c >= 6.5 Y type-1-indicators=yes
(defrule MAIN::diagnose-type-1-diabetes
   (declare (salience 77))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c) (type-1-indicators yes))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Type-1-Diabetes)
                      (justification (str-cat "Paciente cumple criterios diagnósticos para Diabetes Tipo 1: FPG=" ?fpg "mg/dL (>= 126), HbA1c=" ?hba1c "% (>= 6.5). Indicadores de Tipo 1 presentes (antecedentes familiares, debut temprano, o marcadores autoinmunológicos)."))))
   (printout t "."))

;; Regla: Diagnosticar Inconcluso (biomarcadores discordantes)
;;   Uno diabético y uno no-diabético
(defrule MAIN::diagnose-inconclusive
   (declare (salience 77))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition ?fpg-condition))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition ?hba1c-condition))
   (test (or (and (eq ?fpg-condition diabetic-range) 
                  (or (eq ?hba1c-condition prediabetic-range) (eq ?hba1c-condition normal-range)))
             (and (eq ?hba1c-condition diabetic-range) 
                  (or (eq ?fpg-condition prediabetic-range) (eq ?fpg-condition normal-range)))))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Inconclusive)
                      (justification (str-cat "Inconcluso: Los biomarcadores son discordantes. FPG=" ?fpg "mg/dL, HbA1c=" ?hba1c "%. Se recomienda repetir pruebas y correlación clínica."))))
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
