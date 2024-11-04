import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';

class ConnectSpecialist extends StatefulWidget {
  const ConnectSpecialist({super.key});

  @override
  _ConnectSpecialistState createState() => _ConnectSpecialistState();
}

class _ConnectSpecialistState extends State<ConnectSpecialist> {
  final userService = new UserService();
  List<dynamic> _especialistas = [];
  final TextEditingController _busquedaController = TextEditingController();
  Timer? _debounce;
  String? token;
  String? id;

  //Metodo para cargar los datos desde el servicio
  Future<void> _cargarDatos(String filtro) async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    id= await storage.read(key: "idUsuario");
    List<dynamic> especialistas =
        await userService.obtenerTodosLosEspecialistasPorFiltro(filtro, token!);
    setState(() {
      _especialistas = especialistas;
    });
  }

  _cambioBusqueda() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      _cargarDatos(_busquedaController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    late String start = "nada";
    print(start);
    _cargarDatos(start);
    _busquedaController.addListener(_cambioBusqueda);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Vincular con Especialista"),
            Image.asset("assets/images/logo.png", width: 45, height: 45),
          ],
        ),
        leading: Icon(Icons.arrow_back), // Flecha de regreso
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda
            TextField(
              controller: _busquedaController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar por nombre o cédula',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Lista de especialistas
            Expanded(
                child: ListView.builder(
              itemCount: _especialistas.length,
              itemBuilder: (context, index) {
                var especialista = _especialistas[index];
                return EspecialistaCard(
                  nombre: especialista['nombre'],
                  apellidos: especialista['apellidos'],
                  correo: especialista['correo'],
                  cedula: especialista['cedula'],
                  pacienteId: id ?? "",
                  especialistaId:especialista['id'],
                  token: token!
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class EspecialistaCard extends StatelessWidget {
  final String nombre;
  final String correo;
  final String cedula;
  final String apellidos;
  final String pacienteId;
  final int especialistaId;
  final String token;
  final userService = new UserService();

  EspecialistaCard({
    required this.nombre,
    required this.correo,
    required this.cedula,
    required this.apellidos,
    required this.pacienteId,
    required this.especialistaId,
    required this.token,
  });

  void vincularEspecialista(BuildContext context, String token) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text(
              '¿Estás seguro de que deseas vincularte con $nombre $apellidos?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                status == "PENDIENTE" ? null 
                : () {
                if(status == "DISPONIBLE" || status == "RECHAZADO"){
                   final response =
                    await userService.vincularConEspecialista(pacienteId, especialistaId, token);
                if (response != null) {
                  // Manejar éxito, tal vez mostrar un Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Vinculación exitosa.'),
                  ));
                } else {
                  // Manejar error
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error al vincular.'),
                  ));
                }
                Navigator.of(context).pop(); // Cerrar el diálogo
                  }
              },
              child: Text(
                status == "PENDIENTE" ? "Solicitud enviada"
                : status == "ACEPTADO" ? "Vinculado"
                : "Vincular",
              ),
                style: TextButton.styleFrom(
                primary: status == "ACEPTADO"
                  ? Colors.green
                  : status == "PENDIENTE" ? Colors.orange
                  : null, 
            ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icono de persona
            Icon(
              Icons.person,
              size: 40,
            ),
            SizedBox(width: 10),
            // Información del especialista
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre + " " + apellidos,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("Correo: $correo"),
                  Text("Cédula: $cedula"),
                ],
              ),
            ),
            // Botón de acción
            ElevatedButton(
              onPressed: () {
                vincularEspecialista(context, token);
              },
              child: Text("Vincular"),
            ),
          ],
        ),
      ),
    );
  }
}
