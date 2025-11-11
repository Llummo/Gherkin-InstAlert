# ============================================
# HU31 - Edición de publicaciones de incidentes
# ============================================

Feature: Edición de publicaciones de incidentes
Como comerciante/residente
Quiero editar el título, la descripción, las imágenes y la ubicación de una publicación
Para corregir o ampliar la información del incidente

Scenario Outline: Escenario 1 - Edición básica desde Detalle de publicación
    Dado que el <usuario> es el autor de la <publicación>
    Y se encuentra en la pantalla “<pantalla_editar>”
    Cuando modifica uno o más <campos> y presiona “<botón_guardar>”
    Entonces el <sistema> muestra la <publicación_actualizada>
    Y añade la etiqueta “<editado>” con fecha/hora
    Y mantiene la <url_original>

    Examples: Datos de entrada
      | usuario              | publicación | pantalla_editar     | campos             | botón_guardar |
      | Comerciante/Residente | Incidente A | Editar publicación  | título y descripción | Guardar cambios |

    Examples: Datos de salida
      | sistema | publicación_actualizada | editado | url_original |
      | App Web | Publicación actualizada | Editado con hora | Conservada |

Scenario Outline: Escenario 2 - Historial de ediciones disponible
    Dado que existen <ediciones_previas> de la <publicación>
    Y el <usuario> está en la pantalla “<detalle_publicación>”
    Cuando selecciona “<ver_historial>”
    Entonces el <sistema> muestra una <lista_cronológica> con fecha/hora y resumen de cambios
    Y esta lista es visible para el <autor_y_moderación>

    Examples: Datos de entrada
      | usuario              | publicación | ediciones_previas | detalle_publicación | ver_historial |
      | Comerciante/Residente | Incidente A | Sí                | Detalle de publicación | Ver historial |

    Examples: Datos de salida
      | sistema | lista_cronológica | autor_y_moderación |
      | App Web | Lista de versiones previas | Visible |

Scenario Outline: Escenario 3 - Restricción por verificación o bloqueo
    Dado que la <publicación> está en estado “<estado_publicación>”
    Y el <usuario> intenta abrir el modo de edición desde “<mis_publicaciones>”
    Cuando presiona “<botón_editar>”
    Entonces el <sistema> impide la edición
    Y muestra el mensaje “<mensaje_restricción>”

    Examples: Datos de entrada
      | usuario              | publicación | estado_publicación | mis_publicaciones | botón_editar |
      | Comerciante/Residente | Incidente A | Verificada          | Mis publicaciones | Editar |

    Examples: Datos de salida
      | sistema | mensaje_restricción |
      | App Web | No se puede editar mientras esté verificada/bloqueada |

Scenario Outline: Escenario 4 - Edición sin conexión
    Dado que el <dispositivo> no cuenta con <conexión>
    Y el <usuario> se encuentra en el modo de edición de la <publicación>
    Cuando presiona “<botón_guardar>”
    Entonces el <sistema> guarda la edición como “<pendiente_sinc>”
    Y muestra el estado hasta que se recupere la <conexión>

    Examples: Datos de entrada
      | usuario              | dispositivo | publicación | conexión | botón_guardar |
      | Comerciante/Residente | Teléfono móvil | Incidente A | Sin conexión | Guardar cambios |

    Examples: Datos de salida
      | sistema | pendiente_sinc | conexión |
      | App Web | Pendiente de sincronización | Se actualiza al reconectarse |


# ============================================
# HU32 - Eliminación de publicaciones
# ============================================

Feature: Eliminación de publicaciones
Como comerciante/residente
Quiero eliminar mis publicaciones y poder restaurarlas en un lapso de 48 horas
Para mantener control sobre mi contenido

Scenario Outline: Escenario 1 - Eliminación definitiva
    Dado que el <usuario> está en la pantalla de “<mis_publicaciones>”
    Y desea borrar una <publicación>
    Cuando presiona el <botón_eliminar> y confirma la <acción_eliminar>
    Entonces el <sistema> elimina la publicación de forma irreversible
    Y deja de mostrarla en listados y búsquedas en <tiempo_eliminación>

    Examples: Datos de entrada
      | usuario              | mis_publicaciones | publicación | botón_eliminar | acción_eliminar |
      | Comerciante/Residente | Mis publicaciones | Incidente A | Tacho de basura | Confirmar eliminación |

    Examples: Datos de salida
      | sistema | tiempo_eliminación |
      | App Web | 2 días |

Scenario Outline: Escenario 2 - Cancelar eliminación durante el periodo de retención
    Dado que la <publicación> fue eliminada y no han pasado más de <tiempo_retenido>
    Y el <usuario> abre “<mis_publicaciones>”
    Cuando presiona “<cancelar_eliminación>” sobre una <publicación>
    Entonces el <sistema> revierte el estado
    Y la <publicación> vuelve a estar disponible en el <foro>

    Examples: Datos de entrada
      | usuario              | publicación | tiempo_retenido | mis_publicaciones | cancelar_eliminación |
      | Comerciante/Residente | Incidente A | 48 horas | Mis publicaciones | Cancelar eliminación |

    Examples: Datos de salida
      | sistema | foro |
      | App Web | Publicación restaurada |


# ============================================
# HU33 - Visualizar los planes de suscripción
# ============================================

Feature: Visualización de planes de suscripción
  Como visitante interesado en contratar el servicio,
  quiero ver los planes disponibles,
  para comparar precios y beneficios antes de registrarme.

  Scenario Outline: Escenario 1 - Visualizar los planes disponibles en la sección de suscripciones
    Dado que el <usuario> se encuentra en la <Landing Page de Guardian+>
    Y se <desplaza hacia la sección “Planes de Suscripción”>
    Cuando el <sistema> carga correctamente la <información de los planes>
    Entonces se muestran los <planes disponibles> con sus respectivos <nombres>, <precios> y <beneficios>

    Examples: Datos de entrada
      | usuario  | acción realizada                 | sección                 |
      | Visitante | Desplazarse hacia abajo          | Planes de Suscripción   |

    Examples: Datos de salida
      | planes disponibles | nombres                  | precios           | beneficios                                         |
      | 2                  | Plan Básico, Plan Premium | S/.15, S/.25      | Monitoreo básico, alertas inteligentes, reportes detallados |

  Scenario Outline: Escenario 2 - Comparar los planes de suscripción
    Dado que el <usuario> se encuentra en la <sección “Planes de Suscripción”>
    Y visualiza al menos <dos planes disponibles>
    Cuando el <usuario> da <clic al botón “Comparar planes”>
    Entonces el <sistema> muestra una <tabla comparativa> con los <detalles de cada plan>

    Examples: Datos de entrada
      | usuario  | acción realizada             |
      | Visitante | Clic en “Comparar planes”   |

    Examples: Datos de salida
      | tabla comparativa         | detalles                         |
      | Plan Básico vs Premium    | Monitoreo, Alertas, Reportes, Precio |

  Scenario Outline: Escenario 3 - Seleccionar un plan para contratar el servicio
    Dado que el <usuario> se encuentra en la <sección “Planes de Suscripción”>
    Y desea adquirir un <plan específico>
    Cuando el <usuario> da <clic en el botón “Contratar”> del plan elegido
    Entonces el <sistema> redirige al <formulario de registro o de pago>

    Examples: Datos de entrada
      | usuario  | acción realizada              |
      | Visitante | Clic en “Contratar Premium”  |

    Examples: Datos de salida
      | redirección | destino                       |
      | Sí           | Formulario de registro o pago |

  Scenario Outline: Escenario 4 - Actualización automática de precios y beneficios
    Dado que el <usuario> se encuentra en la <sección “Planes de Suscripción”>
    Y el <sistema> cuenta con una <versión actualizada de los planes>
    Cuando el <usuario> <recarga la página> o <accede nuevamente>
    Entonces el <sistema> muestra los <precios y beneficios actualizados>

    Examples: Datos de entrada
      | usuario  | acción realizada              |
      | Visitante | Recargar la página de planes |

    Examples: Datos de salida
      | precios actualizados               | beneficios actualizados          |
      | Plan Básico: S/.17, Plan Premium: S/.27 | Monitoreo y alertas mejorados   |


# ============================================
# HU34 - Obtener datos de incidentes mediante la API RESTful
# ============================================

Feature: Obtener datos de incidentes mediante la API RESTful
  Como desarrollador,
  quiero que la API RESTful devuelva la lista de incidentes registrados,
  para integrarlos correctamente en la aplicación móvil y mostrar datos en tiempo real.

  Scenario Outline: Escenario 1 - Solicitar la lista completa de incidentes
    Dado que el <desarrollador> tiene acceso al <endpoint “/api/incidentes”>
    Y el <servidor> se encuentra en funcionamiento
    Cuando el <desarrollador> realiza una <petición GET sin parámetros>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista JSON con los incidentes registrados>

    Examples: Datos de entrada
      | método | endpoint         |
      | GET    | /api/incidentes  |

    Examples: Datos de salida
      | código de estado | lista JSON                                           |
      | 200              | [{"id":1,"zona":"Sur","fecha":"2025-11-05","tipo":"Caída"}] |

  Scenario Outline: Escenario 2 - Filtrar incidentes por zona geográfica
    Dado que el <desarrollador> tiene acceso al <endpoint “/api/incidentes”>
    Y existen <incidentes registrados en distintas zonas>
    Cuando el <desarrollador> realiza una <petición GET con el parámetro “zona=Sur”>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista JSON filtrada>

    Examples: Datos de entrada
      | método | endpoint                  |
      | GET    | /api/incidentes?zona=Sur  |

    Examples: Datos de salida
      | código de estado | lista JSON filtrada                          |
      | 200              | [{"id":1,"zona":"Sur","tipo":"Caída"}]      |

  Scenario Outline: Escenario 3 - Acceso con token inválido o sin autenticación
    Dado que el <desarrollador> no proporciona un <token válido>
    Cuando realiza una <petición GET al endpoint “/api/incidentes”>
    Entonces el <sistema> retorna el <código de estado 401> y un <mensaje de error de autenticación>

    Examples: Datos de entrada
      | método | endpoint         | token              |
      | GET    | /api/incidentes  | token_invalido_123 |

    Examples: Datos de salida
      | código de estado | mensaje                   |
      | 401              | "Autenticación requerida"  |

  Scenario Outline: Escenario 4 - Error del servidor al procesar la solicitud
    Dado que la <base de datos o el servidor> no están disponibles
    Cuando el <desarrollador> realiza una <petición GET al endpoint “/api/incidentes”>
    Entonces el <sistema> retorna el <código de estado 500> y un <mensaje de error interno>

    Examples: Datos de entrada
      | método | endpoint         |
      | GET    | /api/incidentes  |

    Examples: Datos de salida
      | código de estado | mensaje                    |
      | 500              | "Error interno del servidor" |


# ============================================
# HU-35 - Obtener datos de incidentes del módulo técnico
# ============================================

Feature: Obtener datos de incidentes del módulo técnico
  Como desarrollador del sistema,
  quiero obtener los datos de incidentes registrados mediante el endpoint técnico,
  para integrarlos correctamente con los módulos de monitoreo y análisis del sistema Guardian+.

  Scenario Outline: Escenario 1 - Obtener la lista de incidentes registrados desde el módulo técnico
    Dado que el <desarrollador> cuenta con conexión al <servidor> y la <base de datos> está operativa
    Cuando realiza una <solicitud GET al endpoint> correspondiente
    Entonces el <sistema> retorna el <código de estado> y una <lista JSON> con los incidentes técnicos registrados

    Examples: Datos de entrada
      | desarrollador | servidor | base de datos | método | endpoint |
      | Técnico API   | Activo   | Disponible    | GET    | /api/incidentes/tecnico |

    Examples: Datos de salida
      | código de estado | lista JSON |
      | 200 | [{"id":45,"zona":"Centro","tipo":"Caída","estado":"Resuelta"}] |

  Scenario Outline: Escenario 2 - Filtrar incidentes técnicos por tipo o estado
    Dado que el <desarrollador> tiene acceso al <endpoint técnico>
    Y existen incidentes con distintos <estados> en la base de datos
    Cuando realiza una <petición GET> con el parámetro <estado=Pendiente>
    Entonces el <sistema> retorna el <código de estado 200> y una <lista JSON filtrada> con los incidentes pendientes

    Examples: Datos de entrada
      | desarrollador | endpoint | parámetro |
      | Técnico API   | /api/incidentes/tecnico | estado=Pendiente |

    Examples: Datos de salida
      | código de estado | lista JSON filtrada |
      | 200 | [{"id":12,"zona":"Norte","tipo":"Caída","estado":"Pendiente"}] |

  Scenario Outline: Escenario 3 - Solicitud con token de autenticación inválido
    Dado que el <desarrollador> no posee un <token válido> o su sesión expiró
    Cuando realiza una <petición GET> al endpoint técnico
    Entonces el <sistema> retorna el <código de estado 401> y un <mensaje de error de autenticación>

    Examples: Datos de entrada
      | desarrollador | método | endpoint | token |
      | Técnico API   | GET    | /api/incidentes/tecnico | token_expirado_456 |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 401 | "Acceso no autorizado – Token inválido o expirado" |

  Scenario Outline: Escenario 4 - Error del servidor en la obtención de datos técnicos
    Dado que el <servidor técnico> o la <base de datos> no están disponibles
    Cuando el <desarrollador> realiza una <petición GET> al endpoint técnico
    Entonces el <sistema> retorna el <código de estado 500> y un <mensaje de error interno del servidor>

    Examples: Datos de entrada
      | desarrollador | método | endpoint |
      | Técnico API   | GET    | /api/incidentes/tecnico |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 500 | "Error interno del servidor – No se pudo obtener los incidentes" |

# ============================================
# HU-36 - Registrar un nuevo incidente en la API técnica
# ============================================

Feature: Registrar un nuevo incidente en la API técnica
  Como desarrollador del sistema,
  quiero registrar nuevos incidentes mediante la API RESTful,
  para que los datos se almacenen correctamente y estén disponibles para consulta y análisis posteriores.

  Scenario Outline: Escenario 1 - Registrar un incidente correctamente
    Dado que el <desarrollador> tiene acceso al <endpoint de registro>
    Y el <servidor> y la <base de datos> están disponibles
    Cuando realiza una <petición POST> con los <datos del nuevo incidente>
    Entonces el <sistema> retorna el <código de estado 201> y un <mensaje de confirmación de registro exitoso>

    Examples: Datos de entrada
      | desarrollador | método | endpoint | body |
      | Técnico API   | POST | /api/incidentes/registrar | {"zona":"Centro","tipo":"Falla eléctrica","descripcion":"Corte de energía en sensor"} |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 201 | "Incidente registrado exitosamente" |

  Scenario Outline: Escenario 2 - Envío de datos incompletos
    Dado que el <desarrollador> realiza una <petición POST> al endpoint de registro
    Cuando omite un <campo obligatorio> como <tipo> o <zona>
    Entonces el <sistema> retorna el <código de estado 400> y un <mensaje indicando los campos faltantes>

    Examples: Datos de entrada
      | desarrollador | método | endpoint | body |
      | Técnico API   | POST | /api/incidentes/registrar | {"tipo":"Falla eléctrica"} |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 400 | "Faltan campos obligatorios: zona" |

  Scenario Outline: Escenario 3 - Token inválido o sin autorización
    Dado que el <desarrollador> no proporciona un <token válido> en la cabecera de autorización
    Cuando realiza una <petición POST> al endpoint de registro
    Entonces el <sistema> retorna el <código de estado 401> y un <mensaje de error de autenticación>

    Examples: Datos de entrada
      | desarrollador | método | endpoint | token |
      | Técnico API   | POST | /api/incidentes/registrar | token_invalido_321 |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 401 | "Acceso no autorizado – Token inválido o expirado" |

  Scenario Outline: Escenario 4 - Error del servidor al intentar registrar el incidente
    Dado que la <base de datos> o el <servidor técnico> no están disponibles
    Cuando el <desarrollador> realiza una <petición POST> al endpoint de registro
    Entonces el <sistema> retorna el <código de estado 500> y un <mensaje de error interno del servidor>

    Examples: Datos de entrada
      | desarrollador | método | endpoint |
      | Técnico API   | POST | /api/incidentes/registrar |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 500 | "Error interno del servidor – No se pudo registrar el incidente" |

# ============================================
# HU-37 - Eliminar incidentes registrados en el sistema técnico
# ============================================

Feature: Eliminar incidentes registrados en el sistema técnico
  Como desarrollador del sistema,
  quiero eliminar incidentes que ya no sean relevantes o fueron resueltos,
  para mantener la base de datos actualizada y optimizar el almacenamiento del sistema Guardian+.

  Scenario Outline: Escenario 1 - Eliminar un incidente existente correctamente
    Dado que el <desarrollador> tiene acceso al <endpoint de eliminación> y el <ID> del incidente existe en la base de datos
    Cuando realiza una <petición DELETE> con un <ID válido>
    Entonces el <sistema> retorna el <código de estado 200> y un <mensaje confirmando la eliminación exitosa>

    Examples: Datos de entrada
      | desarrollador | método | endpoint |
      | Técnico API   | DELETE | /api/incidentes/eliminar/25 |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 200 | "Incidente eliminado correctamente" |

  Scenario Outline: Escenario 2 - Intentar eliminar un incidente inexistente
    Dado que el <desarrollador> tiene acceso al <endpoint de eliminación>
    Y el <ID> del incidente no existe en la base de datos
    Cuando realiza una <petición DELETE> con un <ID inexistente>
    Entonces el <sistema> retorna el <código de estado 404> y un <mensaje indicando que el incidente no fue encontrado>

    Examples: Datos de entrada
      | desarrollador | método | endpoint |
      | Técnico API   | DELETE | /api/incidentes/eliminar/99 |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 404 | "Incidente no encontrado" |

  Scenario Outline: Escenario 3 - Acceso denegado por token inválido o expirado
    Dado que el <desarrollador> no proporciona un <token válido> en la cabecera de autorización
    Cuando realiza una <petición DELETE> al endpoint de eliminación
    Entonces el <sistema> retorna el <código de estado 401> y un <mensaje de error de autenticación>

    Examples: Datos de entrada
      | desarrollador | método | endpoint | token |
      | Técnico API   | DELETE | /api/incidentes/eliminar/12 | token_expirado_999 |

    Examples: Datos de salida
      | código de estado | mensaje |
      | 401 | "Acceso no autorizado – Token inválido o expirado" |

  Scenario Outline: Escenario 4 - Error del servidor al intentar eliminar el incidente
    Dado que el <servidor técnico> o la <base de datos> no están disponibles
    Cuando el <desarrollador> realiza una <petición DELETE> al endpoint de eliminación
    Entonces el <sistema> retorna el <código de estado 500> y un <mensaje de error interno del servidor>

    Examples: Datos de entrada
      | desarrollador | método | endpoint |
      | Técnico API   | DELETE | /api/incidentes/eliminar/12 |

    Examples: Datos de salida
      | código de estado | mensaje |

      | 500 | "Error interno del servidor – No se pudo eliminar el incidente" |
