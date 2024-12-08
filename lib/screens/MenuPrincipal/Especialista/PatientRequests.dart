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
  bool cargando = false;

  // Método para cargar los datos desde el servicio
  Future<void> _cargarDatos() async {
    // await Future.delayed(Duration(seconds: 2));
    setState(() {
      cargando = true;
    });
    try {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    especialistaId = await storage.read(key: "idUsuario");
    List<dynamic> pacientes = await userService.obtenerPacientesPorFiltro(
        especialistaId ?? "", token!);
    setState(() {
      _pacientes = pacientes;
    });
    } catch (e){
    } finally{
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  void dispose() {
    _debounce?.cancel();
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
      body: RefreshIndicator(
        color: Color.fromRGBO(255, 255, 255, 1),
        backgroundColor: Color.fromRGBO(204, 87, 54, 1),
        onRefresh: _cargarDatos,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: cargando ? Center(child: CircularProgressIndicator(color:  Color.fromRGBO(204, 87, 54, 1)),) 
                  : _pacientes.isEmpty ? Center(child: Text("No hay solicitudes de pacientes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),)                
                  : ListView.builder(
                itemCount: _pacientes.length,
                itemBuilder: (context, index) {
                  var paciente = _pacientes[index];
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
      ),
    );
  }
}
