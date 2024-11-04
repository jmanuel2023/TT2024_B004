import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/PatientScreen.dart';
import 'package:skincanbe/services/peticionesHttpReporte/ReporteServices.dart';

class CompartirReporte extends StatefulWidget {
  final String? idLesion;

  CompartirReporte({this.idLesion});

  @override
  State<CompartirReporte> createState() => _CompartirReporteState();
}

class _CompartirReporteState extends State<CompartirReporte> {
  final reporteService = ReporteServices();

  String? token;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Center(
                  child: Text(
                      "Información acerca de lo que se tiene que hacer despues del pre diagnostico y descargo de responsabilidad")),
            ),
            MaterialButton(onPressed: () async {
              try {
                String respuesta = await reporteService
                    .generarYEnviarReporte(widget.idLesion ?? "", token ?? ""
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(respuesta)));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PantallaEntrada()));
              } catch (e) {
                    SnackBar(content: Text("No se ha mandado el correo, intentenlo en el hitorial de lesiones"));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PantallaEntrada()));
              }
            },
            child: Text("Enviar reporte"),)
          ],
        ),
      ),
    );
  }
}
