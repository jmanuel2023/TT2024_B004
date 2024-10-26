import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class LesionServices {
  final String _registerInjuryUrl = "http://192.168.100.63:8080/register-injury";
  final String _viewInjuries = "http://192.168.100.63:8080";
 

  Future<String> registrarLesion (String id, XFile imagen, String nombreLesion, String descripcion) async{
    var request = http.MultipartRequest('POST', Uri.parse(_registerInjuryUrl));

    //Se agregan los campos al request
    request.fields['id_usuario'] = id;
    request.fields['nombre_lesion'] = nombreLesion;
    request.fields['descripcion'] = descripcion;

    request.files.add(await http.MultipartFile.fromPath('imagen', imagen.path));
    
    var response = await request.send();

    print(response.statusCode);

    if(response.statusCode == 200) {
      print("Lesión registrada correctamente");
      return "Bien";
    }else{
      print("Error al registrar la lesión");
      return "Mal";
    }
  }

   Future<List<dynamic>> obtenerLesionesPorUsuarioId(String usuarioId) async {
    final response = await http.get(Uri.parse("$_viewInjuries/$usuarioId"));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener lesiones");
    }
  }
}
