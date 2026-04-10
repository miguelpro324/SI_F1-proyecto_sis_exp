# Sistema Experto para Diagnóstico Médico de Diabetes

## Inicio Rápido

### Forma Más Fácil (Recomendado)
```bash
./run_interactive_es.sh
```

Ingrese los datos del paciente cuando se le solicite y obtenga un diagnóstico instantáneo.

---

## Descripción General del Sistema

**Sistema Experto de Encadenamiento Progresivo** para diagnóstico de Diabetes Tipo 2 usando criterios WHO/ADA.

### Características
- ✅ Implementación pura en CLIPS (sin dependencias externas)
- ✅ Arquitectura multi-fase (Validación → Abstracción → Diagnóstico → Reporte)
- ✅ Tres resultados diagnósticos (Diabetes Tipo 2, Sin Diabetes, Inconcluso)
- ✅ Reportes médicos profesionales con recomendaciones
- ✅ Validación exhaustiva de entrada

### Criterios Diagnósticos
| Biomarcador | Umbral | Estado |
|-----------|--------|--------|
| FPG | ≥ 126 mg/dL | Diabético |
| HbA1c | ≥ 6.5% | Diabético |

**Diagnóstico**:
- Ambos diabéticos → Diabetes Tipo 2
- Ambos no-diabéticos → Sin Diabetes
- Mixtos → Inconcluso

---

## Archivos

### Sistema Central (5 archivos CLIPS)
- `00_templates.clp` - Estructuras de datos
- `01_validation_es.clp` - Validación de entrada
- `02_abstraction_es.clp` - Extracción de características
- `03_diagnostic_es.clp` - Razonamiento clínico
- `04_cli_es.clp` - Interfaz de usuario

### Scripts de Ejecución
- `run_interactive_es.sh` - Envoltorio interactivo (recomendado)
- `run_interactive.sh` - Versión en inglés
- `run.sh` - Envoltorio simple para lotes

### Pruebas
- `test_system.clp` - Prueba de Diabetes Tipo 2
- `test_validation_error.clp` - Prueba de manejo de errores
- `test_inconclusive.clp` - Prueba de diagnóstico inconcluso

### Documentación
- `README.md` - Descripción en inglés
- `README_ES.md` - Este archivo

---

## Uso

### Modo Interactivo (Recomendado)
```bash
./run_interactive_es.sh
```
Solicita al paciente ID, FPG y HbA1c. Muestra un reporte diagnóstico profesional.

### CLIPS Directo
```bash
clips
CLIPS> (load "00_templates.clp")
CLIPS> (load "01_validation_es.clp")
CLIPS> (load "02_abstraction_es.clp")
CLIPS> (load "03_diagnostic_es.clp")
CLIPS> (load "04_cli_es.clp")
CLIPS> (reset)
CLIPS> (run)
```

### Pruebas por Lotes
```bash
clips -f test_system.clp
```

---

## Ejemplo de Salida

**Entrada:** P001, FPG=135.0 mg/dL, HbA1c=7.2%

**Salida:**
```
DIAGNÓSTICO: Type-2-Diabetes

JUSTIFICACIÓN:
  Paciente cumple criterios diagnósticos para Diabetes Tipo 2: 
  FPG=135.0mg/dL (>= 126), HbA1c=7.2% (>= 6.5)

RECOMENDACIÓN CLÍNICA:
  - Programar evaluación endocrina integral
  - Iniciar programa de modificación del estilo de vida
  - Considerar manejo farmacológico
  - Realizar pruebas de seguimiento en 3 meses
```

---

## Arquitectura

```
ENTRADA DEL USUARIO → VALIDACIÓN → ABSTRACCIÓN → DIAGNÓSTICO → REPORTE
     ↓                    ↓            ↓             ↓            ↓
 Leer Datos        Verificar Límites Clasificar    Aplicar WHO/ADA  Reporte
                   • FPG >= 0        • FPG >= 126?  • Diabetes Tipo 2? Médico
                   • HbA1c >= 0      • HbA1c >= 6.5?• Ninguno?        Profesional
                   • Sin errores     → rangos       • Inconcluso?     + Recomendaciones
```

---

## Detalles del Sistema

**Lenguaje:** CLIPS 6.4.2  
**Arquitectura:** Encadenamiento progresivo multi-fase  
**Reglas:** 22 (5 validación, 5 abstracción, 4 diagnóstico, 3 interfaz)  
**Plantillas:** 5 (paciente, clinical-finding, diagnóstico, system-state, datos-inválidos)  
**Líneas de Código:** 400+ de código listo para producción  

---

## Validación de Entrada

El sistema valida automáticamente:
- **FPG:** Debe estar entre 0 y 800 mg/dL
- **HbA1c:** Debe estar entre 0 y 15%
- **ID del Paciente:** No puede estar vacío

Si se ingresan valores fuera de rango, el sistema le pedirá que intente de nuevo.

---

**Aviso Legal**: Este sistema es con fines educativos. Para un diagnóstico real, consulte a un profesional de salud calificado.
