import 'package:flutter/material.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/registro.dart';
import 'package:app_links/app_links.dart';
 import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String? _lastProcessedLink;

  @override
  void initState() {
    super.initState();
   // _appLinks = AppLinks();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() async {
    final initialLink = await _appLinks.getInitialLinkString();
    //print("Initial link: $initialLink"); 
    if(initialLink != null && initialLink != _lastProcessedLink){
      _navigateToDeepLinkScreen(initialLink);
    }

  _appLinks.getLatestLinkString().then((String? deepLink) {
    //print("Latest link: $deepLink");  // Para depuración
    if (deepLink != null && deepLink != _lastProcessedLink)  {
      _navigateToDeepLinkScreen(deepLink);
    }
  });
  }


  void _navigateToDeepLinkScreen(String deepLink) async {
    _lastProcessedLink = deepLink;
    Uri uri = Uri.parse(deepLink);
    String? path = uri.path;
    String? token = uri.queryParameters['token'];

    //print("Navigating to path: $path with token: $token");  // Para depuración


    // Navega a la pantalla correspondiente según la ruta
    if (path == '/validar' && token != null) {
      // Realiza la petición HTTP al backend
      final response = await http.get(
        Uri.parse('http://192.168.100.63:8080/validar?token=$token'), 
      );

      if (response.statusCode == 200) {
        // Validación exitosa, navegar a la pantalla correspondiente
        print("Validación exitosa: ${response.body}");
        navigatorKey.currentState?.pushReplacementNamed('Pantalla3');
      } else {
        // Hubo un error en la validación
        print("Error en la validación: ${response.body}");
      }
    } else {
      print("Token no válido o ruta incorrecta");
    }
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
      },
      initialRoute: 'Pantalla1', // Puedes ajustar esta pantalla si lo necesitas
    );
  }
}
