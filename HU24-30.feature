//HU-24S
Feature: Notificación de intentos de acceso sospechosos
    Como usuario,
    quiero recibir alertas cuando alguien intente acceder a mi cuenta,
    para proteger mi información a tiempo.

  Scenario Outline: Escenario 1 - Notificación de inicio desde dispositivo no registrado
    Dado que el <usuario> tiene <notificaciones de seguridad activadas>, un <correo o teléfono verificado> y la <detección de nuevos dispositivos> habilitada,
    Cuando el <usuario> o un tercero intenta iniciar sesión desde un <dispositivo no registrado>,
    Entonces la aplicación envía una <notificación inmediata> al <canal configurado> (push, correo o SMS) indicando <ubicación aproximada>, <dispositivo> y <hora del intento>.

        Examples: Datos de entrada  
        | usuario        | dispositivo               | detección de nuevos dispositivos | canal configurado | ubicación tentativa     | hora intento |
        | Luis Gómez     | Laptop desconocida (Windows) | Activada                        | Correo             | Lima, Perú              | 14:25        |

        Examples: Datos de salida  
        | notificación enviada | medio de envío | mensaje mostrado                                               |
        | Sí                   | Correo         | “Nuevo intento de acceso desde Windows - Lima, 14:25”          |

  Scenario Outline: Escenario 2 - Bloqueo por intentos fallidos
    Dado que la <cuenta> tiene configurado un <umbral de intentos fallidos> y el <captcha/2FA> están habilitados,
    Cuando el <usuario> o un tercero introduce una <contraseña incorrecta> y supera el <umbral de intentos fallidos consecutivos>,
    Entonces la aplicación <bloquea temporalmente> la cuenta, muestra un <mensaje de bloqueo> con el <tiempo de espera> y envía una <alerta> al <usuario>.

        Examples: Datos de entrada  
        | usuario       | intentos fallidos | umbral configurado | captcha/2FA | hora del último intento |
        | Ana Rodríguez | 5 consecutivos    | 3                  | Habilitado  | 09:18                   |

        Examples: Datos de salida  
        | estado de cuenta | mensaje mostrado                            | alerta enviada al usuario              |
        | Bloqueada 15 min | “Cuenta bloqueada por múltiples intentos”   | “Tu cuenta ha sido bloqueada temporalmente” |

  Scenario Outline: Escenario 3 - Historial de alertas
    Dado que el <usuario> está autenticado en la aplicación y existen <eventos de seguridad registrados>,
    Cuando el <usuario> accede a <Configuración > Seguridad > Intentos sospechosos>,
    Entonces la aplicación muestra un <historial> con <fecha>, <hora>, <origen (IP/ubicación)> y <tipo de evento>.

        Examples: Datos de entrada  
        | usuario       | eventos de seguridad registrados | autenticación |
        | Pedro López   | 3 registros                      | Válida        |

        Examples: Datos de salida  
        | número de registros | detalles mostrados                                                 |
        | 3                   | Fecha, hora, IP, ubicación, tipo de evento (“inicio no reconocido”) |

  Scenario Outline: Escenario 4 - Confirmación de actividad
    Dado que el <sistema> envió una <alerta de seguridad> con <enlace de verificación válido> y la <sesión del usuario> está activa,
    Cuando el <usuario> abre la <notificación> y selecciona “<Fui yo>” o “<No fui yo>”,
    Entonces la aplicación registra la <confirmación> y actualiza el <estado del evento> como “<confirmado>” o “<reportado>”.

        Examples: Datos de entrada  
        | usuario       | alerta recibida | acción del usuario | enlace de verificación | sesión activa |
        | Sofía Méndez  | Sí              | “No fui yo”        | Válido                 | Sí            |

        Examples: Datos de salida  
        | estado del evento | registro actualizado en historial             | mensaje mostrado al usuario              |
        | Reportado         | “Intento sospechoso reportado correctamente”  | “Hemos recibido tu reporte de seguridad” |


//HU-25S
Feature: Cierre de sesión automático  
  Como usuario,  
  quiero que la app cierre sesión tras un tiempo de inactividad,  
  para evitar que otros usen mi cuenta sin permiso.  

  Scenario Outline: Escenario 1 - Cierre tras inactividad  
    Dado que el <usuario> tiene una <sesión activa> en la aplicación,  
    Y permanece <inactivo> durante <10 minutos>,  
    Cuando transcurre el tiempo configurado de inactividad,  
    Entonces la aplicación <cierra la sesión automáticamente>  
    Y muestra un mensaje indicando que la sesión ha caducado.  

    Examples: Datos de entrada  
      | usuario        | sesión activa | tiempo de inactividad | configuración por defecto |
      | José Martínez  | Sí            | 10 minutos            | 10 minutos               |

    Examples: Datos de salida  
      | sesión cerrada | mensaje mostrado                          |
      | Sí             | “Sesión cerrada por inactividad”          |


  Scenario Outline: Escenario 2 - Solicitud de nuevo login  
    Dado que la <sesión del usuario> caducó por <inactividad>,  
    Cuando el <usuario> vuelve a abrir la aplicación,  
    Entonces el sistema <muestra la pantalla de inicio de sesión>  
    Y solicita las <credenciales> para ingresar nuevamente.  

    Examples: Datos de entrada  
      | usuario        | sesión caducada | acción del usuario   |
      | José Martínez  | Sí              | Reabre la aplicación |

    Examples: Datos de salida  
      | pantalla mostrada        | solicitud de credenciales | mensaje en pantalla                  |
      | Inicio de sesión         | Sí                        | “Tu sesión ha expirado, inicia sesión nuevamente” |


  Scenario Outline: Escenario 3 - Configuración de tiempo de inactividad  
    Dado que el <usuario> desea <personalizar el tiempo de inactividad> antes del cierre,  
    Cuando el <usuario> abre <Ajustes > Seguridad > Sesión> y ajusta el <temporizador>,  
    Entonces la aplicación guarda la <nueva configuración> del tiempo seleccionado  
    Y actualiza el <tiempo límite de inactividad>.  

    Examples: Datos de entrada  
      | usuario        | tiempo anterior | nuevo tiempo configurado | acción realizada             |
      | José Martínez  | 10 minutos      | 15 minutos               | Ajusta temporizador en Ajustes |

    Examples: Datos de salida  
      | tiempo guardado | confirmación mostrada                 |
      | 15 minutos       | “Configuración actualizada con éxito” |


  Scenario Outline: Escenario 4 - Aviso de cierre próximo  
    Dado que la <sesión> está por caducar y la <aplicación> está en primer plano,  
    Cuando falta <1 minuto> para el cierre automático,  
    Entonces el sistema muestra un <aviso al usuario> indicando el próximo cierre,  
    ofreciendo la opción de <mantener sesión activa>.  

    Examples: Datos de entrada  
      | usuario        | tiempo restante | aplicación en primer plano | acción posible          |
      | José Martínez  | 1 minuto        | Sí                         | Extender sesión         |

    Examples: Datos de salida  
      | mensaje mostrado                           | opciones disponibles    |
      | “Tu sesión se cerrará en 1 minuto”          | “Mantener activa” / “Cerrar ahora” |


//HU-26S
Feature: Acceso con doble autenticación  
  Como usuario,  
  quiero activar doble autenticación,  
  para reforzar la seguridad de mi cuenta.  

  Scenario Outline: Escenario 1 - Cierre tras inactividad  
    Dado que el <usuario> tiene una <sesión activa> en la aplicación,  
    Y ha transcurrido un <tiempo de inactividad> igual o superior a <10 minutos>,  
    Cuando el <usuario> no realiza ninguna acción durante ese periodo,  
    Entonces la aplicación <cierra la sesión automáticamente> por seguridad.  

    Examples: Datos de entrada  
      | usuario        | sesión activa | tiempo de inactividad | acción del usuario |
      | Pedro Gómez    | Sí            | 10 minutos            | Ninguna            |

    Examples: Datos de salida  
      | estado de sesión | mensaje mostrado                         |
      | Cerrada          | “Sesión cerrada por inactividad”         |


  Scenario Outline: Escenario 2 - Solicitud de nuevo login  
    Dado que la <sesión del usuario> ha <caducado por inactividad>,  
    Cuando el <usuario> vuelve a abrir la <aplicación>,  
    Entonces la aplicación <solicita iniciar sesión nuevamente>  
    Y requiere el <segundo factor de autenticación> para validar el acceso.  

    Examples: Datos de entrada  
      | usuario       | estado de sesión | acción del usuario | segundo factor de autenticación |
      | Pedro Gómez   | Caducada         | Abre aplicación    | Código enviado al correo         |

    Examples: Datos de salida  
      | pantalla mostrada         | autenticación requerida | mensaje mostrado                  |
      | Inicio de sesión           | Sí                      | “Ingrese su código de verificación” |


  Scenario Outline: Escenario 3 - Configuración de tiempo de inactividad  
    Dado que el <usuario> desea <personalizar el tiempo de cierre automático>,  
    Cuando el <usuario> accede a <Ajustes > Seguridad > Sesión>  
    Y modifica el <temporizador de inactividad> a un nuevo valor,  
    Entonces la aplicación <guarda la configuración> y actualiza los parámetros de cierre.  

    Examples: Datos de entrada  
      | usuario       | valor anterior | nuevo valor | sección modificada      |
      | Pedro Gómez   | 10 minutos     | 5 minutos   | Seguridad > Sesión       |

    Examples: Datos de salida  
      | configuración guardada | mensaje mostrado                  |
      | Sí                     | “Nuevo tiempo de cierre guardado” |


  Scenario Outline: Escenario 4 - Aviso de cierre próximo  
    Dado que la <sesión del usuario> está por caducar  
    Y la <aplicación> se encuentra en <primer plano>,  
    Cuando falta <1 minuto> para el cierre automático,  
    Entonces el sistema muestra un <aviso de cierre próximo> con opción de <mantener sesión activa>.  

    Examples: Datos de entrada  
      | usuario       | tiempo restante | aplicación en primer plano | acción disponible        |
      | Pedro Gómez   | 1 minuto        | Sí                         | Mantener sesión activa   |

    Examples: Datos de salida  
      | mensaje mostrado                         | acción del usuario | resultado esperado             |
      | “Su sesión caducará en 1 minuto”         | Mantener sesión    | Sesión prolongada exitosamente |

//HU-27S
Feature: Control de datos compartidos
    Como ciudadano,
    quiero decidir qué datos comparto con la comunidad,
    para mantener mi privacidad.

    Scenario Outline: Escenario 1 - Configuración de anonimato
        Dado que el <usuario> va a publicar en la <comunidad>,
        Y selecciona la opción de <ocultar nombre y ubicación exacta>,
        Cuando el <usuario> confirma la <publicación>,
        Entonces la <app> publica el <contenido> respetando el <anonimato seleccionado>.

        Examples: Datos de entrada  
        | usuario         | comunidad     | nombre visible | ubicación visible | acción          |
        | Carla Ramos     | SeguridadApp  | No             | No                | Publicar alerta |

        Examples: Datos de salida  
        | nombre mostrado | ubicación mostrada | estado de publicación | mensaje en pantalla                 |
        | Anónimo          | No visible         | Publicada              | “Tu alerta se publicó de forma anónima” |

    Scenario Outline: Escenario 2 - Activación del modo privado
        Dado que el <usuario> activa el <modo privado> en su configuración,
        Cuando el <usuario> comparte un <contenido> desde la aplicación,
        Entonces la aplicación mantiene su <identidad anónima>
        Y no muestra datos personales en la <publicación>.

        Examples: Datos de entrada  
        | usuario         | modo privado | tipo de contenido | comunidad     |
        | Luis Salazar    | Activado     | Recomendación     | VecinosZonaB  |

        Examples: Datos de salida  
        | identidad mostrada | visibilidad de perfil | estado de publicación | mensaje en pantalla                   |
        | Oculta              | No visible            | Publicada             | “Modo privado activo: publicación anónima” |


    Scenario Outline: Escenario 3 - Vista previa antes de publicar
        Dado que el <usuario> va a compartir un <contenido> en la comunidad,
        Cuando el <usuario> revisa la <vista previa> de su publicación,
        Entonces la aplicación muestra cómo aparecerá el contenido,
        indicando si será <público> o <anónimo> según la configuración.

        Examples: Datos de entrada  
        | usuario        | configuración seleccionada | contenido tipo | vista previa solicitada |
        | Marta Quispe   | Anónimo                    | Comentario     | Sí                      |

        Examples: Datos de salida  
        | vista mostrada         | estado de anonimato | mensaje en pantalla                    |
        | Contenido sin nombre    | Anónimo activado    | “Tu publicación se mostrará de forma anónima” |

    Scenario Outline: Escenario 4 - Modificación posterior de permisos
        Dado que el <usuario> ya compartió un <contenido> en la comunidad,
        Cuando el <usuario> edita los <permisos de visibilidad> del contenido,
        Entonces la <app> actualiza los <permisos> aplicados al contenido
        Y refleja el cambio en tiempo real en la publicación.
        Examples: Datos de entrada  
        | usuario         | contenido compartido  | permiso anterior | nuevo permiso | acción realizada       |
        | Javier Paredes  | Alerta comunitaria    | Público          | Anónimo       | Editar visibilidad     |

        Examples: Datos de salida  
        | estado actualizado | visibilidad actual | confirmación en app                    |
        | Sí                 | Anónimo            | “Permisos de publicación actualizados” |


//HU-28S
Feature: Eliminación de cuenta y datos  
  Como usuario,  
  quiero poder eliminar mi cuenta y datos asociados,  
  para tener control total sobre mi información personal.

  Scenario Outline: Escenario 1 - Eliminación definitiva  
    Dado que el <usuario> solicita eliminar su cuenta,  
    Y confirma la <acción de eliminación>,  
    Cuando la <aplicación> procesa la solicitud,  
    Entonces se eliminan <permanentemente> todos los <datos personales> y el <acceso a la cuenta> se desactiva.  

    Examples: Datos de entrada  
      | usuario          | acción de eliminación | autenticación | datos almacenados          | confirmación |
      | Carlos Ramírez   | Solicita eliminación  | Verificada    | Perfil, historial, fotos   | Sí           |

    Examples: Datos de salida  
      | estado de cuenta | datos personales | mensaje mostrado                    |
      | Eliminada        | Borrados         | “Tu cuenta y datos han sido eliminados permanentemente.” |

  Scenario Outline: Escenario 2 - Confirmación irreversible  
    Dado que la <eliminación de cuenta> es un proceso <irreversible>,  
    Cuando el <usuario> confirma la <eliminación>,  
    Entonces la <aplicación> muestra un <aviso de advertencia> antes de proceder  
    Y solicita una <confirmación final> para evitar eliminaciones accidentales.  

    Examples: Datos de entrada  
      | usuario        | acción | advertencia previa | confirmación final |
      | Lucía Torres   | Eliminar cuenta | Mostrada | Confirmada         |

    Examples: Datos de salida  
      | mensaje mostrado                               | requiere confirmación adicional | resultado final   |
      | “Esta acción es irreversible. ¿Deseas continuar?” | Sí                              | Eliminación iniciada |

  Scenario Outline: Escenario 3 - Periodo de gracia  
    Dado que el <usuario> eliminó su cuenta recientemente  
    Y la <aplicación> ofrece un <periodo de gracia de 15 días>,  
    Cuando el <usuario> solicita <recuperar su cuenta> dentro del periodo,  
    Entonces la <aplicación> restaura los <datos personales> y <acceso> sin pérdida de información.  

    Examples: Datos de entrada  
      | usuario          | días desde eliminación | solicitud de recuperación | datos respaldados |
      | Andrés Gómez     | 10                     | Sí                        | Completo           |

    Examples: Datos de salida  
      | cuenta restaurada | mensaje mostrado                       | datos recuperados |
      | Sí                 | “Tu cuenta ha sido restaurada exitosamente.” | Todos             |

  Scenario Outline: Escenario 4 - Eliminación selectiva  
    Dado que el <usuario> no desea cerrar su cuenta,  
    Y solicita eliminar solo <ciertos datos personales>,  
    Cuando el <usuario> selecciona los <elementos a eliminar> y confirma la acción,  
    Entonces la <aplicación> elimina únicamente la <información seleccionada>  
    y conserva el resto de los datos activos de la cuenta.  

    Examples: Datos de entrada  
      | usuario          | datos seleccionados     | confirmación | cuenta activa |
      | Paula Herrera    | Fotos y ubicación       | Sí           | Sí            |

    Examples: Datos de salida  
      | datos eliminados     | datos conservados           | mensaje mostrado                          |
      | Fotos y ubicación    | Perfil y configuración       | “Los datos seleccionados fueron eliminados correctamente.” |

//HU-29S
Feature: Acceso restringido para administradores
    Como usuario,
    quiero que solo administradores autorizados puedan ver datos sensibles,
    para garantizar que no se usen indebidamente.

    Scenario Outline: Escenario 1 - Acceso autorizado
        Dado que el <usuario> está registrado en el sistema como <administrador autorizado>,
        Y su <sesión> está activa y el <dispositivo> está verificado,
        Cuando el <usuario> inicia sesión y solicita acceder a los <datos sensibles>,
        Entonces el sistema muestra la <información completa> y permite interactuar con las <funciones administrativas> correspondientes.

        Examples: Datos de entrada  
        | usuario         | rol                | sesión  | dispositivo         | acción                         |
        | Carlos Ruiz     | Administrador      | Activa  | Verificado          | Solicita acceso a datos         |

        Examples: Datos de salida  
        | acceso concedido | datos visibles        | funciones habilitadas               |
        | Sí               | Información completa  | Editar / Eliminar / Exportar datos  |

    Scenario Outline: Escenario 2 - Acceso denegado a usuario no autorizado
        Dado que el <usuario> no tiene privilegios de administrador o no está registrado como tal,
        Cuando el <usuario> intenta acceder a los <datos sensibles> desde la <aplicación o portal web>,
        Entonces el sistema bloquea el acceso, muestra un <mensaje de error> indicando falta de permisos y no revela ningún dato.

        Examples: Datos de entrada  
        | usuario        | rol          | dispositivo   | acción                  |
        | Laura Gómez    | Usuario base | Verificado    | Intenta ver datos       |

        Examples: Datos de salida  
        | acceso concedido | mensaje mostrado                            | datos visibles |
        | No               | “Acceso denegado: privilegios insuficientes” | Ninguno        |

    Scenario Outline: Escenario 3 - Sesión caducada
        Dado que el <usuario administrador> tiene una <sesión activa> pero ha pasado el <tiempo máximo permitido>,
        Cuando el <usuario> intenta acceder nuevamente a los <datos sensibles>,
        Entonces el sistema solicita una <re-autenticación> antes de mostrar cualquier información,
        manteniendo los datos protegidos hasta que se complete el nuevo inicio de sesión.

        Examples: Datos de entrada  
        | usuario        | rol           | tiempo de inactividad | acción              |
        | Andrés Torres  | Administrador | 35 minutos            | Intenta acceder     |

        Examples: Datos de salida  
        | acceso concedido | mensaje mostrado                   | acción requerida     |
        | No               | “Sesión caducada, inicie sesión nuevamente” | Re-autenticación     |

    Scenario Outline: Escenario 4 - Intento de acceso desde dispositivo no autorizado
        Dado que el <usuario administrador> intenta acceder desde un <dispositivo no registrado o no verificado>,
        Cuando el <usuario> introduce sus <credenciales> y solicita ver los <datos sensibles>,
        Entonces el sistema bloquea el acceso, registra el intento en el <historial de seguridad>
        y muestra un aviso indicando que el dispositivo no está autorizado.

        Examples: Datos de entrada  
        | usuario        | rol           | dispositivo             | estado del dispositivo | acción                |
        | Beatriz López  | Administrador | Laptop personal nueva    | No verificado          | Solicita acceso a datos |

        Examples: Datos de salida  
        | acceso concedido | mensaje mostrado                               | registro en historial                    |
        | No               | “Dispositivo no autorizado, acceso bloqueado”  | Intento registrado con fecha y hora       |

//HU-30S
Feature: Actualizaciones de seguridad automáticas
  Como usuario,
  quiero que la aplicación reciba actualizaciones de seguridad automáticas,
  para protegerme de vulnerabilidades sin hacer nada manual.

  Scenario Outline: Escenario 1 - Actualización automática
    Dado que hay una <nueva versión de seguridad disponible>,
    Y el <dispositivo> tiene <conexión a internet> activa,
    Cuando el <usuario> abre la <aplicación> o conecta su <dispositivo>,
    Entonces la <aplicación> descarga e instala automáticamente la <actualización de seguridad>,
    Y muestra un <mensaje de confirmación> indicando que el sistema está actualizado.

    Examples: Datos de entrada
      | usuario         | versión disponible | conexión a internet | estado inicial del sistema |
      | Pedro López     | v3.2.1             | Conectado           | Versión anterior v3.1.9    |

    Examples: Datos de salida
      | actualización instalada | versión final | mensaje en pantalla                  |
      | Sí                      | v3.2.1        | “Seguridad actualizada correctamente” |

  Scenario Outline: Escenario 2 - Aviso de actualización manual
    Dado que la <aplicación> detecta una <actualización pendiente> pero no puede actualizarse automáticamente,
    Y el <usuario> abre la <aplicación> con conexión limitada o permisos restringidos,
    Cuando el <usuario> accede al <inicio> de la aplicación,
    Entonces el sistema muestra una <notificación> solicitando actualización manual,
    Y ofrece el botón “Actualizar ahora”.

    Examples: Datos de entrada
      | usuario       | conexión a internet | permisos del sistema | versión disponible | acción del usuario |
      | María Torres  | Limitada            | Restrictivos         | v3.2.1             | Abre la aplicación |

    Examples: Datos de salida
      | actualización automática | mensaje mostrado                            | acción disponible  |
      | No                       | “Actualización pendiente. Presione actualizar.” | Botón “Actualizar ahora” |

  Scenario Outline: Escenario 3 - Registro de actualizaciones
    Dado que el <usuario> desea consultar el historial de actualizaciones de seguridad,
    Cuando el <usuario> navega a <Configuración > Seguridad>,
    Entonces el sistema muestra la <lista de actualizaciones aplicadas> con su <fecha y versión> correspondientes.

    Examples: Datos de entrada
      | usuario       | acción del usuario                  | actualizaciones registradas          |
      | Javier Ramos  | Accede a Configuración > Seguridad  | v3.2.1 (10/11/2025), v3.1.9 (01/09/2025) |

    Examples: Datos de salida
      | historial visible                            | última actualización |
      | Sí, se muestran 2 registros con fechas y versiones | v3.2.1 (10/11/2025)  |

  Scenario Outline: Escenario 4 - Compatibilidad de versiones
    Dado que el sistema ha completado una <actualización de seguridad>,
    Cuando el <usuario> reinicia la <aplicación> o instala manualmente la nueva versión,
    Entonces la aplicación verifica la <compatibilidad> entre la versión instalada y el sistema actual,
    Y muestra un <resultado de verificación>.

    Examples: Datos de entrada
      | usuario        | versión instalada | versión del sistema | acción posterior      |
      | Laura Gutiérrez | v3.2.1            | Android 14          | Reinicia la aplicación |

    Examples: Datos de salida
      | verificación de compatibilidad | mensaje mostrado                     |
      | Compatible                     | “Versión compatible con su sistema.” |
