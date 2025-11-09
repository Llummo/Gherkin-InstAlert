//HU-01A
Feature: Activación del botón de pánico
  Como ciudadano o comerciante,
  quiero poder activar un mecanismo de alerta rápida desde la pulsera IoT,
  para que mis contactos de confianza reciban notificación inmediata de mi situación.

  Scenario Outline: Escenario 1 - Activación normal desde pulsera
    Dado que la <pulsera IoT> está vinculada al <ciudadano o comerciante residente de zona de riesgo medio-alto>,
    Y la <pulsera IoT> está funcional y con batería suficiente,
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> presiona el <botón de pánico> en la pulsera,
    Entonces el sistema envía la <alerta> a los <contactos de confianza> con la <ubicación actual> del ciudadano o comerciante residente de zona de riesgo medio-alto.

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | pulsera IoT               | botón de pánico | batería | conectividad | contactos de confianza |
      | Carlos Pérez                                                  | Pulsera vinculada y activa | Presiona botón  | 85%     | Conectado    | 3 contactos configurados |

    Examples: Datos de salida
      | alerta enviada                    | ubicación actual           | confirmación en app                     |
      | Sí, notificación a 3 contactos    | Latitud/Longitud visibles  | Mensaje "Alerta enviada correctamente"  |

  Scenario Outline: Escenario 2 - Activación sin conexión
    Dado que la <pulsera IoT> está vinculada pero no tiene <conectividad a internet>,
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> presiona el <botón de pánico>,
    Entonces el sistema deja pendiente la <alerta> y se enviará automáticamente cuando se restablezca la conexión,
    mostrando un mensaje “alerta pendiente” en la <pulsera> y en la <aplicación>.

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | pulsera IoT        | conectividad   | batería | acción                  |
      | María Torres                                                  | Pulsera vinculada  | Sin conexión   | 70%     | Presiona botón de pánico |

    Examples: Datos de salida
      | estado de alerta | mensaje en pantalla                     | acción posterior                          |
      | Pendiente        | “Alerta pendiente - sin conexión”        | Envío automático al recuperar conexión    |

  Scenario Outline: Escenario 3 - Activación accidental
    Dado que la <pulsera IoT> está vinculada al <ciudadano o comerciante residente de zona de riesgo medio-alto> y funcional,
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> presiona el botón por error y cancela la acción dentro de <5 segundos>,
    Entonces el sistema no envía la <alerta> y se registra como cancelada en la <aplicación>.

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | pulsera IoT    | tiempo de cancelación | acción          |
      | Juan Ramos                                                    | Pulsera activa | 3 segundos            | Cancela alerta  |

    Examples: Datos de salida
      | alerta enviada | registro en app                  | mensaje mostrado              |
      | No             | Estado: "Cancelada por usuario"  | “Alerta cancelada con éxito”  |

  Scenario Outline: Escenario 4 - Botón bloqueado temporalmente
    Dado que el <botón de la pulsera> ha sido bloqueado temporalmente por exceso de activaciones recientes,
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> intenta presionarlo,
    Entonces la alerta no se envía y la <pulsera> muestra un mensaje de bloqueo temporal.

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | activaciones previas | estado del botón      |
      | Ana Gutiérrez                                                 | 5 activaciones en 1 min | Bloqueado temporalmente |

    Examples: Datos de salida
      | alerta enviada | mensaje mostrado                                         |
      | No             | “Botón bloqueado temporalmente, espere unos minutos”     |

  Scenario Outline: Escenario 5 - Activación mediante atajos configurables
    Dado que la <pulsera IoT> permite configurar <atajos de emergencia>,
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> realiza la <combinación de botones asignada> como atajo de pánico,
    Entonces el sistema envía la <alerta> a los <contactos de confianza> y muestra la <ubicación en tiempo real>,
    respetando la configuración de <modo estándar o discreto>.

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | combinación de botones     | modo configurado | contactos de confianza |
      | Luis Salazar                                                  | Mantener 3s botón lateral  | Discreto         | 2 contactos configurados |

    Examples: Datos de salida
      | alerta enviada | modo de activicación                       | confirmación                 |
      | Sí             | Discreto (sin sonido ni luz visible)        | Mensaje “Alerta discreta enviada” |




//HU-02A
Feature: Notificación a contactos de confianza
  Como ciudadano o comerciante,
  quiero que mis contactos de confianza reciban alertas cuando active el botón de pánico,
  para que puedan comunicarse conmigo, avisar a autoridades o acudir en mi auxilio.

  Scenario Outline: Escenario 1 - Notificación enviada correctamente
    Dado que los <contactos de confianza> están registrados en la aplicación y tienen <conexión a internet>
    Y el <ciudadano o comerciante residente de zona de riesgo medio-alto> es residente de zona de riesgo medio-alto
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> activa el <botón de pánico>
    Entonces el sistema envía una <notificación> a los <contactos de confianza>
    Y la notificación incluye la <ubicación actual> del ciudadano o comerciante residente de zona de riesgo medio-alto
    Y ofrece <opciones de respuesta> (llamar, enviar mensaje, compartir ubicación a autoridades)

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | contactos de confianza         | conexión a internet | botón de pánico |
      | Carla Ramos                                                   | 3 contactos (Ana, Leo, Sofía)  | Todos conectados    | Activado        |

    Examples: Datos de salida
      | notificación | ubicación actual           | opciones de respuesta                         | estado de entrega |
      | Enviada      | Lat:-12.05, Lon:-77.05     | Llamar / Mensaje / Compartir con autoridades  | Entregada a 3     |

  Scenario Outline: Escenario 2 - Contactos sin conexión (reintentos y alerta pendiente)
    Dado que al menos uno de los <contactos de confianza> no tiene <conexión a internet>
    Y el <ciudadano o comerciante residente de zona de riesgo medio-alto> es residente de zona de riesgo medio-alto
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> activa el <botón de pánico>
    Entonces la aplicación reintenta el <envío automáticamente>
    Y muestra un <mensaje de estado> “alerta pendiente” para los contactos sin conexión
    Y marca como <entregada> la notificación a los contactos con conexión

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | contactos de confianza                           | conexión a internet                   | botón de pánico |
      | Luis Salazar                                                  | 3 contactos (Ana online, Leo offline, Sofía online) | Mixto (2 conectados, 1 sin conexión) | Activado        |

    Examples: Datos de salida
      | entregas exitosas | pendientes                    | mensaje de estado                    |
      | 2/3               | 1/3 (reintento en progreso)   | “Alerta pendiente: 1 contacto offline” |

  Scenario Outline: Escenario 3 - Contacto deshabilitado (inactivo no recibe)
    Dado que un <contacto> ha sido marcado como <inactivo>
    Y el <ciudadano o comerciante residente de zona de riesgo medio-alto> es residente de zona de riesgo medio-alto
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> activa el <botón de pánico>
    Entonces la aplicación no envía la <notificación> a ese <contacto inactivo>
    Y la aplicación registra en el <historial> que el contacto estaba inactivo

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | contactos de confianza                    | estado de contacto | botón de pánico |
      | Marta Quispe                                                  | 2 contactos (Diego inactivo, Rosa activa) | Diego: Inactivo    | Activado        |

    Examples: Datos de salida
      | entregas realizadas | omitidos por inactividad | registro en historial                      |
      | 1/2                 | 1 (Diego)                | “Contacto Diego omitido: estado inactivo”  |

  Scenario Outline: Escenario 4 - Confirmación de recepción
    Dado que los <contactos de confianza> reciben la <alerta> correctamente
    Y el <sistema> permite <confirmación de recepción> por contacto
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> consulta el <estado de notificación> en la aplicación
    Entonces el sistema registra la <confirmación> de los contactos que hayan respondido
    Y el <ciudadano o comerciante residente de zona de riesgo medio-alto> visualiza que el <contacto> fue notificado exitosamente

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | contactos de confianza         | estado de entrega previa | acción del usuario      |
      | Javier Paredes                                                | 3 contactos (Ana, Leo, Sofía)  | Entregada a 3            | Abre pantalla de estado |

    Examples: Datos de salida
      | confirmaciones recibidas         | contactos sin confirmar | visualización en app                                |
      | 2 (Ana “visto”, Sofía “OK”)      | 1 (Leo)                 | “Ana visto 14:02, Sofía OK 14:03, Leo sin respuesta” |





//HU-03A
Feature: Seguimiento de ubicación tras alerta
  Como ciudadano o comerciante residente de zona de riesgo medio-alto,
  quiero que el botón de pánico active mi ubicación en tiempo real,
  para que autoridades y contactos sepan dónde estoy y puedan asistir de inmediato.

  Scenario Outline: Escenario 1 - Ubicación establecida (tracking en tiempo real)
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> tiene la <geolocalización> habilitada y el <botón de pánico> operativo
    Y la <aplicación> está vinculada con <contactos de confianza>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> presiona el <botón de pánico> desde <pulsera o app>
    Entonces el sistema inicia el <seguimiento en tiempo real>
    Y muestra la <ubicación actual> del <ciudadano o comerciante residente de zona de riesgo medio-alto> en la app de <contactos de confianza>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | geolocalización | botón de pánico | pulsera o app | contactos de confianza |
      | A. Torres                                                    | Habilitada      | Operativo       | Pulsera       | 3 contactos vinculados  |

    Examples: Datos de salida
      | seguimiento en tiempo real | ubicación actual               | visible en contactos |
      | Iniciado                   | Lat:-12.058, Lon:-77.045 (RT)  | Sí (3/3)             |

  Scenario Outline: Escenario 2 - Conexión intermitente (último punto + actualización)
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> presenta una <conexión> inestable
    Y la <geolocalización> está habilitada
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> presiona el <botón de pánico> y la <señal> se pierde temporalmente
    Entonces la app muestra la <última ubicación registrada>
    Y actualiza automáticamente la <posición> cuando la <conexión> se restablece

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | conexión         | señal     | geolocalización | botón de pánico |
      | M. Ríos                                                      | Inestable (3G)   | Caídas    | Habilitada      | Activado        |

    Examples: Datos de salida
      | última ubicación registrada        | estado tracking          | actualización posterior               |
      | Lat:-12.060, Lon:-77.050 @ 14:03   | Mantiene último punto    | Reanuda RT al volver datos @ 14:05    |

  Scenario Outline: Escenario 3 - Ubicación compartida por tiempo limitado (política 1 hora)
    Dado que existe una <política de privacidad> que limita el rastreo a <1 hora>
    Y el <ciudadano o comerciante residente de zona de riesgo medio-alto> inició el <seguimiento en tiempo real>
    Cuando transcurre el <tiempo límite>
    Entonces la app detiene automáticamente el <seguimiento en tiempo real>
    Y muestra <mensaje de expiración> al <ciudadano o comerciante residente de zona de riesgo medio-alto> y a <contactos de confianza>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | política de privacidad | tiempo límite | seguimiento en tiempo real |
      | L. Salazar                                                   | Límite de 1 hora       | 60 minutos    | Iniciado 13:40             |

    Examples: Datos de salida
      | estado tracking | mensaje de expiración                          | visible en contactos         |
      | Detenido        | "Seguimiento finalizado por límite de 1 hora"  | Sí (estado actualizado)      |

  Scenario Outline: Escenario 4 - Geolocalización desactivada (envío sin ubicación)
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> tiene la <geolocalización> desactivada
    Y el <botón de pánico> está operativo
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> activa el <botón de pánico>
    Entonces el sistema envía la <alerta> sin <datos de ubicación>
    Y la app indica que el <rastreo> no está disponible
    Y sugiere <habilitar geolocalización> para próximos eventos

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | geolocalización | botón de pánico |
      | R. Díaz                                                      | Desactivada     | Activado        |

    Examples: Datos de salida
      | alerta enviada | datos de ubicación  | mensaje en app                                         |
      | Sí             | No disponibles      | "Rastreo no disponible. Activa la ubicación del equipo." |





//HU-04A
Feature: Activación discreta del botón de pánico desde el smartphone
  Como ciudadano o comerciante,
  quiero poder activar el botón de pánico de forma discreta desde la aplicación móvil,
  para solicitar ayuda sin alertar a la persona que representa el peligro.

  Scenario Outline: Escenario 1 - Activación desde pantalla bloqueada del smartphone
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> tiene el <teléfono bloqueado>
    Y la <aplicación móvil> está configurada para <activación discreta>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> mantiene presionado el <botón lateral> por <5 segundos>
    Entonces el sistema activa la <alerta> en segundo plano
    Y envía la <ubicación actual> a los <contactos de confianza>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | teléfono | configuración app | botón lateral | duración |
      | Carlos Pérez                                                  | Bloqueado | Activación discreta | Presionado   | 5 segundos |

    Examples: Datos de salida
      | alerta activada | modo de ejecución | ubicación enviada            | notificación a contactos |
      | Sí              | Segundo plano     | Lat:-12.057, Lon:-77.046     | Enviada a contactos configurados |

  Scenario Outline: Escenario 2 - Activación por gesto en la aplicación
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> abre la <aplicación móvil> en una situación de riesgo
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> realiza el <gesto de deslizar tres veces hacia abajo> en la pantalla
    Entonces el sistema dispara la <alerta>
    Y notifica a los <contactos de confianza> registrados

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | aplicación móvil | gesto realizado                  | contactos configurados |
      | María Torres                                                  | Abierta          | Deslizar tres veces hacia abajo  | 3 contactos activos     |

    Examples: Datos de salida
      | alerta activada | confirmación visual | notificación enviada |
      | Sí              | Icono discreto en pantalla | Sí (a 3 contactos) |

  Scenario Outline: Escenario 3 - Activación silenciosa
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> no desea llamar la atención
    Y la <aplicación móvil> está configurada en <modo discreto>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> activa el <botón de pánico> desde la aplicación
    Entonces el sistema no emite <sonido ni vibración>
    Pero se envía la <alerta> a los <contactos de confianza>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | aplicación móvil | modo | acción realizada |
      | Juan Ramos                                                    | Abierta          | Discreto | Activa botón de pánico |

    Examples: Datos de salida
      | sonido emitido | vibración | alerta enviada | mensaje interno |
      | No             | No        | Sí             | “Alerta enviada en modo discreto” |

  Scenario Outline: Escenario 4 - Activación desde notificación rápida
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> recibe una <notificación rápida de emergencia> en el smartphone
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> realiza un <toque prolongado> sobre dicha notificación
    Entonces el sistema dispara la <alerta> sin abrir la <aplicación completa>
    Y se notifica a los <contactos de confianza> configurados

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | tipo de notificación | acción realizada    | aplicación completa |
      | Ana Gutiérrez                                                 | Emergencia rápida    | Toque prolongado    | No abierta          |

    Examples: Datos de salida
      | alerta activada | app abierta | notificación enviada | confirmación discreta |
      | Sí              | No          | Sí                   | Vibración mínima + ícono invisible |



//HU-05A
Feature: Personalización de alertas de emergencia
  Como ciudadano o comerciante,
  quiero personalizar el contenido y los destinatarios de mis alertas,
  para asegurar que la información enviada sea útil y llegue a las personas correctas en cada situación.

  Scenario Outline: Escenario 1 - Selección de contactos preferidos
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> está configurando la <aplicación móvil>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> selecciona los <contactos principales> para recibir alertas
    Entonces la <aplicación> guarda esa <lista personalizada>
    Y la utiliza automáticamente cada vez que se active el <botón de pánico>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | aplicación móvil | contactos principales seleccionados       |
      | Carlos Pérez                                                  | Abierta          | Ana Torres, Luis Ramos, Policía Local     |

    Examples: Datos de salida
      | lista guardada | cantidad de contactos | mensaje de confirmación          |
      | Sí              | 3                     | “Contactos preferidos actualizados correctamente” |

  Scenario Outline: Escenario 2 - Mensaje personalizado
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> desea incluir <detalles adicionales> en la alerta
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> edita el <mensaje predeterminado> de la notificación
    Entonces la <aplicación> enviará un mensaje que incluya el <texto personalizado> junto con la <ubicación actual>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | mensaje predeterminado               | texto personalizado                    | ubicación actual          |
      | María Torres                                                  | “Emergencia. Necesito ayuda.”        | “Emergencia, hay un sujeto sospechoso en la puerta.” | Lat:-12.060, Lon:-77.049  |

    Examples: Datos de salida
      | mensaje enviado                                                            | destinatarios | confirmación de envío |
      | “Emergencia, hay un sujeto sospechoso en la puerta. Ubicación: -12.060,-77.049” | 3 contactos    | Envío exitoso          |

  Scenario Outline: Escenario 3 - Configuración de idioma
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> ha configurado un <idioma de notificaciones>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> activa una <alerta>
    Entonces la <aplicación> enviará el mensaje a los <contactos de confianza> en el <idioma seleccionado>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | idioma seleccionado | alerta activada | contactos de confianza |
      | Juan Ramos                                                    | Inglés              | Botón de pánico  | 2 contactos            |

    Examples: Datos de salida
      | idioma del mensaje | texto enviado                           | confirmación en app |
      | Inglés             | “Emergency Alert: Help needed immediately.” | Mensaje traducido enviado correctamente |

  Scenario Outline: Escenario 4 - Diferenciación por tipo de alerta
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> se encuentra en un <escenario de riesgo>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> selecciona la <categoría de emergencia> como “robo” o “agresión” al activar el <botón de pánico>
    Entonces la <aplicación> enviará el <mensaje> que incluye el <tipo de emergencia> junto con la <ubicación actual>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | categoría de emergencia | ubicación actual         | botón de pánico |
      | Ana Gutiérrez                                                 | Robo                    | Lat:-12.058, Lon:-77.050 | Activado        |

    Examples: Datos de salida
      | tipo de emergencia | mensaje enviado                                               | contactos notificados |
      | Robo               | “Alerta de robo en progreso. Ubicación: -12.058,-77.050.”     | 3 contactos            |



//HU-06M
Feature: Visualización de mapa de calor
  Como ciudadano o comerciante residente de zona de riesgo medio-alto,
  quiero ver un mapa con zonas de mayor incidencia delictiva,
  para identificar áreas peligrosas antes de salir.

  Scenario Outline: Escenario 1 - Visualización inicial del mapa
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> accede a la <aplicación>
    Y la <funcionalidad de mapas> está disponible
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> selecciona la opción <Mapa de calor> en el menú principal
    Entonces la <aplicación> muestra el <mapa> con <zonas resaltadas> en colores según el <nivel de riesgo delictivo>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | aplicación | funcionalidad de mapas | opción seleccionada |
      | Carlos Pérez                                                  | Activa     | Disponible             | Mapa de calor        |

    Examples: Datos de salida
      | mapa mostrado | colores de riesgo                          | mensaje en pantalla |
      | Sí             | Rojo = Alto, Amarillo = Medio, Verde = Bajo | “Visualizando mapa de riesgo” |

  Scenario Outline: Escenario 2 - Consulta de detalles de incidentes
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> tiene el <mapa de calor> abierto
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> toca una <zona resaltada> en el mapa
    Entonces la <aplicación> despliega <información detallada> de los <incidentes registrados> en esa área,
    incluyendo <hora>, <fecha> y <descripción del suceso>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | mapa de calor | zona seleccionada |
      | María Torres                                                  | Abierto       | Zona roja (Alto riesgo) |

    Examples: Datos de salida
      | información mostrada                  | campos visibles                | cantidad de incidentes |
      | Detalles por incidente delictivo      | Fecha, Hora, Descripción       | 5 incidentes en total  |

  Scenario Outline: Escenario 3 - Zoom en zonas específicas
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> tiene el <mapa de calor> visible
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> realiza un <gesto de acercamiento (zoom in)> sobre una zona
    Entonces la <aplicación> ajusta el <mapa> para mostrar un <mayor nivel de detalle>,
    incluyendo <incidencias específicas> en <calles o cuadras>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | mapa visible | gesto realizado | zona seleccionada      |
      | Juan Ramos                                                    | Sí           | Zoom in (dedos)  | Av. República de Chile |

    Examples: Datos de salida
      | nivel de detalle | incidencias mostradas                            | precisión geográfica |
      | Alto              | Casos individuales por calle y número de cuadra | Exacta por intersección |

  Scenario Outline: Escenario 4 - Actualización en tiempo real
    Dado que se han registrado <nuevas incidencias delictivas> en la <base de datos> de la aplicación
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> pulsa el <botón Refrescar> en la vista del mapa
    Entonces el <sistema> actualiza la <visualización> mostrando las <nuevas zonas de riesgo> y su <intensidad>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | nuevas incidencias | acción realizada | conexión |
      | Ana Gutiérrez                                                 | 3 robos recientes   | Pulsa “Refrescar” | En línea |

    Examples: Datos de salida
      | mapa actualizado | zonas añadidas             | intensidad del riesgo |
      | Sí               | 2 nuevas zonas rojas, 1 amarilla | Refleja aumento de incidentes recientes |

//HU-07C
Feature: Reporte comunitario en tiempo real
  Como vecino,
  quiero reportar incidentes de inseguridad desde la aplicación,
  para que los demás usuarios estén alertados al instante.

  Scenario Outline: Escenario 1 - Publicación de reporte
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> presenció un <incidente>
    Y tiene la <aplicación> abierta
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> completa el <formulario de reporte> y presiona <Enviar>
    Entonces el <sistema> publica el <incidente> inmediatamente en el <mapa>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | aplicación | formulario de reporte                          | acción realizada |
      | Carlos Pérez                                                  | Abierta    | Tipo: Robo, Descripción: sujeto armado          | Presiona Enviar  |

    Examples: Datos de salida
      | reporte publicado | ubicación en mapa             | mensaje en pantalla                  |
      | Sí                | Marcador visible en zona exacta | “Reporte publicado exitosamente”     |

  Scenario Outline: Escenario 2 - Notificación a usuarios cercanos
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> reporta un <incidente> y permite <notificaciones>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> presiona <Enviar reporte>
    Entonces la <aplicación> envía una <notificación push> a los <vecinos cercanos>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | tipo de incidente | permiso de notificaciones | acción realizada  |
      | María Torres                                                  | Asalto            | Activadas                 | Presiona Enviar reporte |

    Examples: Datos de salida
      | notificación enviada | destinatarios             | mensaje recibido                            |
      | Sí                   | Vecinos en radio de 500m  | “Nuevo reporte de asalto cerca de tu zona.” |

  Scenario Outline: Escenario 3 - Reporte sin conexión
    Dado que el <ciudadano o comerciante residente de zona de riesgo medio-alto> intenta enviar un <reporte> sin <conexión a internet>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> toca <Reintentar> al recuperar señal
    Entonces el <sistema> sincroniza el <reporte> automáticamente y queda <publicado>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | conexión a internet | acción realizada | reporte |
      | Juan Ramos                                                    | Sin conexión        | Toca “Reintentar” | Robo vehicular |

    Examples: Datos de salida
      | sincronización | estado del reporte | mensaje mostrado                     |
      | Automática     | Publicado          | “Reporte sincronizado correctamente.” |

  Scenario Outline: Escenario 4 - Consulta de reporte publicado
    Dado que un <reporte> se publicó en el <mapa>
    Cuando otro <ciudadano o comerciante residente de zona de riesgo medio-alto> abre el <reporte> en la aplicación
    Entonces la <aplicación> muestra los <detalles básicos> del reporte, incluyendo <tipo de incidente>, <hora> y <ubicación>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | reporte en mapa | acción realizada |
      | Ana Gutiérrez                                                 | Robo en Av. Grau | Abre reporte     |

    Examples: Datos de salida
      | tipo de incidente | hora       | ubicación             | información visible |
      | Robo              | 21:15 h    | Av. Grau - Cuadra 4   | Sí, con datos básicos del suceso |


//HU-08C
Feature: Validación de reportes ciudadanos
  Como usuario,
  quiero que los reportes sean verificados mediante votos de la comunidad o datos oficiales,
  para evitar falsas alarmas.

  Scenario Outline: Escenario 1 - Validación positiva de reporte
    Dado que un <reporte> fue publicado en el <foro>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> revisa el <reporte> y pulsa <Válido>
    Entonces el <sistema> registra su <validación positiva>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | reporte  | foro   | acción  |
      | Carlos Pérez                                                  | R-10235  | Abierto| Válido  |

    Examples: Datos de salida
      | validación registrada | tipo         | conteo positivo actualizado |
      | Sí                    | Positiva     | +1                          |

  Scenario Outline: Escenario 2 - Validación negativa de reporte
    Dado que un <reporte> fue publicado en el <foro>
    Cuando el <ciudadano o comerciante residente de zona de riesgo medio-alto> considera falso el contenido y pulsa <No válido>
    Entonces el <sistema> registra su <validación negativa>

    Examples: Datos de entrada
      | ciudadano o comerciante residente de zona de riesgo medio-alto | reporte  | foro   | acción    |
      | María Torres                                                  | R-10235  | Abierto| No válido |

    Examples: Datos de salida
      | validación registrada | tipo      | conteo negativo actualizado |
      | Sí                    | Negativa  | +1                          |

  Scenario Outline: Escenario 3 - Destacar reporte confiable (umbral de positivos)
    Dado que un <reporte> alcanza más de <tres valoraciones positivas>
    Cuando un <ci
