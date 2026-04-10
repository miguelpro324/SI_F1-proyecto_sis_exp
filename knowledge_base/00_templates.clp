;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    EXPERT SYSTEM TEMPLATE DEFINITIONS                      ;;
;;                     Diabetes Diagnosis - Data Structures                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Template: Patient Information
;;   - id: Unique identifier for the patient (SYMBOL)
;;   - fpg: Fasting Plasma Glucose level in mg/dL (FLOAT)
;;   - hba1c: Hemoglobin A1c percentage (FLOAT)
;;   - type-1-indicators: Presence of Type-1 indicators (SYMBOL: yes/no)
(deftemplate patient
  (slot id (type SYMBOL))
  (slot fpg (type FLOAT))
  (slot hba1c (type FLOAT))
  (slot type-1-indicators (type SYMBOL)))

;; Template: Clinical Finding
;;   - patient-id: Reference to the patient record (SYMBOL)
;;   - biomarker: The specific biomarker being evaluated (SYMBOL)
;;   - condition: The clinical classification of the biomarker (SYMBOL)
;;   Examples: biomarker=fpg, condition=diabetic-range
(deftemplate clinical-finding
  (slot patient-id (type SYMBOL))
  (slot biomarker (type SYMBOL))
  (slot condition (type SYMBOL)))

;; Template: Diagnosis Result
;;   - patient-id: Reference to the patient record (SYMBOL)
;;   - classification: The diagnosed condition (SYMBOL)
;;   - justification: Textual explanation of the diagnosis (STRING)
(deftemplate diagnosis
  (slot patient-id (type SYMBOL))
  (slot classification (type SYMBOL))
  (slot justification (type STRING)))

;; Template: System Control State
;;   - phase: Current execution phase of the forward-chaining engine (SYMBOL)
;;   Phases: validation -> abstraction -> diagnostic -> reporting
(deftemplate system-state
  (slot phase (type SYMBOL)))

;; Template: Invalid Data Signal
;;   - patient-id: Reference to the patient with invalid data (SYMBOL)
;;   - error: Description of the validation error (STRING)
(deftemplate invalid-data
  (slot patient-id (type SYMBOL))
  (slot error (type STRING)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      END OF TEMPLATE DEFINITIONS                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
