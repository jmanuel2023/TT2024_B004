import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/PatientScreen.dart';

class InformacionLesion extends StatefulWidget {
  final String? nombreLesion;
  final String? descripcion;
  final XFile? imagen;
  InformacionLesion({this.nombreLesion, this.descripcion, this.imagen});

  @override
  _InformacionLesionState createState() => _InformacionLesionState();
}

class _InformacionLesionState extends State<InformacionLesion> {
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context)
        .size; //Variable para calcular el tamaño de pantalla
    return Scaffold(
        appBar: AppBar(
          //Widget para el diseño de la barra superior de la pantalla
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PantallaEntrada()));
            },
          ),
          title: Row(
            //Titulo de la pantalla
            children: [
              SizedBox(width: ancho.width * 0.64),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
          backgroundColor: Colors.grey,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: ancho.height * 0.15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFBDBDBD), Color(0xFF616161)]),
            ),
            child: Column(
              children: [
                Text(
                  "Estimado Paciente: El análisis que se hizo con el algoritmos de Skincanbe, nos indico que la lesion que capturo es de tipo:",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.nombreLesion!,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  widget.descripcion!,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: ClipOval(
                      child: Image.file(File(widget.imagen!.path),
                          height: 150, width: 150, fit: BoxFit.cover)),
                ),
              ],
            ),
          ),
        ));
  }
}
