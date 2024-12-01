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
  String status = "Disponible";
  bool cargando = false;

  //Metodo para cargar los datos desde el servicio
  Future<void> _cargarDatos(String filtro) async {
    setState(() {
      cargando = true;
    });
    try {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    id = await storage.read(key: "idUsuario");
    List<dynamic> especialistas =
        await userService.obtenerTodosLosEspecialistasPorFiltro(filtro, token!);
    setState(() {
      _especialistas = especialistas;
    });
    } catch (e) {
    } finally {
      setState(() {
        cargando = false;
      });
    }
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
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        title: Text(
          'Vincular con Especialista', // Texto centrado
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
                child: cargando ? Center(child: CircularProgressIndicator(color: Color.fromRGBO(204, 87, 54, 1)),)
              : _especialistas.isEmpty ? Center(
                child: Text("No hay especialistas disponibles",
                style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)
                ),
                
              )  
              : ListView.builder(
              itemCount: _especialistas.length,
              itemBuilder: (context, index) {
                var especialista = _especialistas[index];
                return EspecialistaCard(
                    nombre: especialista['nombre'],
                    apellidos: especialista['apellidos'],
                    correo: especialista['correo'],
                    cedula: especialista['cedula'],
                    pacienteId: id ?? "",
                    especialistaId: especialista['id'],
                    token: token!);
              },
            )),
          ],
        ),
      ),
    );
  }
}

class EspecialistaCard extends StatefulWidget {
  final String nombre;
  final String correo;
  final String cedula;
  final String apellidos;
  final String pacienteId;
  final int especialistaId;
  final String token;

  EspecialistaCard({
    required this.nombre,
    required this.correo,
    required this.cedula,
    required this.apellidos,
    required this.pacienteId,
    required this.especialistaId,
    required this.token,
  });

  @override
  State<EspecialistaCard> createState() => _EspecialistaCardState();
}

class _EspecialistaCardState extends State<EspecialistaCard> {
  final userService = new UserService();
  String status = "Disponible";

  @override
  void initState() {
    super.initState();
    _revisarStatusVinculacion();
  }

  void _revisarStatusVinculacion() async {
    final estados = await userService.obtenerEstadoVinculacion(
        widget.pacienteId, widget.especialistaId, widget.token);
    if (estados != null && estados.isNotEmpty) {
      setState(() {
        status = estados.join(', ');
      });
    } else {
      setState(() {
        status = "No hay vinculaciones";
      });
    }
  }

  void vincularEspecialista() async {
    final response = await userService.vincularConEspecialista(
        widget.pacienteId, widget.especialistaId, widget.token);
    if (response != null) {
      setState(() {
        status = "PENDIENTE";
      });
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
                    '${widget.nombre} ${widget.apellidos}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("Correo: ${widget.correo}"),
                  Text("Cédula: ${widget.cedula}"),
                ],
              ),
            ),
            // Botón de acción
            ElevatedButton(
              onPressed: status == "PENDIENTE" ||
                      status == "ACEPTADO" ||
                      status == "RECHAZADO"
                  ? null
                  : vincularEspecialista,
              child: Text(
                status == "ACEPTADO"
                    ? "Vinculación aceptada"
                    : status == "RECHAZADO"
                        ? "Solicitud rechazada"
                        : status == "PENDIENTE"
                            ? "Solicitud enviada"
                            : "Vincular",
                style: TextStyle(fontSize: 12),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: status == "PENDIENTE"
                    ? const Color.fromARGB(255, 0, 255, 42)
                    : null,
                disabledBackgroundColor: Colors.black,
                disabledForegroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
