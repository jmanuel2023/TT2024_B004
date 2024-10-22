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
import 'package:skincanbe/screens/perfil.dart';


/*En esta pantalla, se muestran todas las funcionalidades que tiene la aplicacion, ya sea informacion, acceeso a la camara 
para un posterior analisis, historial de lesiones, opciones de configuracion,etc.*/

class PantallaEntrada extends StatefulWidget {
  final String? nombre;
  final String? apellidos;
  final String? correo;

  PantallaEntrada({this.nombre, this.apellidos, this.correo});

  @override
  _PantallaEntradaState createState() => _PantallaEntradaState(); 
  }

  class _PantallaEntradaState extends State<PantallaEntrada>{
  final PageController pageController = PageController(initialPage: 0); //Aqui se declara una variable que va tener el valor de initialPage 0
  int _selectIndex =0; //variable que posteriormente nos va servir para hacer el cambio de pantalla.
  CameraController? _cameraController; //Aqui se declara una variable que tiene dos cosas a destacar,primeramente viene de una clase CameraConroller,la cual se ocupa para controlar la camara del  dispositivo movil, ademas esta variable tiene un signo de interrogacin (?), el cual indica que esta variable puede ser null, y por ultimo, el guion bajo en el nombre de la variable, indica que es una variable privada y que solo puede ser accedida dentro de esta misma clase.
  bool _isCameraInitialized = false; //Variable inicializada en false,que pronto nos va servir.
  XFile? _imageFile; //Variable que va guardar donde se va a guardar la imagen capturada de la camara.

  @override
  void dispose() { //Esta funcion se ocupa para liberar recursos de que ya no se usan,por ejemplo, la conexion con el hardware de la camara
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _openCamera() async { //Funcion asincrona, que se acompletara con o sin exito en un futuro,la cual  no devolvera ningun valor.
    //AQUI SE SOLICITA LOS PERMISOS DE LA CAMARA
    var status = await Permission.camera.request();
    if(status.isGranted){
      //AQUI SE OBTIENE LAS CAMARAS DISPONIBLES
      final camaras = await availableCameras();
      _cameraController = CameraController(camaras[0], ResolutionPreset.high);
      //AQUI SE INICIALIZA LA CAMARA
      await _cameraController?.initialize();
      setState(() {
        _isCameraInitialized = true; //Cambia el valor de esta variable
      });
    } else {
      //AQUI SE MANEJA EL CASO DE QUE EL USUARIO DENEGUE LOS PERMISOS DEL USO DE LA CAMARA
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Permisos de la cámara DENEGADOS")),);
    }
  }

  //Funcion para capturar la imagen
  Future<void> _captureImage() async { //Funcion asincrona que se acompletara con o sin exito en un futuro,la cual no devolvera ningun valor.
    if (_cameraController != null && _isCameraInitialized) { //En esta condicion,nos indica que en el caso de que la variable _cameraController sea diferente de nulo y ademas de que la variable _isCameraInitialized sea verdadera, hara lo siguente
      try { //Dentro de un try-catch, se guardara en un variable, la captura que el usuario tome con la camara.
        XFile image = await _cameraController!.takePicture();
        setState (() {
          _imageFile = image; //Aqui se guarda en una variable el  valor de otra, para poder utilizarla despues
        });
        print("Imagen guardada en: ${_imageFile!.path}");
        //MENSAJE SI LA FOTOGRAFIA ES TOMADA CON EXITO O NO
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Foto tomada con exito")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al tomar la foto: $e")),
        );
      }
    }
  }
  
//Aqui es donde se encuentra todo el contenido que tendra la pantalla
    @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size;
    return Scaffold(
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
            Perfil(nombre: widget.nombre!, apellidos: widget.apellidos!,correo: widget.correo!)
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

  
