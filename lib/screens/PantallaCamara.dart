import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skincanbe/screens/DisplayPicture.dart';

class PantallaCamara extends StatefulWidget {

  @override
  _PantallaCamaraState createState() => _PantallaCamaraState();
}

class _PantallaCamaraState extends State<PantallaCamara> {
  
  CameraController? _cameraController; //Aqui se declara una variable que tiene dos cosas a destacar,primeramente viene de una clase CameraConroller,la cual se ocupa para controlar la camara del  dispositivo movil, ademas esta variable tiene un signo de interrogacin (?), el cual indica que esta variable puede ser null, y por ultimo, el guion bajo en el nombre de la variable, indica que es una variable privada y que solo puede ser accedida dentro de esta misma clase.
  bool _isCameraInitialized = false; //Variable inicializada en false,que pronto nos va servir.
  XFile? _imageFile; //Variable que va guardar donde se va a guardar la imagen capturada de la camara.
  String? id;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    id = await storage.read(key: "idUsuario");

    _openCamera();

    setState(() {
      
    });
  }


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

        Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPicture(imagen: _imageFile!, id: id ?? "")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al tomar la foto: $e")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size;
    return Stack(
      children: [
        _isCameraInitialized ? CameraPreview(_cameraController!) : Center(child: CircularProgressIndicator()),
        Positioned(bottom: 20,
        left: ancho.width / 2 -30,
        child: FloatingActionButton(onPressed: _isCameraInitialized ? _captureImage: null,
        child: Icon(Icons.camera_alt),
        ),
        ),
      ],
    );
  }
}