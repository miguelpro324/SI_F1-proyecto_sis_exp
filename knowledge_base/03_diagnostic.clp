;;; ============================================================================
;;; DIAGNOSTIC MODULE
;;; Generates final diagnostic conclusions based on clinical findings
;;; Executes during the diagnostic phase
;;; ============================================================================

;;; Rule: Diagnose Type 2 Diabetes (both markers in diabetic range)
(defrule diagnose-type2-diabetes
  "Type 2 Diabetes diagnosis requires BOTH FPG and HbA1c in diabetic range"
  (system-state (phase diagnostic))
  (patient (id ?pid))
  (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
  (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
  =>
  (assert (diagnosis (patient-id ?pid) 
                     (classification type-2-diabetes)
                     (justification "Both FPG >= 126 mg/dL and HbA1c >= 6.5% meet diagnostic criteria for Type 2 Diabetes Mellitus")))
  (printout t "DIAGNOSIS: Patient " ?pid " - Type 2 Diabetes Mellitus" crlf))

;;; Rule: Diagnose Prediabetes (mixed markers or prediabetic range)
(defrule diagnose-prediabetes
  "Prediabetes diagnosis when at least one marker is elevated but not both diabetic"
  (system-state (phase diagnostic))
  (patient (id ?pid))
  (or (clinical-finding (patient-id ?pid) (condition prediabetic-range))
      (and (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
           (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition ~diabetic-range)))
      (and (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
           (clinical-finding (patient-id ?pid) (biomarker fpg) (condition ~diabetic-range))))
  (not (diagnosis (patient-id ?pid)))
  =>
  (assert (diagnosis (patient-id ?pid) 
                     (classification prediabetes)
                     (justification "Elevated biomarkers indicate impaired glucose metabolism (Prediabetes) - recommend lifestyle modifications")))
  (printout t "DIAGNOSIS: Patient " ?pid " - Prediabetes (Impaired Glucose Metabolism)" crlf))

;;; Rule: Diagnose Normal
(defrule diagnose-normal
  "Normal diagnosis when both markers are in normal range"
  (system-state (phase diagnostic))
  (patient (id ?pid))
  (clinical-finding (patient-id ?pid) (biomarker fpg) (condition normal-range))
  (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition normal-range))
  =>
  (assert (diagnosis (patient-id ?pid) 
                     (classification normal)
                     (justification "Both FPG < 100 mg/dL and HbA1c < 5.7% indicate normal glucose metabolism")))
  (printout t "DIAGNOSIS: Patient " ?pid " - Normal Glucose Metabolism" crlf))

;;; Rule: Mark diagnostic phase complete
(defrule diagnostic-complete
  "Transition to complete state after diagnosis is established"
  ?state <- (system-state (phase diagnostic))
  (diagnosis (patient-id ?pid))
  =>
  (retract ?state)
  (assert (system-state (phase complete)))
  (printout t "Diagnostic reasoning complete for Patient " ?pid crlf))
