import 'package:flutter/material.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/registro.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkinCanBe',
      routes: {
        'Pantalla1': (_) => PantallaPrincipal(),
        'Pantalla2': (_) => Registrarse(),
        'Pantalla3': (_) => InicioDeSesion(),
      },
      initialRoute: 'Pantalla1',


    );
  }
}