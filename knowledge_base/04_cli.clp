;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     COMMAND-LINE INTERFACE (CLI) RULES                     ;;
;;              User Input/Output and System Initialization                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Rule: Initialize System and Display Header
;;   Triggered by the initial-fact (automatically asserted by CLIPS on startup)
;;   Displays the application header. Patient data is provided via facts
;;   asserted by the run.sh wrapper script.
(defrule cli-initialize-system-header
  (declare (salience 100))
  (initial-fact)
  =>
  ;; Display application header and instructions
  (printout t crlf)
  (printout t "=====================================================" crlf)
  (printout t "   EXPERT SYSTEM FOR DIABETES DIAGNOSIS" crlf)
  (printout t "   Using Forward-Chaining Architecture in CLIPS" crlf)
  (printout t "=====================================================" crlf)
  (printout t crlf)
  (flush))

;; Rule: Output Report for Successful Diagnosis
;;   Triggered when the system reaches the reporting phase with a diagnosis result
;;   Displays a professional, formatted medical diagnostic report
(defrule cli-output-successful-diagnosis
  (declare (salience 90))
  (system-state (phase reporting))
  (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
  (diagnosis (patient-id ?pid) (classification ?class) (justification ?just))
  =>
  ;; Display formatted report header
  (printout t crlf "=====================================================")
  (printout t crlf "           MEDICAL DIAGNOSTIC REPORT")
  (printout t crlf "=====================================================")
  (printout t crlf)
  
  ;; Display patient identification
  (printout t "PATIENT IDENTIFIER: " ?pid crlf)
  (printout t "-----------------------------------------------------")
  (printout t crlf)
  
  ;; Display biomarker values
  (printout t "LAB MEASUREMENTS:" crlf)
  (printout t "  Fasting Plasma Glucose (FPG):   " ?fpg " mg/dL" crlf)
  (printout t "  Hemoglobin A1c (HbA1c):         " ?hba1c " %" crlf)
  (printout t crlf)
  
  ;; Display diagnosis result
  (printout t "DIAGNOSIS: " ?class crlf)
  (printout t "-----------------------------------------------------")
  (printout t crlf)
  
  ;; Display clinical justification
  (printout t "JUSTIFICATION:" crlf)
  (printout t "  " ?just crlf)
  (printout t crlf)
  
  ;; Display clinical recommendations based on diagnosis
  (if (eq ?class Type-2-Diabetes)
    then
      (printout t "CLINICAL RECOMMENDATION:" crlf)
      (printout t "  - Schedule comprehensive endocrine evaluation" crlf)
      (printout t "  - Initiate lifestyle modification program" crlf)
      (printout t "  - Consider pharmacological management" crlf)
      (printout t "  - Arrange follow-up testing in 3 months" crlf)
    else
      (if (eq ?class Inconclusive)
        then
          (printout t "CLINICAL RECOMMENDATION:" crlf)
          (printout t "  - Repeat diagnostic testing within 1-2 weeks" crlf)
          (printout t "  - Consider oral glucose tolerance test (OGTT)" crlf)
          (printout t "  - Discuss risk factors with healthcare provider" crlf)
        else
          (printout t "CLINICAL RECOMMENDATION:" crlf)
          (printout t "  - Maintain current lifestyle and diet" crlf)
          (printout t "  - Routine follow-up testing in 1-2 years" crlf)
          (printout t "  - Continue health monitoring" crlf)))
  
  (printout t crlf)
  (printout t "=====================================================")
  (printout t crlf "           END OF DIAGNOSTIC REPORT")
  (printout t crlf "=====================================================")
  (printout t crlf crlf))

;; Rule: Output Report for Validation Failure
;;   Triggered when invalid data is detected during the validation phase
;;   Displays an error message with diagnostic guidance
(defrule cli-output-validation-error
  (declare (salience 90))
  (system-state (phase validation))
  (invalid-data (patient-id ?pid) (error ?error-message))
  =>
  ;; Display error report header
  (printout t crlf "=====================================================")
  (printout t crlf "              DATA VALIDATION ERROR")
  (printout t crlf "=====================================================")
  (printout t crlf)
  
  ;; Display patient ID
  (printout t "PATIENT IDENTIFIER: " ?pid crlf)
  (printout t "-----------------------------------------------------")
  (printout t crlf)
  
  ;; Display error details
  (printout t "ERROR TYPE: " ?error-message crlf)
  (printout t crlf "DETAILS:" crlf)
  (printout t "  One or more input values are clinically implausible.")
  (printout t crlf "  Please verify the following constraints:" crlf)
  (printout t crlf)
  (printout t "  - FPG must be non-negative (>= 0 mg/dL)" crlf)
  (printout t "  - FPG should typically be < 800 mg/dL" crlf)
  (printout t "  - HbA1c must be non-negative (>= 0%)" crlf)
  (printout t "  - HbA1c should typically be < 15%" crlf)
  (printout t crlf)
  (printout t "ACTION REQUIRED:" crlf)
  (printout t "  Please re-run the system with corrected input values." crlf)
  (printout t crlf)
  (printout t "=====================================================")
  (printout t crlf "           END OF ERROR REPORT")
  (printout t crlf "=====================================================")
  (printout t crlf crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         END OF CLI INTERFACE RULES                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
