/**
 * Pantalla de Politicas.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/PatientScreen.dart';
//import 'package:skincanbe/screens/perfil.dart';

void main() => runApp(const Politicas());

class Politicas extends StatefulWidget {
  const Politicas({super.key});

  @override
  _PoliticasState createState() =>  _PoliticasState();
}

class _PoliticasState extends State<Politicas>{
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
              SizedBox(width: ancho.width * 0.19),
              Text("Politicas",
              style: TextStyle(fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.21),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
        ),
        body: const Center(
          child: Text('Politicas'),
        ),
      );
  }
}