# Epic: EP-04C
# Feature derived from user-provided acceptance criteria.
Feature: HU-17C - Creación de publicaciones de incidentes
  Como comerciante, quiero poder crear publicaciones detalladas de incidentes con texto, ubicación e imágenes,
  para alertar a mis vecinos de manera clara y oportuna.

  Scenario: Creación de publicación básica
    Given que el comerciante completa el formulario de publicación con texto
    When el comerciante presiona <Publicar>
    Then el sistema publica la entrada en el foro comunitario
  Examples:
    | Texto |
    | <Robo cerca del mercado> |

  Scenario: Adjuntar imágenes
    Given que el comerciante agrega una o varias imágenes a la publicación
    When el comerciante la publica
    Then el sistema muestra las imágenes junto con la descripción del incidente
  Examples:
    | Cantidad | Archivos |
    | <2> | <foto1.jpg; foto2.jpg> |

  Scenario: Ubicación automática
    Given que el comerciante activó la geolocalización
    When el comerciante publica la publicación
    Then el sistema añade la ubicación del incidente automáticamente
  Examples:
    | Geolocalización | Coordenadas detectadas |
    | <Activada> | <-12.0567, -77.0842> |

  Scenario: Validación de campos obligatorios
    Given que el comerciante intenta publicar una publicación incompleta
    When el comerciante presiona el botón <Publicar>
    Then el sistema muestra un mensaje de error solicitando completar los campos obligatorios
  Examples:
    | Campos faltantes | Mensaje esperado |
    | <Texto> | <Completa los campos obligatorios antes de publicar> |

# Epic: EP-04C
Feature: HU-18C - Comentarios comunitarios en publicaciones
  Como residente, quiero comentar en las publicaciones de otros usuarios, para aportar información adicional y confirmar la veracidad de un incidente.

  Scenario: Publicación de comentario
    Given que el residente escribe un comentario en una publicación
    When el residente presiona <Publicar>
    Then el sistema coloca el comentario debajo de la publicación en el foro
  Examples:
    | Publicación ID | Comentario |
    | <1023> | <Gracias por el aviso> |

  Scenario: Comentarios encadenados
    Given que el residente responde a un comentario existente
    When el residente publica su respuesta
    Then el sistema la muestra como respuesta dentro del hilo correspondiente
  Examples:
    | Comentario padre ID | Respuesta |
    | <5501> | <¿A qué hora ocurrió?> |

  Scenario: Eliminación de comentario propio
    Given que el residente desea borrar su comentario
    When el residente selecciona la opción Eliminar
    Then el sistema retira el comentario de la publicación
  Examples:
    | Comentario ID |
    | <7788> |

  Scenario: Reporte de comentario inapropiado
    Given que el residente detecta un comentario ofensivo
    When el residente selecciona <Reportar comentario>
    Then el sistema lo envía a revisión por moderación
  Examples:
    | Comentario ID | Motivo |
    | <8812> | <Lenguaje odioso> |

# Epic: EP-04C
Feature: HU-19C - Sistema de votos o reacciones en publicaciones
  Como ciudadano, quiero calificar la relevancia o urgencia de las publicaciones, para que la comunidad identifique rápidamente los incidentes más críticos.

  Scenario: Votar relevancia de una publicación
    Given que el ciudadano visualiza una publicación en el foro
    When el ciudadano selecciona la opción con un ícono de pulgar arriba
    Then el sistema registra su voto y actualiza el contador de relevancia
  Examples:
    | Publicación ID |
    | <3050> |

  Scenario: Quitar o cambiar voto
    Given que el ciudadano ya votó un reporte
    When el ciudadano decide cambiar su calificación y selecciona otra opción
    Then el sistema actualiza el voto reflejando la nueva selección
  Examples:
    | Publicación ID | Voto anterior | Nuevo voto |
    | <3050> | <👍> | <⚠️> |

  Scenario: Visualización de votos
    Given que el ciudadano revisa un reporte
    When el ciudadano abre el reporte
    Then el sistema muestra el número total de votos recibidos
  Examples:
    | Publicación ID | Total esperado |
    | <3050> | <15> |

  Scenario: Ordenar por relevancia
    Given que el ciudadano desea priorizar reportes críticos
    When el ciudadano acciona el botón para ordenar reportes por relevancia
    Then el sistema muestra primero los más votados
  Examples:
    | Criterio |
    | <Relevancia desc> |

# Epic: EP-04C
Feature: HU-20C - Moderación y verificación de contenido
  Como miembro de la comunidad, quiero que la aplicación filtre o marque reportes sospechosos, para evitar desinformación y mantener la confiabilidad de la plataforma.

  Scenario: Detección automática de contenido inapropiado
    Given que un miembro de la comunidad intenta publicar un reporte con lenguaje ofensivo
    When el miembro presiona <Enviar reporte>
    Then el sistema bloquea la publicación y muestra un mensaje de advertencia
  Examples:
    | Contenido | Mensaje esperado |
    | <¡Eres un ****!> | <Lenguaje ofensivo detectado> |

  Scenario: Marcado de reportes sospechosos por usuarios
    Given que un miembro de la comunidad detecta un reporte falso
    When el miembro lo marca como sospechoso
    Then el sistema clasifica el reporte como pendiente de verificación
  Examples:
    | Reporte ID | Motivo |
    | <4201> | <Información dudosa> |

  Scenario: Etiqueta de confiabilidad
    Given que un reporte fue verificado por moderación o alcanzó el umbral de validaciones positivas
    When un miembro de la comunidad abre el reporte en el foro
    Then el sistema lo muestra con una etiqueta de <verificado> para garantizar confianza
  Examples:
    | Reporte ID | Estado de verificación |
    | <4201> | <Verificado> |

  Scenario: Notificación al creador del reporte
    Given que un reporte fue eliminado por desinformación
    When el creador abre la aplicación
    Then el sistema muestra una notificación explicando el motivo de la eliminación
  Examples:
    | Reporte ID | Motivo |
    | <4202> | <Desinformación confirmada por moderación> |

# Epic: EP-05S
Feature: HU-21S - Encriptación de datos personales
  Como ciudadano, quiero que mis datos estén encriptados, para que nadie no autorizado pueda acceder a mi información personal.

  Scenario: Almacenamiento seguro
    Given que el usuario ingresa sus datos en la aplicación
    When el usuario confirma guardar su información
    Then el sistema almacena los datos en formato encriptado
  Examples:
    | Datos |
    | <DNI: 12345678> |

  Scenario: Bloqueo de acceso no autorizado
    Given que un tercero intenta acceder a información protegida
    When el tercero intenta ingresar sin credenciales válidas
    Then el sistema dispara un error de acceso y no puede visualizar los datos
  Examples:
    | Intento | Resultado esperado |
    | <Sin sesión> | <Acceso denegado> |

  Scenario: Transmisión protegida
    Given que el usuario envía información a través de la aplicación
    When el usuario confirma el envío de sus datos
    Then el sistema transmite la información bajo protocolo HTTPS/TLS
  Examples:
    | Endpoint |
    | </api/usuarios/perfil> |

  Scenario: Desencriptado controlado
    Given que el sistema necesita usar datos encriptados
    When un usuario autorizado solicita acceso a dichos datos
    Then el sistema se desencripta temporalmente y solo los usuarios autorizados pueden verlos
  Examples:
    | Rol | Acción permitida |
    | <Administrador> | <Lectura temporal> |

# Epic: EP-05S
Feature: HU-22S - Control de permisos de ubicación
  Como usuario, quiero decidir cuándo la app puede acceder a mi ubicación, para sentirme seguro sobre cómo se usa mi información.

  Scenario: Activar o desactivar ubicación
    Given que el usuario abre la aplicación y tiene acceso a la configuración
    When el usuario navega a Configuración > Privacidad y activa o desactiva el acceso a ubicación
    Then la aplicación guarda el ajuste y respeta la preferencia seleccionada
  Examples:
    | Preferencia |
    | <Activado> |
    | <Desactivado> |

  Scenario: Solicitud de permiso
    Given que el usuario tiene el permiso de ubicación desactivado
    When el usuario intenta usar una función que requiere ubicación (p. ej., mapa o navegación)
    Then la aplicación muestra un aviso solicitando permiso de acceso a ubicación
  Examples:
    | Función requerida |
    | <Mapa> |
    | <Trayecto seguro> |

  Scenario: Registro de uso
    Given que la app accede a la ubicación para una función solicitada
    When el usuario inicia una acción que requiere la ubicación
    Then la aplicación registra el momento y el motivo del acceso en el log de seguridad
  Examples:
    | Motivo |
    | <Navegación paso a paso> |

  Scenario: Uso limitado en segundo plano
    Given que la aplicación funciona en segundo plano y el usuario habilitó el permiso de ubicación en segundo plano
    When el usuario mantiene la app en segundo plano y esta necesita ubicación para una función activa (p. ej., trayecto seguro)
    Then la app accede solo si el permiso correspondiente está otorgado
  Examples:
    | Permiso en segundo plano | Resultado esperado |
    | <Concedido> | <Accede> |
    | <Denegado> | <No accede> |

# Epic: EP-05S
Feature: HU-23S - Políticas de privacidad claras
  Como ciudadano, quiero ver un resumen claro de cómo se usan mis datos, para decidir si acepto usar la aplicación.

  Scenario: Resumen visible en registro
    Given que el usuario se registra por primera vez
    When el usuario avanza al paso de aceptación de términos y políticas
    Then el sistema genera un resumen claro de políticas de privacidad
  Examples:
    | Paso |
    | <Aceptación> |

  Scenario: Restricción de acceso
    Given que el usuario no acepta las políticas
    When el usuario intenta continuar el registro sin aceptar
    Then el sistema no le permite finalizar su registro
  Examples:
    | Acepta políticas | Resultado esperado |
    | <No> | <Bloquea el registro> |

  Scenario: Acceso posterior
    Given que el usuario ya está registrado
    When el usuario abre el menú de Configuración y selecciona Políticas de privacidad
    Then el sistema muestra los detalles de las políticas en cualquier momento
  Examples:
    | Punto de acceso |
    | <Configuración > Políticas de privacidad> |

  Scenario: Notificación de cambios
    Given que las políticas han cambiado
    When el usuario recibe el aviso de actualización al abrir la aplicación
    Then el sistema exigirá aceptarlas nuevamente para continuar usando la app
  Examples:
    | Versión anterior | Versión nueva |
    | <1.2> | <1.3> |
