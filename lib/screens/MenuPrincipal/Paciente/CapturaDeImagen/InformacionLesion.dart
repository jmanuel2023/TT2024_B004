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
  final String? porcentaje;

  InformacionLesion(
      {this.nombreLesion,
      this.descripcion,
      this.imagen,
      this.idLesion,
      this.porcentaje});

  @override
  _InformacionLesionState createState() => _InformacionLesionState();
}

class _InformacionLesionState extends State<InformacionLesion> {
  @override
  Widget build(BuildContext context) {
    final anchoPantalla = MediaQuery.of(context).size.width;
    final largoPantalla = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(233, 214, 204, 1),
          title: Text(
            'Resultados', // Texto centrado
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true, // Asegura que el título esté centrado
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent, // Fondo transparente
                child: Image.asset(
                  "assets/images/logo.png", // Ruta del logo
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: largoPantalla * 0.08),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(233, 214, 204, 1),
                  Color.fromRGBO(230, 226, 224, 1)
                ]),
              ),
              child: Column(
                children: [
                  Text(
                    "Estimado paciente:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color:  Color.fromRGBO(204, 87, 54, 1),
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "El análisis que  hizo el algoritmo de Skincanbe, indica que la lesión que capturo es de tipo:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color:  Color.fromRGBO(204, 87, 54, 1),
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.nombreLesion!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Con un porcentaje de confianza del",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color:  Color.fromRGBO(204, 87, 54, 1),
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.porcentaje!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Descripción de la lesión: ${widget.descripcion!}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color:  Color.fromRGBO(204, 87, 54, 1),
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: anchoPantalla * 0.9,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 189, 187, 187),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          //Aqui se le da un estilo al container que contendra los botones
                          BoxShadow(
                              color:  Color.fromRGBO(204, 87, 54, 1),
                              blurRadius: 15,
                              offset: Offset(0, 10))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                "Regresar",
                                style: TextStyle(fontSize: 16, color:  Color.fromRGBO(204, 87, 54, 1)),
                              ),
                              color: Color.fromRGBO(255, 255, 255, 1),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaEntrada()));
                              }),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                "Generar reporte",
                                style: TextStyle(fontSize: 16),
                              ),
                              color:  Color.fromRGBO(204, 87, 54, 1),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CompartirReporte(
                                            id_lesion: widget.idLesion,
                                            tipo_lesion: widget.nombreLesion,
                                            porcentaje: widget.porcentaje)));
                              }),
                        ),
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
