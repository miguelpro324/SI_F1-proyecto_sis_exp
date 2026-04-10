;; Test inconclusive diagnosis
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")

(reset)

(printout t crlf "====== INCONCLUSIVE DIAGNOSIS TEST ======" crlf crlf)
(printout t ">> Testing with mixed biomarker results:" crlf)
(printout t "   Patient ID: P003" crlf)
(printout t "   FPG: 140.0 mg/dL (diabetic)" crlf)
(printout t "   HbA1c: 6.2% (non-diabetic)" crlf crlf)

(assert (patient (id P003) (fpg 140.0) (hba1c 6.2)))
(assert (system-state (phase validation)))

(printout t ">> Running inference engine..." crlf crlf)
(run)

(printout t crlf "====== TEST COMPLETE ======" crlf)
