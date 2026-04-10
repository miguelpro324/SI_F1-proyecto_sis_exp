;; ARCHIVO: 04_cli_es.clp
;; DESCRIPCIÓN: Capa de interfaz de usuario - Genera reportes médicos profesionales y maneja errores.

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
   (printout t "JUSTIFICACIÓN:" crlf)
   (printout t "  " ?just crlf crlf)
   
   ;; Recomendaciones clínicas personalizadas
   (if (eq ?class Healthy)
       then
       (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
       (printout t "  - Mantener estilo de vida y dieta saludable actual" crlf)
       (printout t "  - Continuar con actividad física regular" crlf)
       (printout t "  - Pruebas de seguimiento rutinarias en 3 años" crlf)
       else
       (if (eq ?class Prediabetes)
           then
           (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
           (printout t "  - Iniciar o intensificar modificaciones del estilo de vida" crlf)
           (printout t "  - Objetivo: 150 minutos de actividad aeróbica moderada semanal" crlf)
           (printout t "  - Reducir peso 5-10% si tiene sobrepeso" crlf)
           (printout t "  - Pruebas de seguimiento en 6-12 meses" crlf)
           else
           (if (eq ?class Type-2-Diabetes)
               then
               (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
               (printout t "  - Programar evaluación endocrina integral" crlf)
               (printout t "  - Iniciar programa de modificación del estilo de vida" crlf)
               (printout t "  - Considerar manejo farmacológico" crlf)
               (printout t "  - Realizar pruebas de seguimiento en 3 meses" crlf)
               else
               (if (eq ?class Type-1-Diabetes)
                   then
                   (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
                   (printout t "  - URGENTE: Derivar a endocrinólogo" crlf)
                   (printout t "  - Iniciar terapia de insulina inmediatamente" crlf)
                   (printout t "  - Panel metabólico integral y pruebas autoinmunológicas" crlf)
                   (printout t "  - Educación en diabetes y capacitación de autocontrol" crlf)
                   (printout t "  - Seguimiento frecuente (inicialmente cada 1-2 semanas)" crlf)
                   else
                   (if (eq ?class Inconclusive)
                       then
                       (printout t "RECOMENDACIÓN CLÍNICA:" crlf)
                       (printout t "  - Repetir pruebas diagnósticas en 1-2 semanas" crlf)
                       (printout t "  - Considerar prueba de tolerancia a la glucosa (PTGO)" crlf)
                       (printout t "  - Discutir factores de riesgo con el proveedor de salud" crlf)
                       (printout t "  - Monitorear desarrollo de síntomas" crlf)
                       )))))
   
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
   (printout t "Rangos válidos:" crlf)
   (printout t "  - FPG (Glucosa en Ayunas): 0 - 800 mg/dL" crlf)
   (printout t "  - HbA1c: 0 - 15 %" crlf crlf)
   (printout t "====================================================" crlf
             "              FIN DEL REPORTE DE ERROR" crlf
             "====================================================" crlf crlf))
