/**
 * PantalLa de Informacion sobre la aplicacion.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/pantalla_entrada.dart';
//import 'package:skincanbe/screens/perfil.dart';

void main() => runApp(const InformacionApp());

class InformacionApp extends StatefulWidget {
  const InformacionApp({super.key});

  @override
  _InformacionAppState createState() =>  _InformacionAppState();
}

class _InformacionAppState extends State<InformacionApp>{
@override
  Widget build(BuildContext context) {
    final ancho= MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(233, 214, 204, 1), 
          leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => PantallaEntrada())
            );
          }, //iconSize: 35,
          ),
          title: Row(
            children: [
              SizedBox(width: ancho.width * 0.01),
              Text("Información de la App",
              style: TextStyle(fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.026),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
        ),
        body: const Center(
          child: Text('Inforrmacion de la aplicacion'),
        ),
      );
  }
}