;; ARCHIVO: 04_cli_es.clp
;; DESCRIPCIÓN: Interfaz de usuario - Genera reportes médicos profesionales y maneja errores.

;; Encabezado del sistema
(defrule MAIN::cli-initialize-system-header
   (declare (salience 100))
   (initial-fact)
   =>
   (flush)
   (printout t crlf crlf
             "====================================================" crlf
             "           REPORTE DE DIAGNÓSTICO MÉDICO" crlf
             "====================================================" crlf crlf))

;; ============================================================================
;; REGLA DE SALIDA: Diagnóstico exitoso
;; ============================================================================

(defrule MAIN::cli-output-successful-diagnosis
   (declare (salience 90))
   (system-state (phase reporting))
   (patient (id ?pid) (fpg ?fpg) (hba1c ?hba1c))
   (diagnosis (patient-id ?pid) (classification ?class) (justification ?just))
   =>
   (printout t "IDENTIFICADOR DEL PACIENTE: " ?pid crlf)
   (printout t "-----------------------------------------------------" crlf)
   (printout t "MEDICIONES DE LABORATORIO:" crlf)
   (printout t "  Glucosa Plasmática en Ayunas (FPG):   " ?fpg " mg/dL" crlf)
   (printout t "  Hemoglobina A1c (HbA1c):         " ?hba1c " %" crlf crlf)
   
   (printout t "DIAGNÓSTICO: " ?class crlf)
   (printout t "-----------------------------------------------------" crlf)
   
   ;; Justificación
   (printout t "JUSTIFICACIÓN:" crlf)
   (printout t "  " ?just crlf crlf)
   
   ;; Recomendaciones clínicas personalizadas por clasificación
   (if (eq ?class Type-2-Diabetes)
       then
       (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
       (printout t "  - Programar evaluación endocrina integral" crlf)
       (printout t "  - Iniciar programa de modificación del estilo de vida" crlf)
       (printout t "  - Considerar manejo farmacológico" crlf)
       (printout t "  - Realizar pruebas de seguimiento en 3 meses" crlf)
       else
       (if (eq ?class No-Diabetes)
           then
           (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
           (printout t "  - Mantener estilo de vida y dieta actual" crlf)
           (printout t "  - Pruebas de seguimiento rutinarias en 1-2 años" crlf)
           (printout t "  - Continuar monitoreo de salud" crlf)
           else
           (if (eq ?class Inconclusive)
               then
               (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
               (printout t "  - Repetir pruebas diagnósticas en 1-2 semanas" crlf)
               (printout t "  - Considerar prueba de tolerancia a la glucosa (PTGO)" crlf)
               (printout t "  - Discutir factores de riesgo con el proveedor de salud" crlf)
               )))
   
   (printout t crlf)
   (printout t "====================================================" crlf)
   (printout t "           FIN DEL REPORTE DE DIAGNÓSTICO" crlf)
   (printout t "====================================================" crlf crlf))

;; ============================================================================
;; REGLA DE SALIDA: Error de validación
;; ============================================================================

(defrule MAIN::cli-output-validation-error
   (declare (salience 90))
   (system-state (phase validation))
   (invalid-data (patient-id ?pid) (error ?error-msg))
   =>
   (printout t crlf crlf
             "====================================================" crlf
             "             ERROR DE VALIDACIÓN DE DATOS" crlf
             "====================================================" crlf crlf)
   (printout t "IDENTIFICADOR DEL PACIENTE: " ?pid crlf)
   (printout t "-----------------------------------------------------" crlf)
   (printout t "ERROR DETECTADO: " ?error-msg crlf crlf)
   (printout t "Por favor, verifique los datos del paciente e intente nuevamente." crlf)
   (printout t "Valores válidos:" crlf)
   (printout t "  - FPG (Glucosa en Ayunas): 0 - 800 mg/dL" crlf)
   (printout t "  - HbA1c: 0 - 15 %" crlf crlf)
   (printout t "====================================================" crlf
             "              FIN DEL REPORTE DE ERROR" crlf
             "====================================================" crlf crlf))
