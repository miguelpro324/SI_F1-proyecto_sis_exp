;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ABSTRACTION PHASE RULES                          ;;
;;              Feature Extraction and Biomarker Classification                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Rule: Abstract FPG Biomarker - Normal Range Classification
;;   - FPG < 100 mg/dL indicates normal glucose level
(defrule abstract-fpg-normal
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (< ?fpg 100.0))
   =>
   (assert (clinical-finding
     (patient-id ?pid)
     (biomarker fpg)
     (condition normal-range))))

;; Rule: Abstract FPG Biomarker - Prediabetic Range Classification
;;   - FPG 100-125 mg/dL indicates prediabetic range
(defrule abstract-fpg-prediabetic
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (fpg ?fpg))
   (test (>= ?fpg 100.0))
   (test (< ?fpg 126.0))
   =>
   (assert (clinical-finding
     (patient-id ?pid)
     (biomarker fpg)
     (condition prediabetic-range))))

;; Rule: Abstract FPG Biomarker - Diabetic Range Classification
;;   According to WHO/ADA diagnostic criteria:
;;   - FPG >= 126 mg/dL indicates diabetic-range glucose level
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

;; Rule: Abstract HbA1c Biomarker - Normal Range Classification
;;   - HbA1c < 5.7% indicates normal glucose control
(defrule abstract-hba1c-normal
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (< ?hba1c 5.7))
   =>
   (assert (clinical-finding
     (patient-id ?pid)
     (biomarker hba1c)
     (condition normal-range))))

;; Rule: Abstract HbA1c Biomarker - Prediabetic Range Classification
;;   - HbA1c 5.7-6.4% indicates prediabetic range
(defrule abstract-hba1c-prediabetic
   (declare (salience 75))
   (system-state (phase abstraction))
   (patient (id ?pid) (hba1c ?hba1c))
   (test (>= ?hba1c 5.7))
   (test (< ?hba1c 6.5))
   =>
   (assert (clinical-finding
     (patient-id ?pid)
     (biomarker hba1c)
     (condition prediabetic-range))))

;; Rule: Abstract HbA1c Biomarker - Diabetic Range Classification
;;   According to WHO/ADA diagnostic criteria:
;;   - HbA1c >= 6.5% indicates diabetic-range glycemic control
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

;; Rule: Transition to Diagnostic phase after abstraction
;;   Once all biomarkers have been abstracted and classified, transition to diagnosis
;;   Low salience ensures this rule fires only after all abstraction rules have executed
(defrule abstract-transition-to-diagnostic
   (declare (salience -50))
   (system-state (phase abstraction))
   (clinical-finding (patient-id ?pid) (biomarker fpg))
   (clinical-finding (patient-id ?pid) (biomarker hba1c))
   =>
   (assert (system-state (phase diagnostic)))
   (printout t crlf ">> Abstraction Phase COMPLETE. Proceeding to Diagnostic..." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      END OF ABSTRACTION PHASE RULES                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
