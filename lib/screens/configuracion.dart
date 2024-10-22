/**
 * Pantalla de configuración.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

/*Pantalla para la configuracion de la aplicacion para el usuario */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/pantalla_entrada.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  _ConfiguracionState createState() =>  _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion>{
@override
//Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
    final ancho= MediaQuery.of(context).size; //variable para calcular el ancho de la pantalla
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(233, 214, 204, 1), 
          leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => PantallaEntrada())
            );
          }, 
          ),
          title: Row( //Titulo de la pantalla
            children: [
              SizedBox(width: ancho.width * 0.12),
              Text("Configuración",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.135),
              Image.asset("assets/images/logo.png",
               width: 45, 
               height: 45
               ),
            ],
          ),
        ),
        body: const Center( //Cuerpo de la pantalla
          child: Text('Configuración'),
        ),
      );
  }
}