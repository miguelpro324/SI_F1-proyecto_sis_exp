;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ABSTRACTION PHASE RULES                          ;;
;;              Feature Extraction and Biomarker Classification                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Rule: Abstract FPG Biomarker - Diabetic Range Classification
;;   According to WHO/ADA diagnostic criteria:
;;   - FPG >= 126 mg/dL indicates diabetic-range glucose level
;;   This rule extracts and classifies the FPG biomarker
(defrule abstract-fpg-diabetic
  (declare (salience 75))
  (system-state (phase abstraction))
  (patient (id ?pid) (fpg ?fpg))
  (test (>= ?fpg 126.0))
  =>
  (assert (clinical-finding
    (patient-id ?pid)
    (biomarker fpg)
    (condition diabetic-range))))

;; Rule: Abstract FPG Biomarker - Non-Diabetic Classification
;;   According to WHO/ADA diagnostic criteria:
;;   - FPG < 126 mg/dL indicates non-diabetic range (prediabetic or normal)
(defrule abstract-fpg-non-diabetic
  (declare (salience 75))
  (system-state (phase abstraction))
  (patient (id ?pid) (fpg ?fpg))
  (test (< ?fpg 126.0))
  =>
  (assert (clinical-finding
    (patient-id ?pid)
    (biomarker fpg)
    (condition non-diabetic-range))))

;; Rule: Abstract HbA1c Biomarker - Diabetic Range Classification
;;   According to WHO/ADA diagnostic criteria:
;;   - HbA1c >= 6.5% indicates diabetic-range glycemic control
;;   This rule extracts and classifies the HbA1c biomarker
(defrule abstract-hba1c-diabetic
  (declare (salience 75))
  (system-state (phase abstraction))
  (patient (id ?pid) (hba1c ?hba1c))
  (test (>= ?hba1c 6.5))
  =>
  (assert (clinical-finding
    (patient-id ?pid)
    (biomarker hba1c)
    (condition diabetic-range))))

;; Rule: Abstract HbA1c Biomarker - Non-Diabetic Classification
;;   According to WHO/ADA diagnostic criteria:
;;   - HbA1c < 6.5% indicates non-diabetic range (prediabetic or normal)
(defrule abstract-hba1c-non-diabetic
  (declare (salience 75))
  (system-state (phase abstraction))
  (patient (id ?pid) (hba1c ?hba1c))
  (test (< ?hba1c 6.5))
  =>
  (assert (clinical-finding
    (patient-id ?pid)
    (biomarker hba1c)
    (condition non-diabetic-range))))

;; Rule: Transition to Diagnostic phase after abstraction
;;   Once all biomarkers have been abstracted and classified, transition to diagnosis
;;   Low salience ensures this rule fires only after all abstraction rules have executed
(defrule abstract-transition-to-diagnostic
  (declare (salience -50))
  (system-state (phase abstraction))
  (clinical-finding (patient-id ?pid) (biomarker fpg))
  (clinical-finding (patient-id ?pid) (biomarker hba1c))
  =>
  (retract (system-state (phase abstraction)))
  (assert (system-state (phase diagnostic)))
  (printout t crlf ">> Abstraction Phase COMPLETE. Proceeding to Diagnostic..." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      END OF ABSTRACTION PHASE RULES                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
