# ============================================
# HU-38 - Actualizar incidentes registrados en el sistema técnico
# ============================================
Feature: Actualizar incidentes registrados en el sistema técnico
  Como desarrollador del sistema,
  quiero actualizar la información de incidentes existentes,
  para mantener datos precisos y mejorar la calidad de los reportes del sistema Guardian+.

  Scenario Outline: Escenario 1 - Actualización exitosa de un incidente existente
    Dado que el <desarrollador> tiene acceso al <endpoint de actualización> y el <ID> del incidente existe
    Cuando realiza una <petición PUT> con un <payload válido>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de confirmación de actualización>

    Examples: Datos de entrada
      | desarrollador | petición PUT | endpoint de actualización             | ID | payload válido                      | sistema |
      | Técnico API   | PUT          | /api/incidentes/actualizar/<ID>      | 21 | {"descripcion":"Actualizada"}       | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de confirmación de actualización |
      | 200                  | Incidente actualizado correctamente      |

  Scenario Outline: Escenario 2 - Validación fallida de campos requeridos
    Dado que el <desarrollador> tiene acceso al <endpoint de actualización>
    Cuando realiza una <petición PUT> con un <payload inválido>
    Entonces el <sistema> retorna el <código de estado 400> y un <mensaje de error de validación>

    Examples: Datos de entrada
      | desarrollador | petición PUT | endpoint de actualización        | payload inválido                 | sistema |
      | Técnico API   | PUT          | /api/incidentes/actualizar/21    | {"descripcion":""}               | API     |

    Examples: Datos de salida
      | código de estado 400 | mensaje de error de validación            |
      | 400                  | Campos obligatorios faltantes o inválidos |

  Scenario Outline: Escenario 3 - Error por falta de permisos del usuario
    Dado que el <desarrollador> no posee <permisos de edición> para el recurso
    Cuando realiza una <petición PUT> al <endpoint de actualización>
    Entonces el <sistema> retorna el <código de estado 403> y un <mensaje de acceso denegado>

    Examples: Datos de entrada
      | desarrollador | petición PUT | endpoint de actualización        | permisos de edición | sistema |
      | Técnico API   | PUT          | /api/incidentes/actualizar/21    | no otorgados        | API     |

    Examples: Datos de salida
      | código de estado 403 | mensaje de acceso denegado |
      | 403                  | Permisos insuficientes     |

# ============================================
# HU-39 - Consultar detalle de un incidente
# ============================================
Feature: Consultar detalle de un incidente
  Como desarrollador del sistema,
  quiero recuperar el detalle de un incidente,
  para mostrar información completa a los módulos de visualización.

  Scenario Outline: Escenario 1 - Consulta exitosa
    Dado que el <desarrollador> tiene acceso al <endpoint de detalle>
    Cuando realiza una <petición GET> con un <ID existente>
    Entonces el <sistema> retorna el <código de estado 200> y un <cuerpo con el detalle del incidente>

    Examples: Datos de entrada
      | desarrollador | petición GET | endpoint de detalle            | ID existente | sistema |
      | Técnico API   | GET          | /api/incidentes/detalle/<ID>   | 45           | API     |

    Examples: Datos de salida
      | código de estado 200 | cuerpo con el detalle del incidente |
      | 200                  | Detalle recuperado                  |

  Scenario Outline: Escenario 2 - Incidente no encontrado
    Dado que el <desarrollador> tiene acceso al <endpoint de detalle>
    Cuando realiza una <petición GET> con un <ID inexistente>
    Entonces el <sistema> retorna el <código de estado 404> y un <mensaje de no encontrado>

    Examples: Datos de entrada
      | desarrollador | petición GET | endpoint de detalle            | ID inexistente | sistema |
      | Técnico API   | GET          | /api/incidentes/detalle/<ID>   | 9999           | API     |

    Examples: Datos de salida
      | código de estado 404 | mensaje de no encontrado      |
      | 404                  | Incidente no encontrado       |

  Scenario Outline: Escenario 3 - Error interno del servidor
    Dado que el <servicio de base de datos> se encuentra <no disponible>
    Cuando el <desarrollador> realiza una <petición GET> al <endpoint de detalle>
    Entonces el <sistema> retorna el <código de estado 500> y un <mensaje de error interno>

    Examples: Datos de entrada
      | desarrollador | petición GET | endpoint de detalle          | servicio de base de datos | no disponible | sistema |
      | Técnico API   | GET          | /api/incidentes/detalle/45   | DB                         | true          | API     |

    Examples: Datos de salida
      | código de estado 500 | mensaje de error interno        |
      | 500                  | Error interno del servidor      |

# ============================================
# HU-40 - Filtrar incidentes por criterios de búsqueda
# ============================================
Feature: Filtrar incidentes por criterios de búsqueda
  Como desarrollador del sistema,
  quiero filtrar incidentes por fecha, tipo y zona,
  para facilitar el análisis y visualización en los módulos de reporte.

  Scenario Outline: Escenario 1 - Filtrado exitoso con múltiples criterios
    Dado que el <desarrollador> tiene acceso al <endpoint de listado con filtros>
    Cuando realiza una <petición GET> con <parámetros de filtro válidos>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista de incidentes filtrada>

    Examples: Datos de entrada
      | desarrollador | petición GET | endpoint de listado con filtros | parámetros de filtro válidos         | sistema |
      | Técnico API   | GET          | /api/incidentes?tipo=<tipo>&zona=<zona>&desde=<fecha> | tipo=robo,zona=Centro,desde=2025-10-01 | API     |

    Examples: Datos de salida
      | código de estado 200 | lista de incidentes filtrada |
      | 200                  | Resultados coincidentes      |

  Scenario Outline: Escenario 2 - Parámetros inválidos
    Dado que el <desarrollador> tiene acceso al <endpoint de listado con filtros>
    Cuando envía <parámetros de filtro inválidos>
    Entonces el <sistema> retorna el <código de estado 400> y un <mensaje de error de parámetros>

    Examples: Datos de entrada
      | desarrollador | endpoint de listado con filtros | parámetros de filtro inválidos       | sistema |
      | Técnico API   | /api/incidentes                 | tipo=DESCONOCIDO&desde=fecha_invalida | API     |

    Examples: Datos de salida
      | código de estado 400 | mensaje de error de parámetros |
      | 400                  | Parámetros inválidos           |

# ============================================
# HU-41 - Adjuntar evidencia multimedia a un incidente
# ============================================
Feature: Adjuntar evidencia multimedia a un incidente
  Como desarrollador del sistema,
  quiero adjuntar fotos y audios a un incidente,
  para enriquecer la información recopilada y facilitar la validación.

  Scenario Outline: Escenario 1 - Adjuntar archivo válido
    Dado que el <desarrollador> tiene acceso al <endpoint de adjuntos>
    Cuando realiza una <petición POST> con un <archivo multimedia válido>
    Entonces el <sistema> retorna el <código de estado 201> y un <mensaje de carga exitosa>

    Examples: Datos de entrada
      | desarrollador | petición POST | endpoint de adjuntos                 | archivo multimedia válido | sistema |
      | Técnico API   | POST          | /api/incidentes/<ID>/adjuntos        | foto.jpg                  | API     |

    Examples: Datos de salida
      | código de estado 201 | mensaje de carga exitosa |
      | 201                  | Archivo adjuntado        |

  Scenario Outline: Escenario 2 - Formato de archivo no permitido
    Dado que el <desarrollador> tiene acceso al <endpoint de adjuntos>
    Cuando realiza una <petición POST> con un <archivo multimedia no permitido>
    Entonces el <sistema> retorna el <código de estado 415> y un <mensaje de tipo no soportado>

    Examples: Datos de entrada
      | desarrollador | petición POST | endpoint de adjuntos          | archivo multimedia no permitido | sistema |
      | Técnico API   | POST          | /api/incidentes/45/adjuntos   | script.exe                      | API     |

    Examples: Datos de salida
      | código de estado 415 | mensaje de tipo no soportado |
      | 415                  | Tipo de archivo no soportado |

# ============================================
# HU-42 - Autenticación de usuarios con token
# ============================================
Feature: Autenticación de usuarios con token
  Como sistema de autenticación,
  quiero validar tokens de acceso,
  para proteger los endpoints y recursos del backend.

  Scenario Outline: Escenario 1 - Token válido permite acceso
    Dado que el <usuario> proporciona un <token válido> en la cabecera
    Cuando accede a un <endpoint protegido>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de acceso concedido>

    Examples: Datos de entrada
      | usuario     | token válido        | endpoint protegido  | sistema |
      | Desarrollor | token_valido_abc123 | /api/protegido      | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de acceso concedido |
      | 200                  | Acceso autorizado           |

  Scenario Outline: Escenario 2 - Token inválido o expirado
    Dado que el <usuario> proporciona un <token inválido>
    Cuando accede a un <endpoint protegido>
    Entonces el <sistema> retorna el <código de estado 401> y un <mensaje de autenticación fallida>

    Examples: Datos de entrada
      | usuario     | token inválido         | endpoint protegido | sistema |
      | Desarrollor | token_expirado_999     | /api/protegido     | API     |

    Examples: Datos de salida
      | código de estado 401 | mensaje de autenticación fallida |
      | 401                  | Acceso no autorizado             |

# ============================================
# HU-43 - Notificaciones de incidentes a contactos y autoridades
# ============================================
Feature: Notificaciones de incidentes a contactos y autoridades
  Como desarrollador del sistema,
  quiero enviar notificaciones a contactos de confianza y autoridades,
  para escalar la atención ante situaciones de riesgo.

  Scenario Outline: Escenario 1 - Notificación enviada correctamente
    Dado que el <usuario> registra un <incidente válido>
    Cuando el <sistema de notificaciones> procesa el <evento de alerta>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de notificación enviada>

    Examples: Datos de entrada
      | usuario | incidente válido | sistema de notificaciones | evento de alerta | sistema |
      | App     | asalto           | Push                      | ALERTA_PANICO    | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de notificación enviada |
      | 200                  | Notificación enviada            |

  Scenario Outline: Escenario 2 - Error al enviar notificación
    Dado que el <usuario> registra un <incidente válido>
    Cuando el <sistema de notificaciones> está <no disponible>
    Entonces el <sistema> retorna el <código de estado 503> y un <mensaje de servicio no disponible>

    Examples: Datos de entrada
      | usuario | incidente válido | sistema de notificaciones | no disponible | sistema |
      | App     | robo             | Push                      | true          | API     |

    Examples: Datos de salida
      | código de estado 503 | mensaje de servicio no disponible |
      | 503                  | Servicio no disponible            |

# ============================================
# HU-44 - Exportar reportes de incidentes
# ============================================
Feature: Exportar reportes de incidentes
  Como analista de datos,
  quiero exportar reportes en formatos estándar,
  para compartir información con las partes interesadas.

  Scenario Outline: Escenario 1 - Exportación en CSV exitosa
    Dado que el <analista> tiene acceso al <endpoint de exportación>
    Cuando solicita una <exportación en formato CSV> con <parámetros válidos>
    Entonces el <sistema> retorna el <código de estado 200> y un <archivo CSV generado>

    Examples: Datos de entrada
      | analista | endpoint de exportación | exportación en formato CSV | parámetros válidos | sistema |
      | QA       | /api/reportes/exportar  | CSV                        | fecha=2025-10      | API     |

    Examples: Datos de salida
      | código de estado 200 | archivo CSV generado |
      | 200                  | archivo.csv          |

  Scenario Outline: Escenario 2 - Formato no soportado
    Dado que el <analista> tiene acceso al <endpoint de exportación>
    Cuando solicita una <exportación en formato no soportado>
    Entonces el <sistema> retorna el <código de estado 415> y un <mensaje de formato inválido>

    Examples: Datos de entrada
      | analista | endpoint de exportación | exportación en formato no soportado | sistema |
      | QA       | /api/reportes/exportar  | XLS                                  | API     |

    Examples: Datos de salida
      | código de estado 415 | mensaje de formato inválido |
      | 415                  | Formato no soportado        |

# ============================================
# HU-45 - Paginación y ordenamiento de listados
# ============================================
Feature: Paginación y ordenamiento de listados
  Como desarrollador del sistema,
  quiero paginar y ordenar las listas de incidentes,
  para mejorar el rendimiento y la experiencia del usuario.

  Scenario Outline: Escenario 1 - Paginación válida
    Dado que el <desarrollador> tiene acceso al <endpoint de listado>
    Cuando consulta con <parámetros de paginación válidos>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista paginada>

    Examples: Datos de entrada
      | desarrollador | endpoint de listado | parámetros de paginación válidos | sistema |
      | Técnico API   | /api/incidentes     | page=1&size=20                   | API     |

    Examples: Datos de salida
      | código de estado 200 | lista paginada |
      | 200                  | Página 1/20    |

  Scenario Outline: Escenario 2 - Ordenamiento por campo
    Dado que el <desarrollador> tiene acceso al <endpoint de listado>
    Cuando consulta con <parámetros de ordenamiento válidos>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista ordenada>

    Examples: Datos de entrada
      | desarrollador | endpoint de listado | parámetros de ordenamiento válidos | sistema |
      | Técnico API   | /api/incidentes     | sort=fecha,desc                    | API     |

    Examples: Datos de salida
      | código de estado 200 | lista ordenada |
      | 200                  | Orden aplicada |

# ============================================
# HU-46 - Gestión de usuarios: bloqueo y reactivación
# ============================================
Feature: Gestión de usuarios: bloqueo y reactivación
  Como administrador del sistema,
  quiero bloquear y reactivar usuarios,
  para prevenir abusos y mantener la seguridad de la plataforma.

  Scenario Outline: Escenario 1 - Bloqueo de usuario exitoso
    Dado que el <administrador> tiene acceso al <endpoint de gestión de usuarios>
    Cuando realiza una <petición PATCH> con <acción de bloqueo>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de usuario bloqueado>

    Examples: Datos de entrada
      | administrador | petición PATCH | endpoint de gestión de usuarios | acción de bloqueo     | sistema |
      | Admin         | PATCH          | /api/usuarios/<ID>/estado       | bloquear              | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de usuario bloqueado |
      | 200                  | Usuario bloqueado            |

  Scenario Outline: Escenario 2 - Reactivación de usuario
    Dado que el <administrador> tiene acceso al <endpoint de gestión de usuarios>
    Cuando realiza una <petición PATCH> con <acción de reactivación>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de usuario reactivado>

    Examples: Datos de entrada
      | administrador | petición PATCH | endpoint de gestión de usuarios | acción de reactivación | sistema |
      | Admin         | PATCH          | /api/usuarios/<ID>/estado       | reactivar              | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de usuario reactivado |
      | 200                  | Usuario reactivado            |

# ============================================
# HU-47 - Registro de auditoría para cambios críticos
# ============================================
Feature: Registro de auditoría para cambios críticos
  Como auditor del sistema,
  quiero registrar cambios críticos en logs,
  para asegurar trazabilidad y cumplimiento.

  Scenario Outline: Escenario 1 - Auditoría almacenada
    Dado que el <sistema> está configurado con <registro de auditoría activo>
    Cuando se ejecuta una <operación crítica> por un <usuario autenticado>
    Entonces se genera un <evento de auditoría> con <detalle de la operación>

    Examples: Datos de entrada
      | sistema | registro de auditoría activo | operación crítica | usuario autenticado |
      | API     | true                         | ELIMINAR_INCIDENTE | admin              |

    Examples: Datos de salida
      | evento de auditoría | detalle de la operación      |
      | generado            | Operación registrada en logs |

# ============================================
# HU-48 - Geolocalización de incidentes cercanos
# ============================================
Feature: Geolocalización de incidentes cercanos
  Como usuario,
  quiero consultar incidentes cercanos a mi ubicación,
  para evaluar riesgos en tiempo real.

  Scenario Outline: Escenario 1 - Consulta por radio exitosa
    Dado que el <usuario> proporciona una <ubicación válida> y un <radio en metros>
    Cuando realiza una <petición GET> al <endpoint de geolocalización>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista de incidentes cercanos>

    Examples: Datos de entrada
      | usuario | ubicación válida       | radio en metros | petición GET | endpoint de geolocalización | sistema |
      | App     | -12.0464,-77.0428      | 500             | GET          | /api/incidentes/cercanos     | API     |

    Examples: Datos de salida
      | código de estado 200 | lista de incidentes cercanos |
      | 200                  | Resultados en el radio       |

  Scenario Outline: Escenario 2 - Ubicación inválida
    Dado que el <usuario> proporciona una <ubicación inválida>
    Cuando realiza una <petición GET> al <endpoint de geolocalización>
    Entonces el <sistema> retorna el <código de estado 400> y un <mensaje de ubicación inválida>

    Examples: Datos de entrada
      | usuario | ubicación inválida | petición GET | endpoint de geolocalización | sistema |
      | App     | 999,999            | GET          | /api/incidentes/cercanos     | API     |

    Examples: Datos de salida
      | código de estado 400 | mensaje de ubicación inválida |
      | 400                  | Coordenadas inválidas         |

# ============================================
# HU-49 - Recuperación de contraseña
# ============================================
Feature: Recuperación de contraseña
  Como usuario,
  quiero recuperar el acceso a mi cuenta,
  para reestablecer mi contraseña de forma segura.

  Scenario Outline: Escenario 1 - Envío de correo de recuperación
    Dado que el <usuario> proporciona un <correo registrado>
    Cuando solicita la <recuperación de contraseña>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de envío de instrucciones>

    Examples: Datos de entrada
      | usuario | correo registrado       | sistema |
      | App     | user@instalert.com      | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de envío de instrucciones |
      | 200                  | Correo enviado                    |

  Scenario Outline: Escenario 2 - Correo no registrado
    Dado que el <usuario> proporciona un <correo no registrado>
    Cuando solicita la <recuperación de contraseña>
    Entonces el <sistema> retorna el <código de estado 404> y un <mensaje de usuario no encontrado>

    Examples: Datos de entrada
      | usuario | correo no registrado     | sistema |
      | App     | desconocido@dominio.com  | API     |

    Examples: Datos de salida
      | código de estado 404 | mensaje de usuario no encontrado |
      | 404                  | Usuario no encontrado            |

# ============================================
# HU-50 - Preferencias de notificaciones del usuario
# ============================================
Feature: Preferencias de notificaciones del usuario
  Como usuario,
  quiero configurar mis preferencias de notificación,
  para recibir solo alertas relevantes.

  Scenario Outline: Escenario 1 - Actualización de preferencias exitosa
    Dado que el <usuario> está autenticado
    Cuando envía una <petición PATCH> al <endpoint de preferencias> con <preferencias válidas>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje de preferencias actualizadas>

    Examples: Datos de entrada
      | usuario | petición PATCH | endpoint de preferencias | preferencias válidas         | sistema |
      | App     | PATCH          | /api/usuarios/me/prefs   | {"zonas":["Centro"],"tipo":["robo"]} | API     |

    Examples: Datos de salida
      | código de estado 200 | mensaje de preferencias actualizadas |
      | 200                  | Preferencias actualizadas            |

  Scenario Outline: Escenario 2 - Formato de preferencias inválido
    Dado que el <usuario> está autenticado
    Cuando envía una <petición PATCH> al <endpoint de preferencias> con <preferencias inválidas>
    Entonces el <sistema> retorna el <código de estado 400> y un <mensaje de validación de preferencias>

    Examples: Datos de entrada
      | usuario | petición PATCH | endpoint de preferencias | preferencias inválidas | sistema |
      | App     | PATCH          | /api/usuarios/me/prefs   | {"zonas":"Centro"}     | API     |

    Examples: Datos de salida
      | código de estado 400 | mensaje de validación de preferencias |
      | 400                  | Estructura inválida                   |

# ============================================
# HU-51 - Inicio de sesión
# ============================================
Feature: Inicio de sesión
  Como ciudadano registrado de InstAlert,
  quiero iniciar sesión con mi usuario/correo y contraseña,
  para acceder a la pantalla principal y utilizar las funcionalidades de seguridad.

  Scenario Outline: Escenario 1 - Inicio de sesión exitoso
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de Login> y ha completado los campos <usuario/correo> y <contraseña> con <credenciales válidas>
    Cuando el <usuario ciudadano> presiona el <botón Ingresar>
    Entonces el <sistema> redirige a la <pantalla principal Home>, muestra el <saludo con nombre> y se visualizan el <mapa> y la <barra de navegación inferior>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de Login | usuario/correo      | contraseña  | credenciales válidas | botón Ingresar | sistema | pantalla principal Home | saludo con nombre | mapa | barra de navegación inferior |
      | Ciudadano         | Login             | user@instalert.com  | **********  | sí                   | Ingresar       | App     | Home                    | Hola, Juan        | ver  | ver                           |

    Examples: Datos de salida
      | redirección | saludo con nombre | componentes visibles                   |
      | Home        | Hola, Juan        | mapa y barra de navegación inferior   |


  Scenario Outline: Escenario 2 - Validación por campos vacíos
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de Login> y ha dejado vacío al menos uno de los campos requeridos <usuario/correo> o <contraseña>
    Cuando el <usuario ciudadano> presiona el <botón Ingresar>
    Entonces el <sistema> permanece en la <pantalla de Login>, muestra el <mensaje de validación de campo requerido> en los <campos vacíos> y no permite el acceso a la <pantalla principal Home>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de Login | usuario/correo | contraseña | botón Ingresar | sistema | campos vacíos |
      | Ciudadano         | Login             |                | ********** | Ingresar       | App     | usuario/correo |
      | Ciudadano         | Login             | user@mail.com  |            | Ingresar       | App     | contraseña     |

    Examples: Datos de salida
      | permanece en | mensaje de validación de campo requerido   |
      | Login        | Campo requerido                            |


  Scenario Outline: Escenario 3 - Credenciales incorrectas
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de Login> y ha ingresado <usuario/correo> y/o <contraseña> que no coinciden con una cuenta válida
    Cuando el <usuario ciudadano> presiona el <botón Ingresar>
    Entonces el <sistema> permanece en la <pantalla de Login>, muestra el <mensaje de credenciales incorrectas> y no redirige a la <pantalla principal Home>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de Login | usuario/correo      | contraseña | botón Ingresar | sistema |
      | Ciudadano         | Login             | user@instalert.com  | 123456     | Ingresar       | App     |

    Examples: Datos de salida
      | permanece en | mensaje de credenciales incorrectas         |
      | Login        | Usuario o contraseña incorrectos            |


  Scenario Outline: Escenario 4 - Reintento tras error de credenciales
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de Login> después de ver el <mensaje de credenciales incorrectas> y ha corregido los campos con <credenciales válidas>
    Cuando el <usuario ciudadano> presiona nuevamente el <botón Ingresar>
    Entonces el <sistema> elimina el <mensaje de credenciales incorrectas>, inicia sesión correctamente y redirige a la <pantalla principal Home> con el <saludo con nombre> y los <componentes cargados>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de Login | credenciales válidas | botón Ingresar | sistema | saludo con nombre | componentes cargados    |
      | Ciudadano         | Login             | sí                   | Ingresar       | App     | Hola, Juan        | mapa y barra inferior  |

    Examples: Datos de salida
      | redirección | estado de mensaje                     |
      | Home        | mensaje de error eliminado            |


# ============================================
# HU-52 - Cambiar contraseña por olvido (flujo con verificación por código)
# ============================================
Feature: Cambiar contraseña por olvido de esta
  Como ciudadano registrado de InstAlert,
  quiero recuperar el acceso cambiando mi contraseña mediante verificación por código,
  para poder iniciar sesión nuevamente de forma segura.

  Scenario Outline: Escenario 1 - Navegación al flujo de recuperación
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de Login>
    Cuando el <usuario ciudadano> selecciona la <opción Olvidaste tu contraseña?>
    Entonces el <sistema> muestra la <pantalla Olvidaste tu contraseña> con el <campo Correo electrónico> y el <botón Siguiente>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de Login | opción Olvidaste tu contraseña? | sistema |
      | Ciudadano         | Login             | sí                              | App     |

    Examples: Datos de salida
      | pantalla mostrada                 | campo visible         | botón visible |
      | Olvidaste tu contraseña           | Correo electrónico    | Siguiente     |


  Scenario Outline: Escenario 2 - Correo registrado → envío de código
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Olvidaste tu contraseña> y ha ingresado un <correo registrado>
    Cuando el <usuario ciudadano> presiona <Siguiente>
    Entonces el <sistema> informa que se envió un <código de verificación> al <correo registrado> y muestra la <pantalla de ingresar código>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Olvidaste tu contraseña | correo registrado       | sistema |
      | Ciudadano         | Olvidaste tu contraseña          | user@instalert.com      | App     |

    Examples: Datos de salida
      | notificación                         | pantalla mostrada         |
      | Código enviado al correo registrado  | Ingresar código           |


  Scenario Outline: Escenario 3 - Correo no registrado
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Olvidaste tu contraseña> y ha ingresado un <correo no registrado>
    Cuando el <usuario ciudadano> presiona <Siguiente>
    Entonces el <sistema> permanece en la <pantalla Olvidaste tu contraseña>, muestra el <mensaje de correo no registrado> y no envía código

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Olvidaste tu contraseña | correo no registrado     | sistema |
      | Ciudadano         | Olvidaste tu contraseña          | sin-correo@dominio.com   | App     |

    Examples: Datos de salida
      | permanece en                 | mensaje de correo no registrado |
      | Olvidaste tu contraseña      | El correo no está registrado    |


  Scenario Outline: Escenario 4 - Código correcto
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de verificación de código> y ha ingresado un <código válido> dentro del <tiempo permitido>
    Cuando el <usuario ciudadano> presiona <Siguiente>
    Entonces el <sistema> muestra la <pantalla Nueva contraseña> con los campos <Nueva contraseña> y <Confirmar contraseña>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de verificación de código | código válido | tiempo permitido | sistema |
      | Ciudadano         | Verificación de código             | 123456        | sí               | App     |

    Examples: Datos de salida
      | pantalla mostrada  | campos visibles                              |
      | Nueva contraseña   | Nueva contraseña y Confirmar contraseña      |


  Scenario Outline: Escenario 5 - Código incorrecto o expirado
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de verificación de código> y ha ingresado un <código inválido o expirado>
    Cuando el <usuario ciudadano> presiona <Siguiente>
    Entonces el <sistema> permanece en la <pantalla de verificación de código>, muestra el <mensaje Código incorrecto o vencido> y mantiene disponible la <opción Reenviar código>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de verificación de código | código inválido o expirado | sistema |
      | Ciudadano         | Verificación de código             | 000000                      | App     |

    Examples: Datos de salida
      | permanece en           | mensaje mostrado                 | opción disponible  |
      | Verificación de código | Código incorrecto o vencido      | Reenviar código    |


  Scenario Outline: Escenario 6 - Reenvío de código
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de verificación de código> y no puede usar el <código anterior>
    Cuando el <usuario ciudadano> selecciona <Reenviar código>
    Entonces el <sistema> envía un <nuevo código> al <correo registrado> y muestra la <notificación de código reenviado>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de verificación de código | código anterior | sistema |
      | Ciudadano         | Verificación de código             | inválido        | App     |

    Examples: Datos de salida
      | envío | notificación de código reenviado |
      | sí    | Código reenviado                 |


  Scenario Outline: Escenario 7 - Contraseña válida y confirmación coincidente
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Nueva contraseña> y ha ingresado una <nueva contraseña válida> y una <confirmación coincidente>
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> actualiza la <contraseña>, muestra la <pantalla Contraseña cambiada correctamente> con el <botón OK> y habilita el <inicio de sesión con nueva credencial>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Nueva contraseña | nueva contraseña válida | confirmación coincidente | sistema |
      | Ciudadano         | Nueva contraseña          | S3gura!2025             | S3gura!2025              | App     |

    Examples: Datos de salida
      | estado de actualización | pantalla mostrada                 | acción habilitada                     |
      | contraseña actualizada  | Contraseña cambiada correctamente | inicio de sesión con nueva credencial |


  Scenario Outline: Escenario 8 - Contraseña no cumple reglas
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Nueva contraseña> y ha ingresado una <nueva contraseña inválida> que no cumple las reglas de seguridad
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> permanece en la <pantalla Nueva contraseña> y muestra los <mensajes de validación de reglas>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Nueva contraseña | nueva contraseña inválida | sistema |
      | Ciudadano         | Nueva contraseña          | 123456                    | App     |

    Examples: Datos de salida
      | permanece en        | mensajes de validación de reglas  |
      | Nueva contraseña    | Criterios no cumplidos            |


  Scenario Outline: Escenario 9 - Confirmación de contraseña no coincide
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Nueva contraseña> y ha ingresado una <nueva contraseña> y una <confirmación que no coincide>
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> permanece en la <pantalla Nueva contraseña> y muestra el <mensaje Las contraseñas no coinciden>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Nueva contraseña | nueva contraseña | confirmación que no coincide | sistema |
      | Ciudadano         | Nueva contraseña          | S3gura!2025      | S3gura!2024                  | App     |

    Examples: Datos de salida
      | permanece en        | mensaje Las contraseñas no coinciden |
      | Nueva contraseña    | Las contraseñas no coinciden         |


# ============================================
# HU-53 - Creación de nueva cuenta
# ============================================
Feature: Creación de nueva cuenta
  Como ciudadano nuevo de InstAlert,
  quiero registrarme completando el formulario o usando Google/Facebook,
  para poder acceder a la aplicación y utilizar sus funcionalidades de seguridad.

  Scenario Outline: Escenario 1 - Navegación al registro
    Dado que el <usuario ciudadano> se encuentra en la <pantalla de Login>
    Cuando el <usuario ciudadano> selecciona <Crear cuenta>
    Entonces el <sistema> muestra la <pantalla Crear Cuenta> con los <campos del formulario> y los <botones de proveedores>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla de Login | Crear cuenta | sistema |
      | Ciudadano         | Login             | sí           | App     |

    Examples: Datos de salida
      | pantalla mostrada | campos del formulario                                  | botones de proveedores            |
      | Crear Cuenta      | Correo, Usuario, Contraseña, Repetir contraseña        | Confirmar, Google, Facebook      |


  Scenario Outline: Escenario 2 - Registro exitoso con formulario
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Crear Cuenta> y ha completado <correo no registrado>, <usuario>, <contraseña> y <repetir contraseña coincidente>
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> crea la <cuenta>, muestra <Cuenta creada exitosamente> con <botón OK> y redirige a la <pantalla de Login> lista para autenticación

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Crear Cuenta | correo no registrado   | usuario  | contraseña  | repetir contraseña coincidente | sistema |
      | Ciudadano         | Crear Cuenta          | nuevo@instalert.com    | juan2025 | S3gura!2025 | S3gura!2025                    | App     |

    Examples: Datos de salida
      | estado de creación | mensaje mostrado             | redirección |
      | cuenta creada      | Cuenta creada exitosamente   | Login       |


  Scenario Outline: Escenario 3 - Correo ya registrado
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Crear Cuenta> y ha ingresado un <correo ya registrado>
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> permanece en la <pantalla de registro> y muestra el <mensaje Este correo ya está en uso>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Crear Cuenta | correo ya registrado     | sistema |
      | Ciudadano         | Crear Cuenta          | existente@instalert.com  | App     |

    Examples: Datos de salida
      | permanece en          | mensaje Este correo ya está en uso |
      | pantalla de registro  | Este correo ya está en uso         |


  Scenario Outline: Escenario 4 - Campos obligatorios vacíos
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Crear Cuenta> y ha dejado vacío al menos uno de los <campos requeridos>
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> permanece en la <pantalla de registro> y muestra los <mensajes de validación en campos faltantes>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Crear Cuenta | campos requeridos | sistema |
      | Ciudadano         | Crear Cuenta          | alguno vacío       | App     |

    Examples: Datos de salida
      | permanece en          | mensajes de validación en campos faltantes |
      | pantalla de registro  | Mostrar en campos faltantes                |


  Scenario Outline: Escenario 5 - Confirmación de contraseña no coincide
    Dado que el <usuario ciudadano> se encuentra en la <pantalla Crear Cuenta> y ha ingresado <contraseña> y <repetir contraseña> que no coinciden
    Cuando el <usuario ciudadano> presiona <Confirmar>
    Entonces el <sistema> permanece en la <pantalla de registro> y muestra el <mensaje Las contraseñas no coinciden>

    Examples: Datos de entrada
      | usuario ciudadano | pantalla Crear Cuenta | contraseña  | repetir contraseña | sistema |
      | Ciudadano         | Crear Cuenta          | S3gura!2025 | S3gura!2024        | App     |

    Examples: Datos de salida
      | permanece en          | mensaje Las contraseñas no coinciden |
      | pantalla de registro  | Las contraseñas no coinciden         |
