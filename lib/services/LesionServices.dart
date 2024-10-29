import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:skincanbe/data/constantes.dart';

class LesionServices {
  final String _registerInjuryUrl = metodo+ip+puerto+"/register-injury";
  final String _viewInjuries = metodo+ip+puerto;
 

  Future<Map<String,dynamic>> registrarLesion (String id, XFile imagen, String nombreLesion, String descripcion) async{
    var request = http.MultipartRequest('POST', Uri.parse(_registerInjuryUrl));

    //Se agregan los campos al request
    request.fields['id_usuario'] = id;
    request.fields['nombre_lesion'] = nombreLesion;
    request.fields['descripcion'] = descripcion;

    request.files.add(await http.MultipartFile.fromPath('imagen', imagen.path));
    
    var response = await request.send();

    print(response.statusCode);

    if(response.statusCode == 200 || response.statusCode == 201) {
      print("Lesión registrada correctamente");
      var respuesta = await response.stream.bytesToString();
      return json.decode(respuesta);
    }else{
      print("Error al registrar la lesión");
      throw Exception('Error al registrar la lesión: ${response.statusCode}');
    }
  }

   Future<List<dynamic>> obtenerLesionesPorUsuarioId(String usuarioId) async {
    final response = await http.get(Uri.parse("$_viewInjuries/$usuarioId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener lesiones");
    }
  }
}
