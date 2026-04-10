;; ARCHIVO: 02_abstraction_es.clp
;; DESCRIPCIÓN: Reglas de abstracción - Clasifica biomarkers en rangos clínicos
;;              y transiciona a la fase de diagnóstico.

;; Regla: Clasificar FPG en rango normal (< 100 mg/dL)
(defrule MAIN::abstract-fpg-normal-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (< ?fpg 100.0))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker fpg) (condition normal-range)))
   (printout t "."))

;; Regla: Clasificar FPG en rango prediabético (100-125 mg/dL)
(defrule MAIN::abstract-fpg-prediabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (>= ?fpg 100.0))
   (test (< ?fpg 126.0))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker fpg) (condition prediabetic-range)))
   (printout t "."))

;; Regla: Clasificar FPG en rango diabético (>= 126 mg/dL)
(defrule MAIN::abstract-fpg-diabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (>= ?fpg 126.0))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range)))
   (printout t "."))

;; Regla: Clasificar HbA1c en rango normal (< 5.7%)
(defrule MAIN::abstract-hba1c-normal-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (< ?hba1c 5.7))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition normal-range)))
   (printout t "."))

;; Regla: Clasificar HbA1c en rango prediabético (5.7-6.4%)
(defrule MAIN::abstract-hba1c-prediabetic-range
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (>= ?hba1c 5.7))
   (test (< ?hba1c 6.5))
   =>
   (assert (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition prediabetic-range)))
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
