;; ARCHIVO: 02_abstraction_es.clp
;; DESCRIPCIÓN: Reglas de abstracción - Clasifica biomarkers en rangos clínicos
;;              y transiciona a la fase de diagnóstico.

;; Regla: Clasificar FPG en rango diabético (>= 126 mg/dL)
(defrule MAIN::abstract-fpg-diabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (>= ?fpg 126.0))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range)))
   (printout t "."))

;; Regla: Clasificar FPG en rango no-diabético (< 126 mg/dL)
(defrule MAIN::abstract-fpg-non-diabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (< ?fpg 126.0))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker fpg) (condition non-diabetic-range)))
   (printout t "."))

;; Regla: Clasificar HbA1c en rango diabético (>= 6.5%)
(defrule MAIN::abstract-hba1c-diabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (>= ?hba1c 6.5))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range)))
   (printout t "."))

;; Regla: Clasificar HbA1c en rango no-diabético (< 6.5%)
(defrule MAIN::abstract-hba1c-non-diabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (< ?hba1c 6.5))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition non-diabetic-range)))
   (printout t "."))

;; Regla: Transicionar a fase de diagnóstico después de abstracción
(defrule MAIN::abstract-transition-to-diagnostic
   (declare (salience -50))
   (system-state (phase abstraction))
   (patient (id ?pid))
   (clinical-finding (patient-id ?pid) (biomarker fpg))
   (clinical-finding (patient-id ?pid) (biomarker hba1c))
   =>
   (assert (system-state (phase diagnostic)))
   (printout t crlf ">> Fase de Abstracción COMPLETA. Procediendo a Diagnóstico..." crlf))
