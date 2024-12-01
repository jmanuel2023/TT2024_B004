import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/services/peticionesHttpLesion/LesionServices.dart';

class PantallaObservaciones extends StatefulWidget {
  final int id_lesion;
  PantallaObservaciones({required this.id_lesion});

  @override
  State<PantallaObservaciones> createState() => _PantallaObservacionesState();
}

class _PantallaObservacionesState extends State<PantallaObservaciones> {
  List<dynamic> observaciones = [];

  String? token;

  String? id;

  String? nombre;

  String? apellidos;

  String? correo;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    id = await storage.read(key: "idUsuario");
    nombre = await storage.read(key: "nombre");
    apellidos = await storage.read(key: "apellidos");
    correo = await storage.read(key: "correo");
    _cargarHistorialObservaciones(); // Cargar el historial de observaciones
  }

  Future<void> _cargarHistorialObservaciones() async {
    try {
      final lesionServicio = LesionServices();
      final historial = await lesionServicio.historialObservacionConUsuario(
          token!, widget.id_lesion);

      setState(() {
        observaciones = historial
            .map((observacionJson) => {
                  'descripcion': observacionJson['descripcion'],
                  'fecha': observacionJson['fecha'],
                  'nombreUsuario': observacionJson['nombreUsuario'],
                  'apellidoUsuario': observacionJson['apellidoUsuario']
                })
            .toList();
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          'Historial de observaciones', // Texto centrado
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: observaciones.isEmpty
            ? Center(
                child: Text(
                  'No hay observaciones disponibles',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: observaciones.length,
                      itemBuilder: (context, index) {
                        final observacion = observaciones[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Observación ${index + 1}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Descripción: ${observacion['descripcion']}'),
                                Text('Fecha: ${observacion['fecha']}'),
                                Text(
                                  'Usuario: ${observacion['nombreUsuario']} ${observacion['apellidoUsuario']}',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
