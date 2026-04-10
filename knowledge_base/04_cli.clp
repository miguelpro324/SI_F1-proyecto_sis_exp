;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         USER INTERFACE LAYER (CLI)                         ;;
;;                  Input Prompts, Report Generation, Output                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; System Header Initialization
(defrule cli-initialize-system-header
   (declare (salience 100))
   (initial-fact)
   =>
   (flush)
   (printout t crlf crlf
             "=====================================================" crlf
             "           MEDICAL DIAGNOSTIC REPORT" crlf
             "=====================================================" crlf crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  OUTPUT RULE: Successful Diagnosis with Professional Report
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule cli-output-successful-diagnosis
   (declare (salience 90))
   (system-state (phase reporting))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (diagnosis (patient-id ?pid) (classification ?class) (justification ?just))
   =>
   (printout t "PATIENT IDENTIFIER: " ?pid crlf)
   (printout t "-----------------------------------------------------" crlf)
   (printout t "LAB MEASUREMENTS:" crlf)
   (printout t "  Fasting Plasma Glucose (FPG):   " ?fpg " mg/dL" crlf)
   (printout t "  Hemoglobin A1c (HbA1c):         " ?hba1c " %" crlf crlf)
   
   (printout t "DIAGNOSIS: " ?class crlf)
   (printout t "-----------------------------------------------------" crlf)
   (printout t "JUSTIFICATION:" crlf)
   (printout t "  " ?just crlf crlf)
   
   ;; Personalized clinical recommendations
   (if (eq ?class Healthy)
       then
       (printout t "CLINICAL RECOMMENDATION:" crlf)
       (printout t "  - Maintain current healthy lifestyle and diet" crlf)
       (printout t "  - Continue regular physical activity" crlf)
       (printout t "  - Routine follow-up testing in 3 years" crlf)
       else
       (if (eq ?class Prediabetes)
           then
           (printout t "CLINICAL RECOMMENDATION:" crlf)
           (printout t "  - Begin or intensify lifestyle modifications" crlf)
           (printout t "  - Aim for 150 minutes of moderate aerobic activity weekly" crlf)
           (printout t "  - Reduce weight by 5-10% if overweight" crlf)
           (printout t "  - Follow-up testing in 6-12 months" crlf)
           else
           (if (eq ?class Type-2-Diabetes)
               then
               (printout t "CLINICAL RECOMMENDATION:" crlf)
               (printout t "  - Schedule comprehensive endocrine evaluation" crlf)
               (printout t "  - Initiate lifestyle modification program" crlf)
               (printout t "  - Consider pharmacological management" crlf)
               (printout t "  - Arrange follow-up testing in 3 months" crlf)
               else
               (if (eq ?class Type-1-Diabetes)
                   then
                   (printout t "CLINICAL RECOMMENDATION:" crlf)
                   (printout t "  - URGENT: Refer to endocrinologist" crlf)
                   (printout t "  - Initiate insulin therapy immediately" crlf)
                   (printout t "  - Comprehensive metabolic panel and autoimmune testing" crlf)
                   (printout t "  - Diabetes education and self-management training" crlf)
                   (printout t "  - Frequent follow-up (initially every 1-2 weeks)" crlf)
                   else
                   (if (eq ?class Inconclusive)
                       then
                       (printout t "CLINICAL RECOMMENDATION:" crlf)
                       (printout t "  - Repeat diagnostic testing within 1-2 weeks" crlf)
                       (printout t "  - Consider oral glucose tolerance test (OGTT)" crlf)
                       (printout t "  - Discuss risk factors with healthcare provider" crlf)
                       (printout t "  - Monitor for symptom development" crlf)
                       )))))
   
   (printout t crlf)
   (printout t "=====================================================" crlf)
   (printout t "           END OF DIAGNOSTIC REPORT" crlf)
   (printout t "=====================================================" crlf crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  OUTPUT RULE: Validation Error  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule cli-output-validation-error
   (declare (salience 90))
   (system-state (phase validation))
   (invalid-data (patient-id ?pid) (error ?error-msg))
   =>
   (printout t crlf crlf
             "=====================================================" crlf
             "             DATA VALIDATION ERROR" crlf
             "=====================================================" crlf crlf)
   (printout t "PATIENT IDENTIFIER: " ?pid crlf)
   (printout t "-----------------------------------------------------" crlf)
   (printout t "ERROR DETECTED: " ?error-msg crlf crlf)
   (printout t "Please verify patient data and try again." crlf)
   (printout t "Valid ranges:" crlf)
   (printout t "  - FPG (Fasting Glucose): 0 - 800 mg/dL" crlf)
   (printout t "  - HbA1c: 0 - 15 %" crlf crlf)
   (printout t "=====================================================" crlf
             "              END OF ERROR REPORT" crlf
             "=====================================================" crlf crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         END OF CLI LAYER                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
