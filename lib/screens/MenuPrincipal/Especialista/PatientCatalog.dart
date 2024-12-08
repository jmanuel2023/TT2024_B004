/**
 * Pantalla de catalogo de pacientes (Especialista).
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/model/PacientesLesiones.dart';
import 'package:skincanbe/screens/MenuPrincipal/Especialista/Observaciones.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';

class PatientCatalog extends StatefulWidget {
  const PatientCatalog({super.key});

  @override
  _PatientCatalogState createState() => _PatientCatalogState();
}

class _PatientCatalogState extends State<PatientCatalog> {
  late Future<List<Paciente>>? _lesionesPacientes;
  final userService = UserService();
  String? token;
  String? id;

  Future<void> _refrescar() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _lesionesPacientes= _cargarDatos();
    });
  }

  Future<List<Paciente>> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    id = await storage.read(key: "idUsuario");
    return userService.lesionesPacientesAceptados(token!, id!);
  }

  @override
  void initState() {
    super.initState();
    _lesionesPacientes = _cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(233, 214, 204, 1),
          title: Text(
            'Catálogo de lesiones', // Texto centrado
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
        body: RefreshIndicator(
          color: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(204, 87, 54, 1),
          onRefresh: _refrescar,
          child: FutureBuilder<List<Paciente>>(
            future: _lesionesPacientes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(204, 87, 54, 1)));
              } else if (snapshot.hasError) {
                return Center(
                    child: Column(
                  children: [
                    Text("Error al cargar los datos"),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Detalles del error: ${snapshot.error.toString()}"),
                  ],
                ));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "No hay pacientes vinculados",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ));
              } else {
                List<Paciente> pacientes = snapshot.data!;

                return ListView.builder(
                  itemCount: pacientes.length,
                  itemBuilder: (context, index) {
                    final paciente = pacientes[index];
                    return Card(
                      color: Color.fromRGBO(233, 214, 204, 1),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(
                          paciente.nombre + " " + paciente.apellidos,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(204, 87, 54, 1)),
                        ),
                        subtitle: Text(
                          'Correo: ${paciente.correo}',
                          style:
                              TextStyle(color: Color.fromRGBO(204, 87, 54, 1)),
                        ),
                        children: paciente.lesiones.map<Widget>((lesion) {
                          // String nombreImagenOriginal =
                          //           obtenerNombreOriginal(lesion.imagen);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    // Imagen de la lesión (Ovalada) desde archivo
                                    ClipOval(
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/loading.gif', // Coloca aquí un GIF o imagen local para el loading
                                        image: lesion.imagen,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder: (context, error,
                                                stackTrace) =>
                                            Icon(Icons
                                                .error), // En caso de error al cargar la imagen
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Información de la lesión
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lesion.nombre,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    204, 87, 54, 1)),
                                          ),
                                          Text(lesion.descripcion),
                                          Text(
                                              "Porcentaje: ${lesion.porcentaje}"),
                                          Text(
                                              "Fecha: ${lesion.formattedDate}"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Botón de Agregar Observaciones
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AgregarObservacionScreen(
                                                        id_lesion:
                                                            lesion.id_lesion)));
                                      },
                                      icon: Icon(Icons.add),
                                      color: Color.fromRGBO(204, 87, 54, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
