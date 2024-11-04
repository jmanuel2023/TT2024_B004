import 'package:flutter/material.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/Registro/registro.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import 'package:skincanbe/screens/InicioDeSesion/resetPassword.dart';
import 'package:skincanbe/data/constantes.dart';

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
  String? token;

  @override
  void initState() {
    super.initState();
   token=null;
   _lastProcessedLink= null;
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() async {
    final initialLink = await _appLinks.getInitialLinkString();
    print("Initial link: $initialLink"); 
    if(initialLink != null && initialLink != _lastProcessedLink){
      _navigateToDeepLinkScreen(initialLink);
    }

  _appLinks.getLatestLinkString().then((String? deepLink) {
    if (deepLink != null && deepLink != _lastProcessedLink)  {
      _navigateToDeepLinkScreen(deepLink);
    }
  });
  }


  void _navigateToDeepLinkScreen(String deepLink) async {
    _lastProcessedLink = deepLink;
    token=null;
    Uri uri = Uri.parse(deepLink);
    String? path = uri.path;
    token = uri.queryParameters['token'];


    // Navega a la pantalla correspondiente según la ruta
    if (path == '/validar' && token != null) {
      // Realiza la petición HTTP al backend
      final response = await http.get(
        Uri.parse(metodo+ip+puerto+'/validar?token=$token'), 
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
    }else if(path == '/reset-password' && token != null) {
      print("Si entro a la ruta reset-password");
      navigatorKey.currentState?.pushReplacementNamed('resetPassword', arguments: token);
      _lastProcessedLink = null;
      print(_lastProcessedLink);
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
        'resetPassword': (context) {
        // Extraer el argumento de la ruta
        final String token = ModalRoute.of(context)!.settings.arguments as String;
        return ResetPassword(token: token);
      },},
      initialRoute: 'Pantalla1', // Puedes ajustar esta pantalla si lo necesitas
    );
  }
}
