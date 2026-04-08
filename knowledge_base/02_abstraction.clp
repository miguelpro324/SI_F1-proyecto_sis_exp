;;; ============================================================================
;;; ABSTRACTION MODULE
;;; Transforms raw biomarker values into clinical interpretations
;;; Executes during the abstraction phase
;;; ============================================================================

;;; Rule: Classify FPG in diabetic range
(defrule abstract-fpg-diabetic
  "FPG >= 126 mg/dL indicates diabetic range per ADA criteria"
  (system-state (phase abstraction))
  (patient (id ?pid) (fpg ?fpg&:(>= ?fpg 126.0)))
  =>
  (assert (clinical-finding (patient-id ?pid) 
                            (biomarker fpg) 
                            (condition diabetic-range)))
  (printout t "Clinical Finding: Patient " ?pid " - FPG " ?fpg " mg/dL (Diabetic Range)" crlf))

;;; Rule: Classify FPG in prediabetic range
(defrule abstract-fpg-prediabetic
  "FPG 100-125 mg/dL indicates prediabetic range"
  (system-state (phase abstraction))
  (patient (id ?pid) (fpg ?fpg&:(>= ?fpg 100.0)&:(< ?fpg 126.0)))
  =>
  (assert (clinical-finding (patient-id ?pid) 
                            (biomarker fpg) 
                            (condition prediabetic-range)))
  (printout t "Clinical Finding: Patient " ?pid " - FPG " ?fpg " mg/dL (Prediabetic Range)" crlf))

;;; Rule: Classify FPG in normal range
(defrule abstract-fpg-normal
  "FPG < 100 mg/dL indicates normal range"
  (system-state (phase abstraction))
  (patient (id ?pid) (fpg ?fpg&:(< ?fpg 100.0)))
  =>
  (assert (clinical-finding (patient-id ?pid) 
                            (biomarker fpg) 
                            (condition normal-range)))
  (printout t "Clinical Finding: Patient " ?pid " - FPG " ?fpg " mg/dL (Normal Range)" crlf))

;;; Rule: Classify HbA1c in diabetic range
(defrule abstract-hba1c-diabetic
  "HbA1c >= 6.5% indicates diabetic range per ADA criteria"
  (system-state (phase abstraction))
  (patient (id ?pid) (hba1c ?hba1c&:(>= ?hba1c 6.5)))
  =>
  (assert (clinical-finding (patient-id ?pid) 
                            (biomarker hba1c) 
                            (condition diabetic-range)))
  (printout t "Clinical Finding: Patient " ?pid " - HbA1c " ?hba1c "% (Diabetic Range)" crlf))

;;; Rule: Classify HbA1c in prediabetic range
(defrule abstract-hba1c-prediabetic
  "HbA1c 5.7-6.4% indicates prediabetic range"
  (system-state (phase abstraction))
  (patient (id ?pid) (hba1c ?hba1c&:(>= ?hba1c 5.7)&:(< ?hba1c 6.5)))
  =>
  (assert (clinical-finding (patient-id ?pid) 
                            (biomarker hba1c) 
                            (condition prediabetic-range)))
  (printout t "Clinical Finding: Patient " ?pid " - HbA1c " ?hba1c "% (Prediabetic Range)" crlf))

;;; Rule: Classify HbA1c in normal range
(defrule abstract-hba1c-normal
  "HbA1c < 5.7% indicates normal range"
  (system-state (phase abstraction))
  (patient (id ?pid) (hba1c ?hba1c&:(< ?hba1c 5.7)))
  =>
  (assert (clinical-finding (patient-id ?pid) 
                            (biomarker hba1c) 
                            (condition normal-range)))
  (printout t "Clinical Finding: Patient " ?pid " - HbA1c " ?hba1c "% (Normal Range)" crlf))

;;; Rule: Advance to diagnostic phase after abstraction
(defrule abstraction-complete
  "Transition to diagnostic phase after clinical findings are established"
  ?state <- (system-state (phase abstraction))
  (patient (id ?pid))
  (clinical-finding (patient-id ?pid) (biomarker fpg))
  (clinical-finding (patient-id ?pid) (biomarker hba1c))
  =>
  (retract ?state)
  (assert (system-state (phase diagnostic)))
  (printout t "Abstraction complete, proceeding to diagnosis..." crlf))
