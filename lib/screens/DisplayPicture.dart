import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Foto confirmada")));
                        final lesionService = LesionServices();
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
