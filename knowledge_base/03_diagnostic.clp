;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          DIAGNOSTIC PHASE RULES                            ;;
;;                     Clinical Decision and Diagnosis Formation               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Rule: Diagnose Type-2 Diabetes
;;   Type-2 Diabetes is diagnosed when BOTH FPG and HbA1c are in diabetic range
;;   - FPG >= 126 mg/dL (fasting glucose indicator)
;;   - HbA1c >= 6.5% (3-month average glucose control indicator)
;;   A diagnosis requires confirmation by at least one repeated test in clinical practice,
;;   but this system demonstrates diagnosis on combined criteria.
(defrule diagnose-type2-diabetes
  (declare (salience 75))
  (system-state (phase diagnostic))
  (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
  (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
  (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
  =>
  (bind ?justification
    (str-cat
      "Patient meets diagnostic criteria for Type-2 Diabetes: "
      "FPG=" ?fpg "mg/dL (>= 126), "
      "HbA1c=" ?hba1c "% (>= 6.5%)"))
  (assert (diagnosis
    (patient-id ?pid)
    (classification Type-2-Diabetes)
    (justification ?justification))))

;; Rule: No Diabetes Diagnosis - Non-Diabetic FPG and HbA1c
;;   If both biomarkers are below diagnostic thresholds, diabetes is not indicated
(defrule diagnose-no-diabetes
  (declare (salience 75))
  (system-state (phase diagnostic))
  (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
  (clinical-finding (patient-id ?pid) (biomarker fpg) (condition non-diabetic-range))
  (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition non-diabetic-range))
  =>
  (bind ?justification
    (str-cat
      "Patient does NOT meet diagnostic criteria for diabetes: "
      "FPG=" ?fpg "mg/dL (< 126), "
      "HbA1c=" ?hba1c "% (< 6.5%)"))
  (assert (diagnosis
    (patient-id ?pid)
    (classification No-Diabetes)
    (justification ?justification))))

;; Rule: Inconclusive Diagnosis - Mixed Biomarker Results
;;   If biomarkers yield discordant results (one diabetic, one non-diabetic),
;;   diagnosis is inconclusive and requires further clinical evaluation
(defrule diagnose-inconclusive
  (declare (salience 75))
  (system-state (phase diagnostic))
  (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
  (or
    (and
      (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
      (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition non-diabetic-range)))
    (and
      (clinical-finding (patient-id ?pid) (biomarker fpg) (condition non-diabetic-range))
      (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))))
  =>
  (bind ?justification
    (str-cat
      "Inconclusive: Biomarkers are discordant. "
      "FPG=" ?fpg "mg/dL, HbA1c=" ?hba1c "%. "
      "Recommend repeat testing and clinical correlation."))
  (assert (diagnosis
    (patient-id ?pid)
    (classification Inconclusive)
    (justification ?justification))))

;; Rule: Transition to Reporting phase after diagnosis
;;   Once diagnosis has been formulated, transition to the reporting phase
;;   for presentation of results to the user
(defrule diagnostic-transition-to-reporting
  (declare (salience -50))
  (system-state (phase diagnostic))
  (diagnosis (patient-id ?pid))
  =>
  (retract (system-state (phase diagnostic)))
  (assert (system-state (phase reporting)))
  (printout t crlf ">> Diagnostic Phase COMPLETE. Proceeding to Report Generation..." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       END OF DIAGNOSTIC PHASE RULES                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
