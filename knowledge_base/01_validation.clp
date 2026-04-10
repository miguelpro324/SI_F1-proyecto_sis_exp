;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           VALIDATION PHASE RULES                           ;;
;;                   Data Integrity and Constraint Checking                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Rule: Detect invalid Fasting Plasma Glucose value
;;   If FPG is negative (clinically impossible), mark data as invalid and block progression
(defrule validate-negative-fpg
  (declare (salience 100))
  (system-state (phase validation))
  (patient (id ?pid) (fpg ?fpg))
  (test (< ?fpg 0.0))
  =>
  (printout t crlf "ERROR: Negative FPG value detected (" ?fpg " mg/dL)." crlf)
  (assert (invalid-data (patient-id ?pid) (error "Negative FPG"))))

;; Rule: Detect invalid Hemoglobin A1c value
;;   If HbA1c is negative (clinically impossible), mark data as invalid and block progression
(defrule validate-negative-hba1c
  (declare (salience 100))
  (system-state (phase validation))
  (patient (id ?pid) (hba1c ?hba1c))
  (test (< ?hba1c 0.0))
  =>
  (printout t crlf "ERROR: Negative HbA1c value detected (" ?hba1c "%)." crlf)
  (assert (invalid-data (patient-id ?pid) (error "Negative HbA1c"))))

;; Rule: Detect unrealistic HbA1c upper bound
;;   HbA1c readings above 15% are extremely rare and likely erroneous
(defrule validate-excessive-hba1c
  (declare (salience 100))
  (system-state (phase validation))
  (patient (id ?pid) (hba1c ?hba1c))
  (test (> ?hba1c 15.0))
  =>
  (printout t crlf "ERROR: Unrealistic HbA1c value detected (" ?hba1c "%)." crlf)
  (assert (invalid-data (patient-id ?pid) (error "Excessive HbA1c"))))

;; Rule: Detect unrealistic FPG upper bound
;;   FPG readings above 800 mg/dL are typically incompatible with life
(defrule validate-excessive-fpg
  (declare (salience 100))
  (system-state (phase validation))
  (patient (id ?pid) (fpg ?fpg))
  (test (> ?fpg 800.0))
  =>
  (printout t crlf "ERROR: Unrealistic FPG value detected (" ?fpg " mg/dL)." crlf)
  (assert (invalid-data (patient-id ?pid) (error "Excessive FPG"))))

;; Rule: Transition to Abstraction phase on successful validation
;;   If no invalid-data facts exist after validation, proceed to abstraction
(defrule validate-success-transition
  (declare (salience -50))
  (system-state (phase validation))
  (patient (id ?pid))
  (not (invalid-data))
  =>
  (assert (system-state (phase abstraction)))
  (printout t crlf ">> Validation Phase PASSED. Proceeding to Abstraction..." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      END OF VALIDATION PHASE RULES                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
