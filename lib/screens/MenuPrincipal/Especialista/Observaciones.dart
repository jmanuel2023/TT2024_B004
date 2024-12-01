import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Especialista/PatientCatalog.dart';
import 'package:skincanbe/screens/MenuPrincipal/Especialista/SpecialistScreen.dart';
import 'package:skincanbe/services/peticionesHttpLesion/LesionServices.dart';

class AgregarObservacionScreen extends StatefulWidget {
  final int id_lesion;
  AgregarObservacionScreen({required this.id_lesion});

  @override
  State<AgregarObservacionScreen> createState() =>
      _AgregarObservacionScreenState();
}

class _AgregarObservacionScreenState extends State<AgregarObservacionScreen> {
  final TextEditingController _observacionController = TextEditingController();
  String? token;
  String? id;
  String? nombre;
  String? apellidos;
  String? correo;
  List<dynamic> observaciones = []; // Lista para almacenar las observaciones
  bool cargando = false;


  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    setState(() {
      cargando = true;
    });
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
      final historial = await lesionServicio.obtenerHistorialObservaciones(
          token!, widget.id_lesion, id!);

      setState(() {
        observaciones = historial
            .map((observacionJson) => {
                  'descripcion': observacionJson['descripcion'],
                  'fecha': observacionJson['fecha']
                })
            .toList();
      });
    } catch (e) {
      print('Error al cargar el historial: $e');
    }
    finally{
      setState(() {
        cargando = false;
      });
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialistScreen())); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          'Agregar observación', // Texto centrado
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de Observación
            Text(
              'Observación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _observacionController,
              maxLines: 5, // Permite múltiples líneas
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe la observación aquí',
              ),
            ),
            SizedBox(height: 20.0),
            // Botón de Enviar al Paciente
            ElevatedButton(
              onPressed: () async {
                final observacion = _observacionController.text;
                final lesionServicio = LesionServices();
                if (observacion.isNotEmpty) {
                  try {
                    final mensaje = await lesionServicio.agregarObservacion(
                        token!, widget.id_lesion, observacion, id!);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(mensaje)));
                    _observacionController.clear(); // Limpiar el campo de texto
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientCatalog()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error al enviar la observacion")));
                  }
                } else {
                  // Mensaje de error si el campo está vacío
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Por favor, ingresa una observación')),
                  );
                }
              },
              child: Text('Enviar al Paciente'),
            ),
            SizedBox(height: 20.0),
            // Historial de Observaciones
            Text(
              'Historial de Observaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: cargando ? Center(child: CircularProgressIndicator(color:  Color.fromRGBO(204, 87, 54, 1)),)
              : observaciones.isEmpty ? Center(
                child: Text("No hay observaciones para esta lesión",
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                )
              : ListView.builder(
                itemCount: observaciones.length,
                itemBuilder: (context, index) {
                  final observacion = observaciones[index];
                  return Card(
                    color: Color.fromRGBO(204, 87, 54, 1),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Observación ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color:  Color.fromRGBO(255,255,255,1)),),
                      subtitle: Column(
                        children: [
                          Text(observacion['descripcion'],style: TextStyle(fontWeight: FontWeight.w300, color:  Color.fromRGBO(255,255,255,1))),
                          Text(observacion['fecha'], style: TextStyle(fontWeight: FontWeight.w400, color:  Color.fromRGBO(255,255,255,1)))
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
