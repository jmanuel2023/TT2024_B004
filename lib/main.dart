import 'package:flutter/material.dart'; //Libreria propia de Flutter, para hacer uso de las diferentes tipos de pantallas
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; //Libreria para el uso de notificaciones locales en Flutter
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart'; //Libreria que importa la pantalla de inicio de sesión.
import 'package:skincanbe/screens/pantalla_principal.dart'; //Libreria que importa la pantalla de pantalla principal.
// import 'package:skincanbe/screens/Registro/registro.dart'; //Libreria que importa la pantalla de Registro.
import 'package:app_links/app_links.dart'; //Libreria que nos permite hacer uso de los app links en Flutter //Concepto:Deep Linking
import 'package:skincanbe/screens/InicioDeSesion/resetPassword.dart'; //Libreria que importa la pantalla de resetPassword.
import 'package:http/http.dart' as http; //Libreria que nos permite hacer uso de HTTP
import 'package:skincanbe/data/constantes.dart'; //Libreria que nos importa el archivo de constantes.
import 'package:timezone/data/latest.dart' as tz; //Libreria que nos importa la zona horaria del dispositivo.
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin(); //Variable para inicializar el uso de Notificaciones Locales

//Desde este punto la aplicacion inicia.
void main() async {

  /**Esta linea nos ayuda a asegurarnos que los binding (integracion entre el codigo Flutter y el 
   * framework subyaciente de la plataforma) esten completamente inicializados antes de continuar
   * la ejecucion.*/
  WidgetsFlutterBinding.ensureInitialized(); 

  //Inicializa la biblioteca timezone de Flutter, que nos permite trabajar con zonas horarias.
  tz.initializeTimeZones();
  /**Primero se establece la ubicacion de la zona horaria y luego se configura la zona horaria local de para la aplicación. */
  tz.setLocalLocation(tz.getLocation('America/Mexico_City'));

  // Configura las notificaciones para Android 
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  //Se especifican las configuracion de Android
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  //Se iniciliza el plugin de notificaciones locales, utilizando los parametros de configuracion de Android definidos arriba. El await nos permite asegurarnos que la inicializacion de las notificaciones se complete antes de ejecutar el siguiente paso.
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //Se ejecuta la aplicacion Flutter y se monta el widget principal de la aplicacion (MyApp)
  runApp(const MyApp());
}


//Clase MyApp, widget principal de la aplicación //StatefulWidget indica que esta clase tiene widget que cambiaran de estado con el tiempo.
class MyApp extends StatefulWidget {
  const MyApp({super.key}); //Constructor para crear la instancia de MyApp

  @override //Decorador para indicar que la clase StatefulWidget se ets sobreescribiendo
  _MyAppState createState() => _MyAppState(); //Se declara la clase que se encargara de gestionar el estado de la clase principal
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks(); //se crea una instancia de la clase AppLinks para manejar los deep links
  /**Instancia para el uso de la navegacion desde la pantalla principal */
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); 
  String? _lastProcessedLink; //Variable para almacenar el ultimo token
  String? token; //Variable que almacena el token

  //Se sobreescribe un metodo, que pertence al ciclo de vida de una aplicacion.
  @override
  void initState() {
    super.initState(); //realiza las inicializaciones estandar y se asegura que se ejecuten correctamente
    token = null; //Cada vez que se inicializa la pantalla, se le da un valor de null al token
    _lastProcessedLink = null; //igual con esta variable, se le da un valor de null cuando se inicializa.
    //Metodo responsable de manejar los enlaces profundos que la aplicacion reciba
    _handleIncomingLinks(); 
    // Configurar el canal de notificaciones
    configurarCanalNotificacion();

    // Solicita los permisos de notificación en Android 13+ (API 33)
    _solicitarPermisos();
    //Metodo que se encargar de mostrar una notificacione inmediata a los usuarios.
    mostrarNotificacionInmediata();
    //Metodo que se encarga de mostrar una notificacion programada a una cierta hora.
    _programarNotificacionDiaria();
  }
 //Metodo que solicita permisos para mostar la notificacion en el dispositivo Android.
Future<void> _solicitarPermisos() async {
  final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission() ??
      false;

  if (!granted) {
    print("Permisos denegaods");
  }
}

//Metodo que configura un canal de notificacion especifico en Android
void configurarCanalNotificacion() async {
  const AndroidNotificationChannel canal = AndroidNotificationChannel(
    'tu_id_diario', // ID único del canal
    'Recordatorio Diario: Recordatorio para revisar manchas o lunares. Pruebas', // Nombre del canal
    importance: Importance.max, // Importancia máxima
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Registrar el canal de notificaciones
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(canal);
}
//Metodo que maneja los enlaces profundos (deep links) entrantes, de igual manera se asegura si la aplicacion recibe un enlace profundo
  void _handleIncomingLinks() async {
    //Se obtiene el enlace profundo inicial que abrio la aplicacion
    final initialLink = await _appLinks.getInitialLinkString();
    if (initialLink != null && initialLink != _lastProcessedLink) {
      _navigateToDeepLinkScreen(initialLink);
    }
//Obtiene el ultimo enlace profundo que recibido.
    _appLinks.getLatestLinkString().then((String? deepLink) {
      if (deepLink != null && deepLink != _lastProcessedLink) {
        _navigateToDeepLinkScreen(deepLink);
      }
    });
  }

//Metodo qe maneja la logica de navegacion basada en enlaces profundos (deep links).
  void _navigateToDeepLinkScreen(String deepLink) async {
    _lastProcessedLink = deepLink; //Se guarda el enlace profundo en la variable _lastProcessedLink
    token = null; //Se inicializa la variable token con el valor de null
    Uri uri = Uri.parse(deepLink); //Se convierte el enlace profundo a un objeto Uri que facilita la manipulacion y extraccion de partes del enlace
    String? path = uri.path; //Se extrae la ruta URL del enlace 
    token = uri.queryParameters['token']; //Se extrae el parametro token de la url

    // Navega a la pantalla correspondiente según la ruta
    if (path == '/validar' && token != null) {
      // Realiza la petición HTTP al backend
      final response = await http.get(
        Uri.parse(metodo + ip + puerto + '/validar?token=$token'),
      );

      if (response.statusCode == 200) {
        // Validación exitosa, navegar a la pantalla correspondiente
        _lastProcessedLink = null;
        navigatorKey.currentState?.pushReplacementNamed('Pantalla3');
      } 
    } else if (path == '/reset-password' && token != null) {
      navigatorKey.currentState
          ?.pushReplacementNamed('resetPassword', arguments: token);
      _lastProcessedLink = null;
    }
  }
//Metodo que muestra una notificacion inmediate a los usuarios.
  Future<void> mostrarNotificacionInmediata() async {
//Se llama al metodo del plugin, para mostrar una notificacion.
  await flutterLocalNotificationsPlugin.show(
    0,
    '¡Bienvendido a SkinCanBe',
    'Es grato tu presencia. Por favor, utilice los servicios que ofrece la aplicación',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'tu_id_diario',
        'Recordatorio Diario',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}

  


  // Función para programar una notificación diaria
  Future<void> _programarNotificacionDiaria() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Recordatorio de Chequeo',
      'Recuerda revisar cualquier mancha o lunar con la aplicación.',
      _proximaHoraDiaria(21,0),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'tu_id_diario',
          'Recordatorio Diario. Recordatorio para revisar manchas o lunares',
          channelDescription: 'Recordatorio para revisar manchas o lunares',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  tz.TZDateTime _proximaHoraDiaria(int hora, int minuto) {
    final tz.TZDateTime ahora = tz.TZDateTime.now(tz.local);
    tz.TZDateTime programacion = tz.TZDateTime(
        tz.local, ahora.year, ahora.month, ahora.day, hora, minuto);

    // Si la hora programada ya pasó para hoy, programarla para mañana
    if (programacion.isBefore(ahora)) {
      programacion = programacion.add(const Duration(days: 1));
    }
    return programacion;
  }

  @override
  //Metodo principal que construye la interfaz de usuario para el widget. EL parametro context es necesario para acceder a las propiedades de la jerarquia de widgets y para interactuar con otros elementos del arbol
  Widget build(BuildContext context) {
    return MaterialApp( //Widget de nivel superior que aplica el diseño de Material Design
      debugShowCheckedModeBanner: false, //Desactiva el banner de depuracion.
      title: 'SkinCanBe', //Define el titulo de la aplicación
      navigatorKey: navigatorKey, //Asocia la clave global para controlar la navegacion  globalmente, permitiendo, navegar desde fuera de la estructura de widgets o acceder a funciones de navegacion.
      routes: {
        'Pantalla1': (_) => PantallaPrincipal(), 
        'Pantalla3': (_) => InicioDeSesion(),
        'resetPassword': (context) {
          final String token =
              ModalRoute.of(context)!.settings.arguments as String;
          return ResetPassword(token: token);
        },
      },
      initialRoute: 'Pantalla1',
    );
  }
}
