import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/InformacionLesion.dart';
import 'package:skincanbe/services/LesionServices.dart';

class DisplayPicture extends StatefulWidget {
  final XFile imagen;
  final String id;

  DisplayPicture({required this.imagen, required this.id});

  @override
  _DisplaypictureState createState() => _DisplaypictureState();
}

class _DisplaypictureState extends State<DisplayPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Foto tomada")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Se muestra la imagen que se capturo
          Expanded(
              child: Center(
            child: Image.file(File(widget.imagen.path)),
          )),
          Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text("Confirmar"),
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.green,
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Foto confirmada")));
                            /** AQUI VA LA API */
                        final lesionService = LesionServices();
                        final String nombreLesion = "Nevo melanocitico";
                        final String descripcion =
                            "Lesion beningna, la cual es un parche de piel de color oscuro y a menudo velludo.";
                        try {
                          // Llamar al servicio para registrar la lesión
                          final data = await lesionService.registrarLesion(
                              widget.id,
                              widget.imagen,
                              nombreLesion,
                              descripcion);
                          print(data['id_lesion']);
                          // Verificar si data no es nulo y contiene los datos esperados
                          if (data['id_lesion'] != null) {
                            // Asegúrate de que 'id' sea una clave que esperas en la respuesta
                            print("LESION REGISTRADA CORRECTAMENTE");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Lesión registrada correctamente")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InformacionLesion(
                                        nombreLesion: nombreLesion,
                                        descripcion: descripcion,
                                        imagen: widget.imagen,
                                        idLesion: data['id_lesion'].toString())));
                          } else {
                            print("NO SE HA PODIDO GUARDAR LA LESION");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("No se ha podido guardar la lesión")));
                          }
                        } catch (e) {
                          // Manejo de excepciones para errores que puedan ocurrir al registrar la lesión
                          print("Error al registrar la lesión: $e");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Error al registrar la lesión: ${e.toString()}")));
                        }
                      },
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        label: Text("Volver a tomar"),
                        style: ElevatedButton.styleFrom(
                          iconColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ]))
        ],
      ),
    );
  }
}
