;;; ============================================================================
;;; TEMPLATES MODULE
;;; Defines all fact templates for the diabetes diagnosis expert system
;;; ============================================================================

;;; Patient biomarker data
(deftemplate patient
  "Represents raw clinical data for a patient"
  (slot id (type INTEGER))
  (slot fpg (type FLOAT) (default 0.0))      ; Fasting Plasma Glucose (mg/dL)
  (slot hba1c (type FLOAT) (default 0.0)))   ; Hemoglobin A1c (%)

;;; Clinical abstraction layer
(deftemplate clinical-finding
  "Represents interpreted biomarker conditions"
  (slot patient-id (type INTEGER))
  (slot biomarker (type SYMBOL))             ; fpg | hba1c
  (slot condition (type SYMBOL)))            ; diabetic-range | normal-range | prediabetic-range

;;; Final diagnosis output
(deftemplate diagnosis
  "Represents the final diagnostic conclusion"
  (slot patient-id (type INTEGER))
  (slot classification (type SYMBOL))        ; type-2-diabetes | prediabetes | normal
  (slot justification (type STRING)))

;;; System control state machine
(deftemplate system-state
  "Controls the inference engine execution phases"
  (slot phase (type SYMBOL)                  ; startup | validation | abstraction | diagnostic | complete | error
              (default startup)))
