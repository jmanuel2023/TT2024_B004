import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:skincanbe/screens/MenuPrincipal/Paciente/CapturaDeImagen/DisplayPicture.dart';

class ImageCropScreen extends StatefulWidget {
  final XFile imageFile;

  ImageCropScreen({required this.imageFile});

  @override
  _ImageCropScreenState createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  Color _colorFondo = Color.fromRGBO(204, 87, 54, 1);
  Color _colorLetra = Color.fromRGBO(255, 255, 255, 1);


 String? id;
  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    id = await storage.read(key: "idUsuario");
    _mensajesAyuda();
    
  }

  void _mensajesAyuda() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: _colorFondo,
          title: Text(
            'Pantalla de recorte',
            style: TextStyle(
              color: _colorLetra,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Por favor, presione el boton Recortar imagen, que se encuentra en la parte central superior.',
            style: TextStyle(
              color: _colorLetra,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Siguiente',
                style: TextStyle(
                  color: _colorLetra,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // _mensajeAdvertencia();
              },
            ),
          ],
        );
      },
    );
  }
  // Recortar la imagen seleccionada
  Future<void> _cropImage() async {
    print(widget.imageFile.path);
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.imageFile.path,
      // Define la relación de aspecto directamente dentro del cropper
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1), // Relación de aspecto cuadrada
      maxWidth: 800,  // Maximo ancho de la imagen recortada
      maxHeight: 800, // Máximo alto de la imagen recortada
      compressFormat: ImageCompressFormat.jpg,  // Formato de compresión
      compressQuality: 90,  // Calidad de la imagen
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar imagen',
          toolbarColor: _colorFondo,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square, // Relación inicial
          lockAspectRatio: true, // Bloquear relación de aspecto
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0, // Relación mínima de la imagen recortada
        ),
      ],
    );

    if (croppedFile != null) {
      // Si la imagen fue recortada, la pasamos a la pantalla DisplayPicture
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPicture(
            imagen: XFile(croppedFile.path),
            id: id ?? "", // Puedes pasar el ID si lo necesitas
          ),
        ),
      );
    } else {
      // Si no se recortó, se pasa la imagen original a la pantalla DisplayPicture
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPicture(
            imagen: widget.imageFile,
            id: id ?? "",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        title: Text(
          'Recortar imagen', // Texto centrado
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
            Image.file(File(widget.imageFile.path)), // Mostrar la imagen seleccionada
            Center(
              child: ElevatedButton(
                onPressed: _cropImage,
                child: Text('Recortar imagen'),
              ),
            ),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
