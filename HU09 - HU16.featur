// HU-09P
Feature: HU-09P - Rutas seguras sugeridas
  Como ciudadano, quiero que la aplicación me sugiera rutas más seguras según el mapa de calor,
  para reducir mi exposición a riesgos.

  Scenario: Generación de rutas
    Given que el ciudadano o comerciante ingresa su destino en la aplicación.
    When solicita una ruta hacia su destino.
    Then la aplicación debe mostrar al menos dos opciones de recorrido: una rápida y otra segura.

    Examples:
      | Origen                | Destino                  |
      | Av. Tupac Amaru 1200  | Plaza de Armas de Comas  |
      | Jr. Huánuco 350       | Av. Universitaria 900    |

  Scenario: Navegación en ruta segura
    Given que el ciudadano o comerciante selecciona la ruta segura.
    When inicia el desplazamiento con la navegación activa.
    Then el sistema debe guiar paso a paso el recorrido hasta llegar al destino.

    Examples:
      | Ruta seleccionada | Tipo     |
      | Ruta 2            | Segura   |

  Scenario: Desviación hacia zona de riesgo
    Given que el ciudadano o comerciante se encuentra navegando en la ruta segura.
    When se desvía e ingresa a una zona peligrosa según el mapa de calor.
    Then la aplicación debe enviar una alerta de advertencia al usuario.

    Examples:
      | Zona desviada       | Nivel de riesgo |
      | Av. Micaela Bastidas| Alto            |
      | Jr. Canta Callao    | Medio           |

  Scenario: Recalculo de rutas
    Given que existen cambios recientes en la seguridad de la zona.
    When el ciudadano o comerciante mantiene la navegación activa y se recibe nueva información de riesgo.
    Then el sistema debe recalcular las rutas sugeridas automáticamente y notificar al usuario del cambio.

    Examples:
      | Cambio detectado        | Acción del sistema       |
      | Nuevo robo reportado    | Recalcula ruta segura    |
      | Zona cerrada por peligro| Genera ruta alternativa  |



// HU-10M
Feature: HU-10M - Alertas de proximidad a zonas riesgosas  
  Como ciudadano o comerciante  
  Quiero recibir una notificación si me acerco a una zona de alto riesgo  
  Para poder tomar decisiones más seguras en mi recorrido.

  Scenario: Alerta preventiva por proximidad  
    Given que el ciudadano o comerciante tiene la aplicación activa o en segundo plano con permisos de ubicación  
    When el ciudadano o comerciante se aproxima a 200 metros de una zona peligrosa  
    Then la aplicación envía una alerta de proximidad.

    Examples:  
      | tipo_usuario | distancia |
      | ciudadano    | 200       |
      | comerciante  | 150       |

  Scenario: Opciones rápidas en alerta  
    Given que el ciudadano o comerciante recibe una alerta por ingresar a una zona peligrosa  
    When el ciudadano o comerciante abre la alerta en su dispositivo  
    Then la aplicación muestra opciones rápidas como “Cambiar ruta”, “Avisar a contacto” o “Activar botón de pánico”.

    Examples:  
      | tipo_usuario |
      | ciudadano    |
      | comerciante  |

  Scenario: Permanencia en zona de riesgo  
    Given que el ciudadano o comerciante permanece en una zona peligrosa  
    When el ciudadano o comerciante continúa en el área por cinco minutos  
    Then la aplicación envía un recordatorio de precaución.

    Examples:  
      | tipo_usuario | tiempo |
      | ciudadano    | 5      |
      | comerciante  | 10     |

  Scenario: Notificación al salir de la zona  
    Given que el ciudadano o comerciante se estaba desplazando dentro del perímetro de riesgo  
    When el ciudadano o comerciante sale del perímetro de riesgo  
    Then la aplicación notifica que ya se encuentra en un área más segura.

    Examples:  
      | tipo_usuario |
      | ciudadano    |
      | comerciante  |


// HU-11P

Feature: HU-11P - Registro de destino  
  Como ciudadano o comerciante  
  Quiero registrar mi destino en la aplicación  
  Para que mis contactos de confianza sean notificados si no llego a tiempo.

  Scenario: Registro de destino exitoso  
    Given que el ciudadano o comerciante ha ingresado una dirección o seleccionado un punto en el mapa  
    When el ciudadano o comerciante confirma el registro del destino  
    Then la aplicación guarda la información y muestra que el trayecto está activo.

    Examples:
      | Dirección destino       | Tiempo estimado | Contactos asignados |
      | Av. Universitaria 1234  | 30 minutos       | 2                   |
      | Jr. Los Olivos 450      | 45 minutos       | 1                   |

  Scenario: Notificación a contactos de confianza por retraso  
    Given que el ciudadano o comerciante registró un destino y definió un tiempo estimado de llegada  
    When el ciudadano o comerciante no confirma su llegada antes del tiempo estimado  
    Then la aplicación envía automáticamente una alerta a los contactos de confianza registrados.

    Examples:
      | Contacto de confianza | Mensaje enviado                                     |
      | Ana Pérez             | “Alerta: no se ha confirmado la llegada al destino” |
      | Luis Torres           | “Alerta: posible retraso en el trayecto registrado” |

  Scenario: Confirmación manual de llegada  
    Given que el ciudadano o comerciante llega a su destino antes del tiempo estimado  
    When el ciudadano o comerciante presiona el botón “He llegado”  
    Then la aplicación desactiva la alerta automática y no se notifica a los contactos.

    Examples:
      | Tiempo estimado | Hora real de llegada | Alerta enviada |
      | 20:00            | 19:45                | No             |
      | 18:30            | 18:25                | No             |

  Scenario: Extensión del tiempo de llegada  
    Given que el ciudadano o comerciante se encuentra en trayecto y aún no arriba al destino  
    When el ciudadano o comerciante decide extender manualmente el tiempo estimado de llegada  
    Then la aplicación actualiza el temporizador y ajusta la alerta automática a la nueva hora.

    Examples:
      | Tiempo original | Extensión aplicada | Nuevo tiempo estimado |
      | 30 min          | +10 min            | 40 min                |
      | 45 min          | +15 min            | 60 min                |

  Scenario: Fallo de conexión o GPS  
    Given que el ciudadano o comerciante registró un destino y la app está monitoreando el trayecto  
    When el ciudadano o comerciante continúa su trayecto y se pierde la conexión o la señal GPS por un periodo prolongado  
    Then la aplicación envía una alerta preventiva a los contactos de confianza con la última ubicación registrada.

    Examples:
      | Estado conexión | Última ubicación registrada  | Alerta enviada |
      | Sin señal GPS   | Av. Tupac Amaru 2500         | Sí             |
      | Sin internet    | Jr. Las Flores 980           | Sí             |


// HU-12P

Feature: HU-12P - Sugerencia de rutas seguras  
  Como ciudadano o comerciante  
  Quiero que la aplicación me acompañe durante mi trayecto y me alerte ante incidentes o zonas peligrosas detectadas en tiempo real  
  Para poder reaccionar a tiempo y mantener mi seguridad.

  Scenario: Detección de incidentes cercanos  
    Given que el ciudadano o comerciante se encuentra en desplazamiento con la navegación activa  
    When se registra un nuevo incidente o zona de riesgo en su trayecto  
    Then la aplicación envía una alerta inmediata con opciones de acción (“Desvío”, “Avisar a contacto” o “Botón de pánico”).

    Examples:
      | Tipo de incidente     | Distancia al usuario | Opciones mostradas                        |
      | Robo reportado        | 150 m                | Desvío / Avisar a contacto / Botón pánico |
      | Zona peligrosa nueva  | 100 m                | Desvío / Avisar a contacto / Botón pánico |

  Scenario: Acompañamiento en tiempo real  
    Given que el ciudadano o comerciante inicia su trayecto con la función de acompañamiento  
    When el ciudadano o comerciante se encuentra en movimiento  
    Then la aplicación actualiza su ubicación en tiempo real y permite compartir su recorrido con contactos de confianza.

    Examples:
      | Contacto compartido | Estado del recorrido | Actualización de ubicación |
      | Ana Pérez           | En movimiento        | Cada 10 segundos           |
      | Luis Torres         | En movimiento        | Cada 15 segundos           |

  Scenario: Confirmación de seguridad  
    Given que el ciudadano o comerciante ha activado el acompañamiento  
    When el sistema detecta una detención prolongada o falta de movimiento  
    Then la aplicación solicita una confirmación de seguridad y, en caso de no recibir respuesta, alerta a los contactos registrados.

    Examples:
      | Tiempo sin movimiento | Respuesta del usuario | Alerta enviada |
      | 5 minutos             | No                    | Sí             |
      | 3 minutos             | Sí                    | No             |

  Scenario: Finalización del acompañamiento  
    Given que el ciudadano o comerciante llega a su destino  
    When el ciudadano o comerciante confirma su llegada  
    Then la aplicación finaliza el acompañamiento y guarda el historial del trayecto como “seguro”.

    Examples:
      | Destino alcanzado     | Hora de llegada | Estado del trayecto |
      | Av. Tupac Amaru 1450  | 18:35           | Seguro              |
      | Jr. Los Robles 320    | 19:10           | Seguro              |


// HU-13C

Feature: HU-13C - Ubicación de las autoridades  
  Como ciudadano o comerciante  
  Quiero que la aplicación me permita ver la ubicación de autoridades cercanas  
  Para saber quiénes me podrán asistir y dónde están.

  Scenario: Visualización inicial de autoridades cercanas  
    Given que el ciudadano o comerciante tiene la aplicación instalada, la geolocalización habilitada y permisos de ubicación y datos  
    When el ciudadano o comerciante selecciona el ícono de GPS en la aplicación  
    Then la aplicación muestra en el mapa los íconos de las unidades disponibles (por ejemplo: patrullas, ambulancias) con su distancia y tiempo estimado de llegada.

    Examples:
      | Tipo de autoridad  | Distancia | Tiempo estimado | Estado     |
      | Patrulla PNP       | 350 m     | 2 min           | Disponible |
      | Ambulancia SAMU    | 500 m     | 4 min           | En servicio |
      | Bomberos Comas     | 700 m     | 6 min           | Disponible |

  Scenario: Filtrado por tipo de autoridad  
    Given que la aplicación tiene datos de múltiples tipos de autoridades y el ciudadano o comerciante se encuentra en la vista de autoridades  
    When el ciudadano o comerciante aplica el filtro “Ambulancias” (o “Policía”, “Bomberos”)  
    Then la aplicación muestra en el mapa únicamente las unidades del tipo seleccionado y actualiza la lista con sus detalles de distancia y estado.

    Examples:
      | Filtro aplicado | Resultado mostrado      |
      | Policía         | Solo patrullas PNP      |
      | Ambulancias     | Solo unidades SAMU      |
      | Bomberos        | Solo unidades CGBVP     |

  Scenario: Permiso de ubicación o datos denegado  
    Given que el ciudadano o comerciante no ha concedido permiso de ubicación o el dispositivo no tiene conexión de datos  
    When el ciudadano o comerciante intenta acceder a “Ver autoridades cercanas”  
    Then la aplicación muestra un mensaje indicando que requiere permisos de ubicación o conexión y no presenta unidades en el mapa.

    Examples:
      | Estado permisos  | Estado conexión | Mensaje mostrado                                           |
      | Denegado         | Activa          | "Debe activar la ubicación para usar esta función."         |
      | Permitido        | Sin conexión    | "Conecte a internet para ver autoridades cercanas."         |
      | Denegado         | Sin conexión    | "Active ubicación y conexión para continuar."               |

  Scenario: Actualización en tiempo real de movimiento de unidades  
    Given que el ciudadano o comerciante está visualizando las autoridades cercanas y mantiene conexión estable  
    When el ciudadano o comerciante mantiene abierta la vista de autoridades o pulsa “Actualizar”  
    Then la aplicación actualiza la posición de las unidades en el mapa y refleja los cambios en distancia y tiempo estimado de llegada.

    Examples:
      | Tipo de autoridad  | Distancia anterior | Distancia actual | ETA anterior | ETA actual |
      | Patrulla PNP       | 350 m              | 290 m            | 2 min        | 1 min      |
      | Ambulancia SAMU    | 500 m              | 520 m            | 4 min        | 5 min      |


// HU-14P
Feature: HU-14P - Modo trayecto seguro  
  Como ciudadano o comerciante  
  Quiero que la aplicación monitoree mi recorrido en tiempo real y emita alertas automáticas si detecta anomalías  
  Para advertir de cualquier incidente durante mi trayecto.

  Scenario: Activación del modo trayecto seguro  
    Given que el ciudadano o comerciante ha registrado un destino  
    When el ciudadano o comerciante selecciona la opción “Activar trayecto seguro”  
    Then la aplicación inicia el monitoreo de su ubicación en tiempo real.

    Examples:
      | Destino registrado     | Estado del trayecto  | Resultado esperado                       |
      | Av. Universitaria 1020 | No iniciado          | Modo trayecto seguro activado correctamente |
      | Jr. Los Olivos 215     | No iniciado          | Monitoreo en tiempo real iniciado         |

  Scenario: Detección de desvío significativo  
    Given que el ciudadano o comerciante tiene activado el trayecto seguro  
    When el ciudadano o comerciante se desvía de la ruta establecida de manera significativa  
    Then la aplicación genera una alerta preventiva en pantalla.

    Examples:
      | Desvío detectado (m) | Mensaje mostrado                                 |
      | 150                  | "Te estás alejando de tu ruta segura."           |
      | 300                  | "Desvío considerable detectado. ¿Deseas ayuda?"  |

  Scenario: Alerta automática por anomalía  
    Given que el ciudadano o comerciante mantiene activo el trayecto seguro  
    When el ciudadano o comerciante realiza un desvío brusco o tiene una detención prolongada en una zona peligrosa sin confirmar su estado  
    Then el sistema envía una alerta automática a los contactos de confianza.

    Examples:
      | Tipo de anomalía      | Tiempo sin movimiento | Acción del sistema                                  |
      | Desvío brusco         | 0 min                 | Envío de alerta automática a contactos de confianza |
      | Inactividad prolongada | 8 min                | Notificación enviada con última ubicación registrada |

  Scenario: Confirmación de seguridad  
    Given que el ciudadano o comerciante recibe una alerta por posible incidente o anomalía  
    When el ciudadano o comerciante confirma que está a salvo desde la notificación  
    Then el sistema cancela el envío de la notificación automática.

    Examples:
      | Tipo de alerta         | Respuesta del usuario | Resultado esperado                          |
      | Inactividad prolongada | "Estoy bien"          | Alerta cancelada, sin aviso a contactos      |
      | Desvío brusco          | "Confirmar seguridad" | Notificación detenida correctamente          |

  Scenario: Finalización del trayecto seguro  
    Given que el ciudadano o comerciante ha llegado a su destino  
    When el ciudadano o comerciante presiona el botón “Finalizar trayecto seguro”  
    Then la aplicación detiene el monitoreo y registra el trayecto como completado sin incidentes.

    Examples:
      | Destino alcanzado       | Duración del trayecto | Resultado esperado                       |
      | Av. Central 540         | 25 min                | Trayecto finalizado sin incidentes        |
      | Jr. Las Flores 318      | 40 min                | Monitoreo detenido correctamente          |


// HU-15P
Feature: HU-15P - Alerta por desvío de ruta  
  Como ciudadano o comerciante  
  Quiero que la aplicación detecte si me desvío bruscamente de mi ruta habitual  
  Para poder reaccionar más rápido ante situaciones de riesgo.

  Scenario: Configuración de ruta habitual  
    Given que el ciudadano o comerciante define una ruta frecuente en la aplicación  
    When el ciudadano o comerciante guarda la configuración  
    Then el sistema registra la ruta como trayecto habitual.

    Examples:
      | Ruta configurada                | Estado previo | Resultado esperado                     |
      | Av. Túpac Amaru – Av. Perú      | No registrada | Ruta habitual registrada correctamente |
      | Jr. Los Alisos – Av. Mendiola   | No registrada | Trayecto habitual guardado exitosamente |

  Scenario: Detección de desvío brusco  
    Given que el ciudadano o comerciante se encuentra en su ruta habitual con seguimiento activo  
    When el ciudadano o comerciante cambia repentinamente de dirección  
    Then el sistema activa una alerta preventiva en el dispositivo.

    Examples:
      | Cambio de dirección (°) | Tipo de alerta       | Resultado esperado                          |
      | 45                      | Visual y sonora      | Alerta preventiva mostrada en pantalla       |
      | 90                      | Vibración y mensaje  | Alerta activada por desvío brusco detectado  |

  Scenario: Activación automática del botón de pánico  
    Given que el ciudadano o comerciante realiza un desvío brusco y no responde a la verificación en el tiempo límite  
    When el ciudadano o comerciante no confirma que está seguro desde la notificación de verificación  
    Then el sistema activa automáticamente el botón de pánico y envía una alerta a contactos de confianza.

    Examples:
      | Tiempo de espera  | Confirmación del usuario | Acción del sistema                                 |
      | 15 segundos       | No responde              | Botón de pánico activado y alerta enviada          |
      | 30 segundos       | No responde              | Notificación automática enviada a contactos de confianza |

  Scenario: Confirmación manual de seguridad  
    Given que el ciudadano o comerciante recibe una alerta por desvío  
    When el ciudadano o comerciante abre la notificación y confirma manualmente que está a salvo  
    Then el sistema cancela la activación automática del botón de pánico.

    Examples:
      | Tipo de alerta         | Acción del usuario    | Resultado esperado                          |
      | Desvío brusco detectado | "Estoy bien"         | Botón de pánico desactivado correctamente    |
      | Desvío leve detectado   | "Confirmar seguridad" | Alerta cancelada sin notificar a contactos   |


// HU-16C

Feature: HU-16C - Foro de incidentes locales  
  Como ciudadano o comerciante  
  Quiero acceder a un foro donde se publiquen incidentes recientes en mi zona  
  Para mantenerme informado sobre situaciones de inseguridad.

  Scenario: Visualización de incidentes recientes  
    Given que el ciudadano o comerciante accede al foro comunitario  
    When el ciudadano o comerciante abre la sección de incidentes  
    Then el sistema muestra los incidentes más recientes ordenados cronológicamente.

    Examples:
      | Fecha del incidente | Tipo de incidente | Resultado esperado                              |
      | 25/10/2025          | Robo              | Incidente mostrado en primer lugar              |
      | 24/10/2025          | Vandalismo        | Incidente listado debajo del más reciente       |

  Scenario: Filtrado por categoría  
    Given que el ciudadano o comerciante desea filtrar por categoría (por ejemplo: robo, vandalismo, accidente)  
    When el ciudadano o comerciante aplica el filtro de categoría  
    Then el sistema muestra en el foro solo los incidentes de esa categoría.

    Examples:
      | Categoría seleccionada | Resultado esperado                            |
      | Robo                   | Solo se muestran publicaciones de robos       |
      | Accidente              | Solo se muestran publicaciones de accidentes  |

  Scenario: Filtrado por ubicación  
    Given que el ciudadano o comerciante indicó su barrio o zona en el filtro  
    When el ciudadano o comerciante actualiza el filtro de ubicación  
    Then el sistema despliega en el foro únicamente los incidentes de esa área.

    Examples:
      | Zona filtrada | Resultado esperado                                    |
      | Comas         | Solo se muestran incidentes registrados en Comas      |
      | Los Olivos    | Solo se muestran incidentes registrados en Los Olivos |
