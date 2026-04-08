;;; ============================================================================
;;; VALIDATION MODULE
;;; Input validation rules that execute during the validation phase
;;; Catches invalid biomarker values and halts the system with error state
;;; ============================================================================

;;; Rule: Detect negative Fasting Plasma Glucose
(defrule validate-fpg-negative
  "Halt system if FPG is negative"
  (system-state (phase validation))
  (patient (id ?pid) (fpg ?fpg&:(< ?fpg 0.0)))
  =>
  (printout t "ERROR: Patient " ?pid " has invalid FPG value: " ?fpg " mg/dL" crlf)
  (assert (system-state (phase error)))
  (retract (system-state (phase validation))))

;;; Rule: Detect negative HbA1c
(defrule validate-hba1c-negative
  "Halt system if HbA1c is negative"
  (system-state (phase validation))
  (patient (id ?pid) (hba1c ?hba1c&:(< ?hba1c 0.0)))
  =>
  (printout t "ERROR: Patient " ?pid " has invalid HbA1c value: " ?hba1c "%" crlf)
  (assert (system-state (phase error)))
  (retract (system-state (phase validation))))

;;; Rule: Detect unrealistic FPG values (> 600 mg/dL is life-threatening)
(defrule validate-fpg-extreme
  "Halt system if FPG exceeds physiological limits"
  (system-state (phase validation))
  (patient (id ?pid) (fpg ?fpg&:(> ?fpg 600.0)))
  =>
  (printout t "ERROR: Patient " ?pid " has extreme FPG value: " ?fpg " mg/dL (>600)" crlf)
  (assert (system-state (phase error)))
  (retract (system-state (phase validation))))

;;; Rule: Detect unrealistic HbA1c values (> 15.0% is extreme)
(defrule validate-hba1c-extreme
  "Halt system if HbA1c exceeds physiological limits"
  (system-state (phase validation))
  (patient (id ?pid) (hba1c ?hba1c&:(> ?hba1c 15.0)))
  =>
  (printout t "ERROR: Patient " ?pid " has extreme HbA1c value: " ?hba1c "% (>15.0)" crlf)
  (assert (system-state (phase error)))
  (retract (system-state (phase validation))))

;;; Rule: Advance to abstraction phase if validation passes
(defrule validation-passed
  "Transition to abstraction phase after successful validation"
  ?state <- (system-state (phase validation))
  (patient (id ?pid))
  (not (system-state (phase error)))
  =>
  (retract ?state)
  (assert (system-state (phase abstraction)))
  (printout t "Validation passed for Patient " ?pid crlf))
