# Security Policy

## Introducción

La seguridad es un pilar fundamental de **PHOST**.  
Aunque PHOST está diseñado principalmente para entornos **locales de desarrollo**, una configuración insegura puede provocar pérdida de datos, accesos no deseados o malas prácticas que luego se trasladan a producción.

Este documento describe cómo reportar vulnerabilidades y las buenas prácticas de seguridad recomendadas al usar PHOST.

---

## Alcance

Esta política aplica a:

- Scripts de la CLI (`control/`)
- Scripts de instalación (`installer/`)
- Configuraciones por defecto proporcionadas por PHOST
- Documentación relacionada con seguridad

No aplica a vulnerabilidades internas de proyectos externos como:
- Apache HTTP Server
- Nginx
- PHP
- MariaDB
- phpMyAdmin

Para estos proyectos, consulta sus políticas oficiales.

---

## Versiones Soportadas

PHOST se encuentra en **fase alpha**.

- Solo la **última versión publicada** recibe soporte de seguridad.
- Versiones anteriores pueden contener configuraciones inseguras o no corregidas.

---

## Reporte de Vulnerabilidades

Si descubres una vulnerabilidad relacionada con PHOST:

### ✔️ Cómo reportar

1. **No** abras un issue público.
2. Contacta a los mantenedores del proyecto de forma privada.
3. Incluye la mayor cantidad de información posible:
   - Descripción clara del problema.
   - Pasos para reproducirlo.
   - Configuración afectada.
   - Impacto potencial.
   - Evidencia (logs, comandos, fragmentos de config).

Los reportes serán tratados de forma confidencial.

---

## Divulgación Responsable

- Se agradece la divulgación responsable.
- No publiques detalles técnicos hasta que el problema haya sido evaluado y mitigado.
- Los mantenedores decidirán cuándo y cómo comunicar el fix.

---

## Buenas Prácticas de Seguridad (Recomendadas)

### Configuración General
- No expongas PHOST directamente a Internet.
- Usa puertos no estándar si es posible.
- Limita el acceso a `localhost` cuando aplique.

### Nginx / Apache
- Desactiva directory listing.
- Limita métodos HTTP (`GET`, `POST`).
- Evita configuraciones por defecto inseguras.
- Usa Nginx como proxy inverso siempre que sea posible.

### PHP
- Desactiva `display_errors` en entornos no controlados.
- Revisa extensiones habilitadas.
- Mantén `php.ini` bajo control de versiones (sin secretos).

### MariaDB
- No uses usuarios sin contraseña.
- Evita usar `root` para aplicaciones.
- Realiza backups frecuentes y prueba restauraciones.

### phpMyAdmin
- Instálalo solo si es necesario.
- Limita acceso por IP o autenticación.
- No lo dejes habilitado permanentemente.

---

## Manejo de Credenciales

- **Nunca** subas contraseñas reales al repositorio.
- Usa placeholders como:
password=CHANGE_ME

- Mantén credenciales fuera del control de versiones.

---

## Logs y Datos Sensibles

- No versionar logs.
- Revisa que los logs no contengan información sensible.
- Protege la carpeta `backups/` con permisos adecuados.

---

## Automatización y Scripts

- Los scripts deben ser explícitos y predecibles.
- Evita ejecutar comandos destructivos sin confirmación.
- Documenta claramente cualquier acción que afecte datos o servicios.

---

## Estado del Proyecto

PHOST es una herramienta **local y experimental**.  
No se recomienda su uso directo en producción.

La responsabilidad final de la configuración y uso seguro recae en el usuario.

---

## Contacto

Para temas de seguridad, utiliza los canales privados definidos por los mantenedores del proyecto.

---

## Agradecimientos

Agradecemos a la comunidad por ayudar a identificar y reportar problemas de seguridad de forma responsable.
