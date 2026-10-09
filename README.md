# Registro de alumnos

Aplicación móvil de ejemplo hecha con Flutter para consultar y agregar alumnos.
La pantalla principal muestra los registros en un `ListView.builder` y el botón
**Agregar alumno** abre un formulario con los campos nombre, apellido y número
de cuenta. El formulario valida que los campos estén completos y que la cuenta
no esté duplicada.

## Ejecutar el proyecto

1. Abre la carpeta del proyecto en Android Studio o Visual Studio Code.
2. Asegúrate de tener instalado Flutter y un emulador o dispositivo configurado.
3. Descarga las dependencias con `flutter pub get`.
4. Ejecuta la aplicación con `flutter run` o usa **Run** desde el IDE.

## Estructura

- `Persona` representa a cada alumno mediante `name`, `lastname` y `cuenta`.
- `AlumnosPage` mantiene la lista `List<Persona>` y actualiza la interfaz al
  registrar un alumno.
- `_AlumnoCard` presenta los datos de cada registro.
- `_FormularioAlumno` valida y devuelve el nuevo alumno a la pantalla principal.

Los registros iniciales son datos de demostración y los alumnos agregados se
guardan en memoria; se reinician al cerrar la aplicación.
