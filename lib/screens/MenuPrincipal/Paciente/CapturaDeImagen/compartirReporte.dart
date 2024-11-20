import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/PatientScreen.dart';
import 'package:skincanbe/services/peticionesHttpReporte/ReporteServices.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';

class CompartirReporte extends StatefulWidget {
  final String? id_lesion;
  final String? tipo_lesion;

  CompartirReporte({required this.id_lesion, required this.tipo_lesion}); 

  @override
  _CompartirReporteState createState() => _CompartirReporteState();
}

class _CompartirReporteState extends State<CompartirReporte> {
  ReporteServices reporteService= ReporteServices();
  String? token;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
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
          'Compartir reporte', // Texto centrado
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Text(
                      'Hola, ya estas a un solo paso de obtener el reporte de tu lesión. Por favor lee lo siguiente...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRichTextSection('Información Esencial',
                      'Según la foto proporcionada, el algoritmo de análisis desarrollado por SkinCanBe ha identificado esta lesión cutánea como ${widget.tipo_lesion}. Basándonos en las imágenes disponibles en nuestra base de datos, el porcentaje de coincidencia de esta lesión es del [porcentaje].'),
                  _buildRichTextSection('¿Qué más?',
                      'Se recomienda que acudas a un medico para confirmar este prediagnóstico. Recuerda que nuestra aplicación no sustituye el análisis profesional, pero puedes descargar el reporte generado para compartirlo con tu medico y facilitar la comparación en futuras consultas.'),
                  _buildRichTextSection('¿Por qué has obtenido este resultado?',
                      'Se ha identificado esta lesión como un caso de ${widget.tipo_lesion}, con un porcentaje de coincidencia del [porcentaje].'),
                  _buildRichTextSection('Descargo de responsabilidad',
                      'Este servicio tiene fines informativos y no reemplaza la consulta con un profesional de la salud. SkinCanBe utiliza un algoritmo basado en redes neuronales convolucionales entrenado con imágenes de lesiones cutáneas. Sin embargo, los resultados no constituyen un diagnostico medico definitivo y están sujetos a revisión profesional.'),
                  _buildRichTextSection('¿Tienes dudas? ',
                      'Escríbenos a nuestro correo: skincanbejia@gmail.com. ¡Estamos para ayudarte!'),
                  SizedBox(
                    height: 10,
                  ),
                  SubmitButton(
                    text: "Compartir Reporte",
                    onPressed: () async {
                      try {
                        String respuesta =
                            await reporteService.generarYEnviarReporte(
                                widget.id_lesion ?? "", token ?? "");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(respuesta)));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PantallaEntrada()));
                      } catch (e) {
                        SnackBar(
                            content: Text(
                                "No se ha mandado el correo, intentenlo en el hitorial de lesiones"));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PantallaEntrada()));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichTextSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
