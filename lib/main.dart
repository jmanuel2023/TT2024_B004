import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/Registro/registro.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import 'package:skincanbe/screens/InicioDeSesion/resetPassword.dart';
import 'package:skincanbe/data/constantes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Mexico_City'));

  // Configura las notificaciones para Android (y para iOS si fuera necesario)
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String? _lastProcessedLink;
  String? token;

  @override
  void initState() {
    super.initState();
    token = null;
    _lastProcessedLink = null;
    _handleIncomingLinks();
    // Configurar el canal de notificaciones
    configurarCanalNotificacion();

    // Solicita los permisos de notificación en Android 13+ (API 33)
    _solicitarPermisos();
    mostrarNotificacionInmediata();
    _programarNotificacionDiaria();
  }

  // Solicitar permisos de notificación en dispositivos Android 13+ (API 33)
Future<void> _solicitarPermisos() async {
  final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission() ??
      false;

  if (!granted) {
    print('Permiso de notificaciones no concedido');
  }
}

void configurarCanalNotificacion() async {
  const AndroidNotificationChannel canal = AndroidNotificationChannel(
    'tu_id_diario', // ID único del canal
    'Recordatorio Diario: Recordatorio para revisar manchas o lunares. Pruebas2', // Nombre del canal
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

  void _handleIncomingLinks() async {
    final initialLink = await _appLinks.getInitialLinkString();
    print("Initial link: $initialLink");
    if (initialLink != null && initialLink != _lastProcessedLink) {
      _navigateToDeepLinkScreen(initialLink);
    }

    _appLinks.getLatestLinkString().then((String? deepLink) {
      if (deepLink != null && deepLink != _lastProcessedLink) {
        _navigateToDeepLinkScreen(deepLink);
      }
    });
  }

  void _navigateToDeepLinkScreen(String deepLink) async {
    _lastProcessedLink = deepLink;
    token = null;
    Uri uri = Uri.parse(deepLink);
    String? path = uri.path;
    token = uri.queryParameters['token'];

    // Navega a la pantalla correspondiente según la ruta
    if (path == '/validar' && token != null) {
      // Realiza la petición HTTP al backend
      final response = await http.get(
        Uri.parse(metodo + ip + puerto + '/validar?token=$token'),
      );

      if (response.statusCode == 200) {
        // Validación exitosa, navegar a la pantalla correspondiente
        _lastProcessedLink = null;
        print("Validación exitosa: ${response.body}");
        navigatorKey.currentState?.pushReplacementNamed('Pantalla3');
      } else {
        // Hubo un error en la validación
        print("Error en la validación: ${response.body}");
      }
    } else if (path == '/reset-password' && token != null) {
      print("Si entro a la ruta reset-password");
      navigatorKey.currentState
          ?.pushReplacementNamed('resetPassword', arguments: token);
      _lastProcessedLink = null;
      print(_lastProcessedLink);
    } else {
      print("Token no válido o ruta incorrecta");
    }
  }

  Future<void> mostrarNotificacionInmediata() async {
  print('Mostrando notificación inmediata');

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
    print('Notificación programada para: $programacion');
    return programacion;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkinCanBe',
      navigatorKey: navigatorKey,
      routes: {
        'Pantalla1': (_) => PantallaPrincipal(),
        'Pantalla2': (_) => Registrarse(),
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
