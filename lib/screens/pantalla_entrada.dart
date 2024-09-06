/**
 * Pantalla de entrada a la aplicacion.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skincanbe/screens/historialLesion.dart';
import 'package:skincanbe/screens/infopiel.dart';
//import 'package:skincanbe/screens/pantallacarga.dart';
import 'package:skincanbe/screens/perfil.dart';

void main() => runApp(const PantallaEntrada());

class PantallaEntrada extends StatefulWidget {
  const PantallaEntrada({super.key});

  @override
  _PantallaEntradaState createState() => _PantallaEntradaState(); 
  }

  class _PantallaEntradaState extends State<PantallaEntrada>{
  final PageController pageController = PageController(initialPage: 0);
  late int _selectIndex =0;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  XFile? _imageFile;

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _openCamera() async {
    //AQUI SE SOLICITA LOS PERMISOS DE LA CAMARA
    var status = await Permission.camera.request();
    if(status.isGranted){
      //AQUI SE OBTIENE LAS CAMARAS DISPONIBLES
      final camaras = await availableCameras();
      _cameraController = CameraController(camaras[0], ResolutionPreset.high);
      //AQUI SE INICIALIZA LA CAMARA
      await _cameraController?.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } else {
      //AQUI SE MANEJA EL CASO DE QUE EL USUARIO DENEGUE LOS PERMISOS DEL USO DE LA CAMARA
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Permisos de la cámara DENEGADOS")),);
    }
  }

  //Funcion para capturar la imagen
  Future<void> _captureImage() async {
    if (_cameraController != null && _isCameraInitialized) {
      try {
        XFile image = await _cameraController!.takePicture();
        setState (() {
          _imageFile = image;
        });
        print("Imagen guardada en: ${_imageFile!.path}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Foto tomada con exito")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al tomar la foto: $e")),
        );
      }
    }
  }
  

    @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size;
    return Scaffold(
        /*appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(width: ancho.width * 0.79),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
        ),*/
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            if(index == 1 && !_isCameraInitialized) {
              //EN ESTE PASO ES DONDE SE ABRE LA CAMARA CUANDO EL USUARIO ELIJA LA OPCION DE LA CAMARA
              _openCamera();
            }
          },
          children: [
            InfoPiel(),
            Stack(children: [
            _isCameraInitialized 
            ? CameraPreview(_cameraController!)
            : Center(child: CircularProgressIndicator()),
            Positioned(
              bottom: 20,
              left: ancho.width / 2 - 30,
              child: FloatingActionButton(
              onPressed: _isCameraInitialized ? _captureImage : null,
              child: Icon(Icons.camera_alt),))
          ]),
            Historial(),
            Perfil()
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        selectedItemColor: Color.fromARGB(255, 87, 86, 86),
        unselectedItemColor: Color.fromARGB(255, 19, 20, 20),
        onTap: (index){
          setState(() {
          _selectIndex=index;
          pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Información'),
          BottomNavigationBarItem(icon:Icon(Icons.camera), label: 'Cámara'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil') 
        ],),
      );
  }
  }

  
