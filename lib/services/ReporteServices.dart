
import 'package:skincanbe/data/constantes.dart';
import 'package:http/http.dart' as http;

class ReporteServices {
  final String _endpointReporte = metodo+ip+puerto+"/generar-reporte";

  Future<String> generarYEnviarReporte(String idLesion, String token) async {
    print("$_endpointReporte/$idLesion");
    final response = await http.post(Uri.parse("$_endpointReporte/$idLesion"),
    headers: {'Authorization': 'Bearer $token'});

    print(response.statusCode);

    if (response.statusCode == 200) {
      return "Correo con el reporte de la lesión mandado exitosamente";
    } else {
      throw Exception("Error al mandar el correo del reporte de la lesión");
    }
  }
}