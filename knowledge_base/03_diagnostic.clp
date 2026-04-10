;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           DIAGNOSTIC PHASE RULES                           ;;
;;            Clinical Decision Logic & WHO/ADA Diagnostic Criteria             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Rule: Diagnose Healthy/Normal (both biomarkers normal)
;;   Criteria: FPG < 100 AND HbA1c < 5.7
(defrule diagnose-healthy
   (declare (salience 75))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition normal-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition normal-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Healthy)
                      (justification (str-cat "Patient has normal glucose control: FPG=" ?fpg "mg/dL (< 100), HbA1c=" ?hba1c "% (< 5.7)"))))
   (printout t "."))

;; Rule: Diagnose Prediabetes (one or both in prediabetic range, none in diabetic)
;;   Criteria: (FPG 100-125 OR HbA1c 5.7-6.4) but NOT both diabetic and NOT one diabetic one non-diabetic
(defrule diagnose-prediabetes
   (declare (salience 76))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition ?fpg-cond))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition ?hba1c-cond))
   (test (or (eq ?fpg-cond prediabetic-range) (eq ?hba1c-cond prediabetic-range)))
   (test (not (eq ?fpg-cond diabetic-range)))
   (test (not (eq ?hba1c-cond diabetic-range)))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Prediabetes)
                      (justification (str-cat "Patient has prediabetic glucose levels: FPG=" ?fpg "mg/dL, HbA1c=" ?hba1c "%. Recommend lifestyle modifications and monitoring."))))
   (printout t "."))

;; Rule: Diagnose Type-2-Diabetes (both diabetic range, no Type-1 indicators)
;;   Criteria: FPG >= 126 AND HbA1c >= 6.5 AND type-1-indicators=no
(defrule diagnose-type-2-diabetes
   (declare (salience 77))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c) (type-1-indicators no))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Type-2-Diabetes)
                      (justification (str-cat "Patient meets diagnostic criteria for Type-2 Diabetes: FPG=" ?fpg "mg/dL (>= 126), HbA1c=" ?hba1c "% (>= 6.5)"))))
   (printout t "."))

;; Rule: Diagnose Type-1-Diabetes (both diabetic range with Type-1 indicators)
;;   Criteria: FPG >= 126 AND HbA1c >= 6.5 AND type-1-indicators=yes
(defrule diagnose-type-1-diabetes
   (declare (salience 77))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c) (type-1-indicators yes))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition diabetic-range))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition diabetic-range))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Type-1-Diabetes)
                      (justification (str-cat "Patient meets diagnostic criteria for Type-1 Diabetes: FPG=" ?fpg "mg/dL (>= 126), HbA1c=" ?hba1c "% (>= 6.5). Type-1 indicators present (family history, early onset, or autoimmune markers)."))))
   (printout t "."))

;; Rule: Diagnose Inconclusive (discordant biomarkers)
;;   One diabetic and one non-diabetic
(defrule diagnose-inconclusive
   (declare (salience 74))
   (system-state (phase diagnostic))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (clinical-finding (patient-id ?pid) (biomarker fpg) (condition ?fpg-condition))
   (clinical-finding (patient-id ?pid) (biomarker hba1c) (condition ?hba1c-condition))
   (test (or (and (eq ?fpg-condition diabetic-range) 
                  (or (eq ?hba1c-condition prediabetic-range) (eq ?hba1c-condition normal-range)))
             (and (eq ?hba1c-condition diabetic-range) 
                  (or (eq ?fpg-condition prediabetic-range) (eq ?fpg-condition normal-range)))))
   =>
   (assert (diagnosis (patient-id ?pid) 
                      (classification Inconclusive)
                      (justification (str-cat "Inconclusive: Biomarkers are discordant. FPG=" ?fpg "mg/dL, HbA1c=" ?hba1c "%. Recommend repeat testing and clinical correlation."))))
   (printout t "."))

;; Rule: Transition to Reporting phase after diagnosis
(defrule diagnostic-transition-to-reporting
   (declare (salience -50))
   (system-state (phase diagnostic))
   (patient (id ?pid))
   (diagnosis (patient-id ?pid))
   =>
   (assert (system-state (phase reporting)))
   (printout t crlf ">> Diagnostic Phase COMPLETE. Proceeding to Report Generation..." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      END OF DIAGNOSTIC PHASE RULES                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
