import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/PatientScreen.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/CapturaDeImagen/compartirReporte.dart';

class InformacionLesion extends StatefulWidget {
  final String? nombreLesion;
  final String? descripcion;
  final XFile? imagen;
  final String? idLesion;

  InformacionLesion(
      {this.nombreLesion, this.descripcion, this.imagen, this.idLesion});

  @override
  _InformacionLesionState createState() => _InformacionLesionState();
}

class _InformacionLesionState extends State<InformacionLesion> {
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context)
        .size; //Variable para calcular el tamaño de pantalla
    return Scaffold(
        body: Center(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: ancho.height * 0.15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(233, 214, 204, 1),
            Color.fromRGBO(230, 226, 224, 1)
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                "Estimado paciente:",
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
                "El análisis que se hizo con el algoritmo de Skincanbe, indica que la lesion que se capturó es de tipo:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.nombreLesion!,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(221, 30, 2, 107),
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
                textAlign: TextAlign.justify,
              ),
              Center(
                child: ClipOval(
                    child: Image.file(File(widget.imagen!.path),
                        height: 150, width: 150, fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                height: 90,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 189, 187, 187),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      //Aqui se le da un estilo al container que contendra los botones
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 15,
                          offset: Offset(0, 10))
                    ]),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("Regresar"),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PantallaEntrada()));
                        }),
                    SizedBox(width: 40),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("Generar reporte"),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompartirReporte(
                                      id_lesion: widget.idLesion, tipo_lesion: widget.nombreLesion,)));
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
