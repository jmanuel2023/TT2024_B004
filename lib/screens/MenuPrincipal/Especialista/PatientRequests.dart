/**
 * Pantalla de solicitudes de vinculación de pacientes.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Especialista/PacienteCard.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';

class PatientRequests extends StatefulWidget {
  const PatientRequests({super.key});

  @override
  _PatientRequestsState createState() => _PatientRequestsState();
}

class _PatientRequestsState extends State<PatientRequests> {
  final userService = new UserService();
  List<dynamic> _pacientes = [];
  // final TextEditingController _busquedaController = TextEditingController();
  Timer? _debounce;
  String? token;
  String? especialistaId;

  // Método para cargar los datos desde el servicio
  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    especialistaId = await storage.read(key: "idUsuario");
    List<dynamic> pacientes = await userService.obtenerPacientesPorFiltro(
        especialistaId ?? "", token!);
    setState(() {
      _pacientes = pacientes;
    });
  }

  // _cambioBusqueda() {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 1000), () {
  //     _cargarDatos(_busquedaController.text);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _cargarDatos();
    //_busquedaController.addListener(_cambioBusqueda);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    // _busquedaController.dispose();
    super.dispose();
  }

  void _eliminarTarjeta(int idPaciente) {
    setState(() {
      _pacientes
          .removeWhere((paciente) => paciente['idPaciente'] == idPaciente);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        title: Text(
          'Solicitudes de Pacientes', // Texto centrado
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
          children: [
            // Campo de búsqueda
            /*TextField(
              controller: _busquedaController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar por nombre o ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),*/
            SizedBox(height: 20),
            // Lista de pacientes
            Expanded(
                child: ListView.builder(
              itemCount: _pacientes.length,
              itemBuilder: (context, index) {
                var paciente = _pacientes[index];
                print(paciente['nombre']);
                print(paciente['apellidos']);
                print(paciente['correo']);
                print(paciente['id']);
                print(especialistaId ?? "");
                print(token!);
                return PacienteCard(
                    nombre: paciente['nombre'],
                    apellidos: paciente['apellidos'],
                    correo: paciente['correo'],
                    idPaciente: paciente['id'],
                    especialistaId: especialistaId ?? "",
                    token: token!,
                    eliminacion: _eliminarTarjeta);
              },
            )),
          ],
        ),
      ),
    );
  }
}
