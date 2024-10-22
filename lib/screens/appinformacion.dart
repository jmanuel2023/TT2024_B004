/**
 * Pantalla sobre información de la aplicacion
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

/*Pantalla para mostrar informacion acerca de la aplicación */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/pantalla_entrada.dart';


class InformacionApp extends StatefulWidget {
  const InformacionApp({super.key});

  @override
  _InformacionAppState createState() =>  _InformacionAppState();
}

class _InformacionAppState extends State<InformacionApp>{

@override
//Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
    final ancho= MediaQuery.of(context).size; //variable para calcular el ancho de la pantalla
    return Scaffold(
        appBar: AppBar( //Widget para la barra superior de la aplicación
          backgroundColor: Color.fromRGBO(233, 214, 204, 1), 
          leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => PantallaEntrada()) //Clase para la navegación entre pantallas
            );
          },
          ),
          title: Row( //Titulo de la pantalla
            children: [
              SizedBox(width: ancho.width * 0.01),
              Text("Información de la App",
              style: TextStyle(fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.026),
              Image.asset("assets/images/logo.png", width: 45, height: 45), //Imagen alojada en el path indicado
            ],
          ),
        ),
        body: const Center( //Cuerpo de la pantalla
          child: Text('Información de la aplicacion'),
        ),
      );
  }
}