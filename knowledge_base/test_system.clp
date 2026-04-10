;; Test script - bypasses interactive input
(load "00_templates.clp")
(load "01_validation.clp")
(load "02_abstraction.clp")
(load "03_diagnostic.clp")
(load "04_cli.clp")

(reset)

;; Simulate user input by directly asserting patient fact
(printout t crlf "====== EXPERT SYSTEM TEST (Non-Interactive) ======" crlf crlf)
(printout t ">> Simulating Patient Input:" crlf)
(printout t "   Patient ID: P001" crlf)
(printout t "   FPG: 135.0 mg/dL" crlf)
(printout t "   HbA1c: 7.2%" crlf crlf)

(assert (patient (id P001) (fpg 135.0) (hba1c 7.2)))
(assert (system-state (phase validation)))

(printout t ">> Triggering inference engine..." crlf crlf)
(run)

(printout t crlf "====== TEST COMPLETE ======" crlf)
