;; Test validation error handling
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")

(reset)

(printout t crlf "====== VALIDATION ERROR TEST ======" crlf crlf)
(printout t ">> Testing with negative FPG (should fail validation):" crlf)
(printout t "   Patient ID: P002" crlf)
(printout t "   FPG: -50.0 mg/dL (INVALID)" crlf)
(printout t "   HbA1c: 6.5%" crlf crlf)

(assert (patient (id P002) (fpg -50.0) (hba1c 6.5)))
(assert (system-state (phase validation)))

(printout t ">> Running inference engine..." crlf crlf)
(run)

(printout t crlf "====== TEST COMPLETE ======" crlf)
