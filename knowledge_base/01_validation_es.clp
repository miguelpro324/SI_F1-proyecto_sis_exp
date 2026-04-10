;; ARCHIVO: 01_validation_es.clp
;; DESCRIPCIÓN: Reglas de validación - Detecta valores clínicamente imposibles
;;              y previene la transición a la siguiente fase si hay datos inválidos.

;; Regla: Detectar valores negativos de FPG
(defrule MAIN::validate-negative-fpg
   (declare (salience 100))
   (system-state (phase validation))
   (patient (id ?pid) (fpg ?fpg))
   (test (< ?fpg 0.0))
   =>
   (printout t crlf "ERROR: Valor de FPG negativo detectado (" ?fpg " mg/dL)." crlf)
   (assert (invalid-data (patient-id ?pid) (error "FPG negativo"))))

;; Regla: Detectar valores negativos de HbA1c
(defrule MAIN::validate-negative-hba1c
   (declare (salience 100))
   (system-state (phase validation))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (< ?hba1c 0.0))
   =>
   (printout t crlf "ERROR: Valor de HbA1c negativo detectado (" ?hba1c "%)." crlf)
   (assert (invalid-data (patient-id ?pid) (error "HbA1c negativo"))))

;; Regla: Detectar valores excesivamente altos de HbA1c
(defrule MAIN::validate-excessive-hba1c
   (declare (salience 100))
   (system-state (phase validation))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (> ?hba1c 15.0))
   =>
   (printout t crlf "ERROR: Valor de HbA1c no realista detectado (" ?hba1c "%)." crlf)
   (assert (invalid-data (patient-id ?pid) (error "HbA1c excesivamente alto"))))

;; Regla: Detectar valores excesivamente altos de FPG
(defrule MAIN::validate-excessive-fpg
   (declare (salience 100))
   (system-state (phase validation))
   (patient (id ?pid) (fpg ?fpg))
   (test (> ?fpg 800.0))
   =>
   (printout t crlf "ERROR: Valor de FPG no realista detectado (" ?fpg " mg/dL)." crlf)
   (assert (invalid-data (patient-id ?pid) (error "FPG excesivamente alto"))))

;; Regla: Transición exitosa a fase de abstracción si no hay datos inválidos
(defrule MAIN::validate-success-transition
   (declare (salience -50))
   (system-state (phase validation))
   (patient (id ?pid))
   (not (invalid-data))
   =>
   (assert (system-state (phase abstraction)))
   (printout t crlf ">> Fase de Validación APROBADA. Procediendo a Abstracción..." crlf))
