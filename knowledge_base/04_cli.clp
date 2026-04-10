;;; ============================================================================
;;; USER INTERFACE MODULE (CLI)
;;; Handles all user interaction directly in CLIPS
;;; Input collection, output formatting, and result display
;;; ============================================================================

;;; ============================================================================
;;; STARTUP RULE - Triggered on (initial-fact)
;;; ============================================================================

(defrule startup-display-welcome
  "Display welcome header and collect patient data from user"
  (initial-fact)
  =>
  
  ;; Display welcome banner
  (printout t crlf)
  (printout t "========================================" crlf)
  (printout t "  DIABETES DIAGNOSIS EXPERT SYSTEM" crlf)
  (printout t "  Rule-Based Medical Inference Engine" crlf)
  (printout t "========================================" crlf)
  (printout t crlf)
  
  ;; Collect Patient ID
  (printout t "--- Patient Data Entry ---" crlf)
  (printout t "Enter Patient ID (integer): ")
  (bind ?patient-id (read))
  
  ;; Collect Fasting Plasma Glucose
  (printout t "Enter Fasting Plasma Glucose (FPG) in mg/dL (float): ")
  (bind ?fpg (read))
  
  ;; Collect HbA1c
  (printout t "Enter Hemoglobin A1c (HbA1c) in % (float): ")
  (bind ?hba1c (read))
  
  ;; Display collected data
  (printout t crlf)
  (printout t "--- Data Summary ---" crlf)
  (printout t "Patient ID: " ?patient-id crlf)
  (printout t "FPG: " ?fpg " mg/dL" crlf)
  (printout t "HbA1c: " ?hba1c "%" crlf)
  (printout t crlf)
  
  ;; Assert patient fact into working memory
  (assert (patient (id ?patient-id) (fpg ?fpg) (hba1c ?hba1c)))
  
  ;; Assert initial system state to start the inference chain
  (assert (system-state (phase validation)))
  
  ;; Inform user that processing has begun
  (printout t "Starting inference engine..." crlf crlf))

;;; ============================================================================
;;; OUTPUT FORMATTING RULES
;;; ============================================================================

;;; Rule: Display successful diagnosis result
(defrule output-diagnosis-success
  "Format and display the final diagnosis in a clean medical report"
  ?diagnosis <- (diagnosis (patient-id ?id) (classification ?classification) (justification ?justification))
  (system-state (phase complete))
  =>
  
  ;; Print diagnosis header
  (printout t "========================================" crlf)
  (printout t "  DIAGNOSTIC REPORT" crlf)
  (printout t "========================================" crlf)
  (printout t crlf)
  
  ;; Print patient ID
  (printout t "Patient ID: " ?id crlf)
  
  ;; Format and print classification
  (printout t "Classification: " ?classification crlf)
  
  ;; Print justification
  (printout t "Justification: " crlf)
  (printout t "  " ?justification crlf)
  
  ;; Print footer
  (printout t crlf)
  (printout t "========================================" crlf)
  (printout t crlf)
  (printout t "Diagnostic reasoning complete." crlf crlf))

;;; Rule: Display validation error message
(defrule output-validation-error
  "Display error message if validation fails"
  (system-state (phase error))
  =>
  
  ;; Print error header
  (printout t crlf)
  (printout t "========================================" crlf)
  (printout t "  VALIDATION ERROR" crlf)
  (printout t "========================================" crlf)
  (printout t crlf)
  (printout t "The input data failed validation." crlf)
  (printout t "Please check for negative values or extreme measurements." crlf)
  (printout t crlf)
  (printout t "========================================" crlf)
  (printout t crlf)
  (printout t "Processing halted." crlf crlf))

;;; Rule: Display abstraction phase status
(defrule output-abstraction-status
  "Print status message when entering abstraction phase"
  ?state <- (system-state (phase abstraction))
  =>
  
  (printout t "========== ABSTRACTION PHASE ==========" crlf)
  (printout t "Interpreting biomarker values..." crlf crlf))

;;; Rule: Display diagnostic phase status
(defrule output-diagnostic-status
  "Print status message when entering diagnostic phase"
  ?state <- (system-state (phase diagnostic))
  =>
  
  (printout t "========== DIAGNOSTIC PHASE ==========" crlf)
  (printout t "Generating diagnostic conclusions..." crlf crlf))

;;; ============================================================================
;;; INFERENCE TRACE (OPTIONAL - Uncomment for debugging)
;;; ============================================================================

;;; Uncomment these rules if you want detailed rule firing information:

;;; (defrule trace-validation-passed
;;;   "Print when validation phase completes successfully"
;;;   (system-state (phase abstraction))
;;;   =>
;;;   (printout t "✓ Validation passed" crlf crlf))

;;; (defrule trace-clinical-findings
;;;   "Print clinical findings as they are asserted"
;;;   (clinical-finding (patient-id ?pid) (biomarker ?bm) (condition ?cond))
;;;   =>
;;;   (printout t "  → Clinical Finding: Patient " ?pid " - " ?bm " " ?cond crlf))

;;; ============================================================================
;;; EOF - 04_cli.clp
;;; ============================================================================
