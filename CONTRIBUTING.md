# Contributing to PHOST

Gracias por tu interés en contribuir a **PHOST** 🚀  
Este proyecto busca construir una plataforma local de desarrollo **estable, resiliente y operable por consola**, por lo que las contribuciones deben priorizar **calidad, claridad y robustez**.

---

## Filosofía del Proyecto

Antes de contribuir, ten en cuenta los principios base de PHOST:

- **CLI-first**: la consola es el punto central de control.
- **Estabilidad sobre conveniencia**: preferimos soluciones claras y seguras antes que atajos.
- **Resiliencia**: evitar pérdida de datos y configuraciones es prioritario.
- **Transparencia**: configuraciones explícitas, sin magia oculta.
- **Compatibilidad**: respetar el ecosistema clásico PHP (Apache, Nginx, MariaDB).

---

## Tipos de Contribuciones Bienvenidas

Puedes contribuir de muchas formas:

### 🧠 Diseño y Arquitectura
- Propuestas de estructura de carpetas.
- Mejores flujos de operación (start/stop/status).
- Ideas para la CLI (`phost`).

### 🛠️ Código
- Scripts PowerShell o Batch para automatización.
- Implementación de comandos CLI.
- Mejoras en validaciones y diagnósticos (`phost doctor`).

### 📚 Documentación
- Mejoras al README.
- Guías de instalación y recuperación.
- Diagramas y ejemplos claros.

### 🔐 Seguridad
- Hardening de configuraciones.
- Recomendaciones de buenas prácticas.
- Revisión de defaults inseguros.

---

## Reglas Básicas

Antes de enviar cualquier PR:

- ❌ No romper compatibilidad existente sin justificación clara.
- ❌ No introducir dependencias innecesarias.
- ❌ No ocultar configuraciones críticas.
- ✅ Documentar cualquier cambio funcional.
- ✅ Mantener scripts legibles y comentados.
- ✅ Probar en Windows 10/11.

---

## Flujo de Trabajo

1. **Fork** del repositorio.
2. Crea una rama descriptiva:
