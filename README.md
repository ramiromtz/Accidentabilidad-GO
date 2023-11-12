# Aplicación Web para el Control de Accidentabilidad en Gas de Oaxaca

## Descripción

Esta aplicación web está diseñada para el control y gestión de la accidentabilidad en la industria del gas en la región de Oaxaca. Permite a los usuarios realizar tareas específicas relacionadas con la seguridad y el registro de incidentes.

## Tecnologías Utilizadas

- Java 8
- JSP (JavaServer Pages)
- JavaScript
- Apache Tomcat
- PostgreSQL
- PgAdmin

## Configuración del Entorno

### Requisitos del Sistema

Asegúrate de tener instalados los siguientes requisitos antes de ejecutar la aplicación:

- Java 8
- Apache Tomcat
- PostgreSQL
- PgAdmin

### Configuración
1. Clona el repositorio:

   ```bash
   git clone https://github.com/tu-usuario/aplicacion-control-accidentes.git
   ```

2. Configuración de JAVA 8:
    ##### Para Windows
   1. **Descarga del JDK 8:**
     - Visita la [página de descargas de Java SE 8](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html) en el sitio oficial de Oracle.
    - Acepta los términos y condiciones.
    - Selecciona la versión de JDK que corresponda a tu sistema operativo Windows y arquitectura (por ejemplo, Windows x64).
   2. **Instalación del JDK 8:**
    - Ejecuta el instalador después de descargarlo.
    - Sigue las instrucciones del asistente de instalación.
    - Elige la ubicación de instalación (o usa la predeterminada) y completa la instalación.
   3. **Configuración de las Variables de Entorno:**
    - Abre el "Panel de control" de Windows y busca "Variables de entorno".
    - Haz clic en "Editar las variables de entorno del sistema".
    - Agrega una nueva variable de sistema llamada `JAVA_HOME` con el valor de la ubicación de tu directorio de       instalación de Java (por ejemplo, `C:\Program Files\Java\jdk1.8.0_XXX`).
    - Modifica la variable del sistema `Path` y agrega `%JAVA_HOME%\bin` al principio.
   4. **Verificación de la Instalación:**
    - Abre una nueva ventana de la línea de comandos (cmd) y escribe `java -version` y `javac -version` para verificar que la instalación se realizó correctamente.
3.  Instalación de Apache Tomcat
    1. Descarga de Apache Tomcat: - Visita la [página de descargas de Apache Tomcat](https://tomcat.apache.org/download-80.cgi) en el sitio oficial. - En la sección "Binary Distributions", elige la versión de Tomcat que desees (por ejemplo, "8.5.xx" en el momento de la redacción) y selecciona el formato del archivo comprimido (ZIP o tar.gz) que prefieras.
    2. Extracción del Archivo: - Después de la descarga, extrae el contenido del archivo comprimido en el directorio de tu elección. **En Windows:** - Utiliza tu programa de descompresión favorito, como WinRAR o 7-Zip, para extraer el contenido. #### 
    3. Configuración de Variables de Entorno (Opcional): - Opcionalmente, puedes configurar una variable de entorno llamada `CATALINA_HOME` que apunte al directorio de instalación de Tomcat.   **En Windows:**   - Abre el "Panel de control".   - Busca "Variables de entorno".   - Haz clic en "Editar las variables de entorno del sistema".   - Agrega una nueva variable de sistema llamada `CATALINA_HOME` con el valor de la ubicación de tu directorio de instalación de Tomcat.
4. Instalación de la BD
    - Importar la base de datos usando pgAdmin v4.
5. Ejecución del proyecto
    - Una vez en Netbeans o Eclipse en librerias se debe incluir el driver de postgresql
    - Incluir el servidor Apache Tomcat
    - Incluir la libreria Jakarta EE web 8

Una vez hecho todo esto debería funcionar correctamente la aplicacion accediendo a [http://localhost:8080/accidentabilidad_app/](http://localhost:8080/accidentabilidad_app/) NOTA: **La carpeta del proyecto debe estar en la carpeta de proyectos del IDE que se esté usando**

### Descripción de la Base de Datos

#### Tabla `Usuarios`

| ID | Nombre de Usuario | Estado | Rol           |
|----|-------------------|--------|---------------|
| 1  | usuario1          | Activo | Operador      |
| 2  | usuario2          | Inactivo | Supervisor  |
| 3  | usuario3          | Activo | Investigador  |

- **Estado:**
  - `Activo`: El usuario tiene acceso al sistema.
  - `Inactivo`: El usuario no tiene acceso al sistema.

- **Roles:**
  - `Operador`: Usuario con privilegios de operación.
  - `Supervisor`: Usuario con privilegios de supervisión.
  - `Investigador`: Usuario con privilegios de investigación.

### Capturas de Pantalla

<div style="display:flex; justify-content: space-between;">
  <img src="url_de_la_imagen_1" alt="Descripción de la imagen 1" width="30%">
  <img src="url_de_la_imagen_2" alt="Descripción de la imagen 2" width="30%">
  <img src="url_de_la_imagen_3" alt="Descripción de la imagen 3" width="30%">
</div>

