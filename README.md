# PHOST

<p align="center">
  <img src="assets/logo/logo.png" alt="PHOST Logo" width="180">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Windows%2010%2F11-blue" />
  <img src="https://img.shields.io/badge/CLI-first-success" />
  <img src="https://img.shields.io/badge/Nginx-Apache-green" />
  <img src="https://img.shields.io/badge/PHP-8.x-8892BF" />
  <img src="https://img.shields.io/badge/MariaDB-10.x-003545" />
  <img src="https://img.shields.io/badge/status-alpha-orange" />
</p>

---

Plataforma local de **desarrollo y hosting local** robusta que reestructura el modelo clásico de XAMPP con un enfoque **CLI-first**, mayor resiliencia ante pérdidas y soporte dual de servidores web (**Nginx + Apache**), manteniendo los servicios conocidos (PHP, MariaDB, phpMyAdmin opcional) y añadiendo prácticas modernas de seguridad, operación y recuperación.

---

## Visión General

PHOST nace para ofrecer una alternativa más versátil, controlable y estable al stack tradicional tipo XAMPP, priorizando la operación por consola y la prevención de fallos críticos (especialmente pérdida de datos).

Principios clave:

- Control por consola (CLI-first) para operaciones repetibles y automatizables.
- Nginx como proxy inverso y terminación TLS frente a Apache/PHP.
- Aislamiento de configuración, datos y logs por servicio.
- Flujos claros de backup y recuperación.
- Estructura modular: solo levantas lo que necesitas.

El objetivo es simplificar el desarrollo, pruebas y demos locales con una base más segura y resiliente, sin perder la familiaridad del ecosistema PHP clásico.

---

## Características Principales

- Arquitectura **Dual Web**: Nginx (proxy inverso) + Apache (servidor de aplicaciones).
- PHP integrado con Apache (mod_php) como base, con posibilidad de usar PHP-FPM/FastCGI en configuraciones avanzadas.
- Base de datos MariaDB con directorios dedicados para datos, logs y backups.
- phpMyAdmin **opcional**, ubicado en `htdocs/phpMyAdmin`, para administración rápida cuando se requiere interfaz web.
- Diseño de carpetas orientado a operación real: `backups/`, `logs/`, `control/`, `installer/`.
- Configuraciones aisladas y versionables por servicio.
- Enfoque en prevención de pérdida: snapshots, dumps y guías de recuperación.

---

## Arquitectura del Proyecto

### Flujo de tráfico recomendado

Cliente → Nginx (TLS / Reverse Proxy) → Apache + PHP → Aplicación (htdocs) → MariaDB

### Estructura del workspace

```
└── 📁phost
    └── 📁assets
        └── 📁logo
            ├── logo.png
    └── 📁backups
    └── 📁bin
        └── 📁apache
        └── 📁mariadb
        └── 📁nginx
        └── 📁php
    └── 📁commands
        ├── doctor.ps1
        ├── down.ps1
        ├── status.ps1
        ├── up.ps1
    └── 📁control
        ├── phost.lock
        ├── README.md
        ├── runtime.json
        ├── state.json
    └── 📁htdocs
        └── 📁phpMyAdmin
        ├── favicon.png
        ├── index.css
        ├── index.html
    └── 📁installer
    └── 📁lib
        └── 📁logs
            └── 📁nginx
        ├── apache.ps1
        ├── mariadb.ps1
        ├── nginx.ps1
    └── 📁logs
        └── 📁apache
        └── 📁mariadb
        └── 📁nginx
        └── 📁php
    ├── .gitignore
    ├── CODE OF CONDUCT.md
    ├── CONTRIBUTING.md
    ├── LICENSE
    ├── phost.ps1
    ├── README.md
    └── SECURITY.md
```

## Requisitos

- Windows 10 u 11.
- PowerShell o CMD con permisos suficientes.
- Opcional: variables de entorno y PATH configurado para mayor comodidad.

---

## Instalación (Windows)

1. Clona o descarga el proyecto en tu máquina local.
2. Revisa y ajusta configuraciones base según tu entorno:
   - Apache: `bin/apache/conf/`
   - Nginx: `bin/nginx/conf/`
   - PHP: genera `php.ini` a partir de `php.ini-development`
   - MariaDB: configura usuarios, contraseñas y rutas de datos
3. (Opcional) Define la variable de entorno `PHOST_HOME` apuntando al directorio raíz del proyecto.
4. (Opcional) Añade los binarios principales al `PATH`.

> Nota: Las rutas exactas de los ejecutables pueden variar según la distribución descargada. Ajusta los comandos a tu entorno real.

---

## Uso Rápido (Ejemplos)

### PowerShell

```powershell
# Verificar y arrancar Nginx
Set-Location "d:\phost\bin\nginx"
./nginx.exe -t
./nginx.exe

# Verificar y arrancar Apache
Set-Location "d:\phost\bin\apache\bin"
./httpd.exe -t
./httpd.exe

# Arrancar MariaDB en consola
Set-Location "d:\phost\bin\mariadb\bin"
./mysqld.exe --console

# Comprobar PHP
Set-Location "d:\phost\bin\php"
./php.exe -v

## Configuración Clave

- Apache: bin/apache/conf/httpd.conf y extra/.
- Nginx: bin/nginx/conf (bloques server, upstream hacia Apache/PHP).
- PHP: php.ini generado a partir de bin/php/php.ini-development.
- phpMyAdmin: htdocs/phpMyAdmin/config.sample.inc.php como base.

## Seguridad y Resiliencia

- Proxy inverso con Nginx: terminación TLS, headers seguros (HSTS, CSP opcional).
- Desactivar listings de directorio y limitar métodos en Apache/Nginx.
- Cuentas de MariaDB con contraseñas robustas y privilegios mínimos.
- Aislar logs: logs/nginx, logs/mariadb, logs/php.
- Mantener un plan de backups y pruebas de recuperación periódicas.

## Backups y Recuperación

- Snapshots de código y configuración: utiliza backups para versiones fechadas.
- Ejemplo de dump general de BD (ajusta usuario/puerto):

```powershell
Set-Location "d:\cli-workspace\phost\bin\mariadb\bin"
./mysqldump.exe -u root -p --all-databases > "d:\cli-workspace\phost\backups\%DATE%-all.sql"
```

- Restauración (ejemplo):

```powershell
./mysql.exe -u root -p < "d:\cli-workspace\phost\backups\2025-12-20-all.sql"
```

- Respaldos de htdocs/ y conf/: copias atómicas por carpeta con sello de tiempo.

## CLI y Automatización (Roadmap)

Se prevé una CLI en control para:

- phost up / phost down: levantar/detener servicios.
- phost restart / phost status: reinicio y estado consolidado.
- phost backup / phost restore: flujos de respaldo y recuperación.
- phost config: utilidades para generar/validar archivos de configuración.

Mientras se consolida la CLI, usa los binarios directos o scripts de installer/.

## Guía de Contribución

Por favor revisa CONTRIBUTING.md y el CODE OF CONDUCT.md.
Se agradecen PRs con mejoras en seguridad, automatización y DX.

## Licencia y Seguridad

- Licencia: ver LICENSE.
- Reportes de seguridad: consulta SECURITY.md para el proceso y contactos.

## Créditos

PHOST integra y respeta los proyectos Apache HTTP Server, Nginx, MariaDB, PHP y phpMyAdmin. Este trabajo busca armonizar su operación local con una experiencia moderna de consola y resiliencia.

## Soporte

Abre incidencias en el repositorio con detalles del entorno (Windows, versiones de binarios, configuración aplicada) y pasos para reproducir.
