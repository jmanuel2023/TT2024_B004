import 'package:flutter/material.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';

class PacienteCard extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String correo;
  final int idPaciente;
  final String especialistaId;
  final String token;
  final Function(int) eliminacion;


  PacienteCard({
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.idPaciente,
    required this.especialistaId,
    required this.token,
    required this.eliminacion,  
  });

  @override
  State<PacienteCard> createState() => _PacienteCardState();
}

class _PacienteCardState extends State<PacienteCard> {
  final userService = new UserService();
  String status = "Pendiente";
  
  @override
  void initState() {
    super.initState();
    _obtenerEstadoInicial();
  }
  void _obtenerEstadoInicial() async {
    final estadoActual = await userService.obtenerEstadoVinculacion(
      widget.especialistaId, 
      widget.idPaciente, 
      widget.token);

    if (estadoActual != null && estadoActual.isNotEmpty) {
      setState(() {
        if (estadoActual.contains("Aceptado")) {
          status = "Aceptado";
        }
        else if(estadoActual.contains("Rechazado")){
          status = "Rechazado";
        }else {
          status = "Pendiente";
        }
      });
    }
      else{
        setState(() {
          status = "No hay vinculaciones";
        });
      }
  }
  
  void aceptarSolicitud() async {
    final response = await userService.aceptarVinculacion(
        widget.idPaciente, widget.especialistaId, widget.token);
    if (response != null) {
      setState(() {
        status = "Aceptado";
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Solicitud aceptada.'),
      ));
      widget.eliminacion(widget.idPaciente); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al aceptar la solicitud.'),
      ));
    }
  }

  void rechazarSolicitud() async {
    final response = await userService.rechazarVinculacion(
        widget.idPaciente, widget.especialistaId, widget.token);
    if (response != null) {
      setState(() {
        status = "Rechazado";
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Solicitud rechazada.'),
      ));
      widget.eliminacion(widget.idPaciente); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al rechazar la solicitud.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.nombre);
    print(widget.apellidos);
    print(widget.correo);
    print(widget.idPaciente);
    print(widget.especialistaId);
    print(widget.token);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.person,
              size: 40,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.nombre} ${widget.apellidos}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("Correo: ${widget.correo}"),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: status == "Aceptado" || status == "Rechazado" 
                  ? null : aceptarSolicitud,
                  child: Text(
                    status == "Aceptado" ? "Aceptado" : "Aceptar",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: status == "Aceptado" ? Colors.green : null,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: status == "Aceptado" || status == "Rechazado" 
                  ? null : rechazarSolicitud,
                  child: Text(
                    status == "Rechazado" ? "Rechazado" : "Rechazar",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: status == "Rechazado" ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
