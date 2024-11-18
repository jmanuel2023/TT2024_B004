import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:skincanbe/data/constantes.dart';

class LesionServices {
  final String _registerInjuryUrl = metodo+ip+puerto+"/register-injury";
  final String _viewInjuries = metodo+ip+puerto;

  Future<List<dynamic>> historialObservacionConUsuario(String token, int id_lesion) async{
    print(token);
    print(id_lesion);

    final url = metodo+ip+puerto+'/historial-observaciones/$id_lesion';

    print(url);

    final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
       String utf8Response = utf8.decode(response.bodyBytes);
    final List<dynamic> observaciones = json.decode(utf8Response);
    return observaciones;
  } else {
    // Si hay un error, lanzamos una excepción
    throw Exception('Error al obtener el historial de observaciones');
  }
  }
 
  Future<List<dynamic>> obtenerHistorialObservaciones(String token, int id_lesion, String especialistaId) async{
    print(token);
    print(id_lesion);

    final url = metodo+ip+puerto+'/historial-observaciones/$id_lesion/$especialistaId';

    print(url);

    final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
       String utf8Response = utf8.decode(response.bodyBytes);
    final List<dynamic> observaciones = json.decode(utf8Response);
    return observaciones;
  } else {
    // Si hay un error, lanzamos una excepción
    throw Exception('Error al obtener el historial de observaciones');
  }
  }

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

  //Servicio para las observaciones a las lesiones
  Future<String> agregarObservacion(String token, int id_lesion, String descripcion, String especialistaId) async {
  final url = metodo + ip + puerto + '/agregar-observacion/$id_lesion/$especialistaId';
  print('Token: $token');
  print('ID Lesion: $id_lesion');
  print('URL: $url');
  print('Descripción: $descripcion');
  print('ID Especialista: $especialistaId');

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'descripcion': descripcion}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Observación enviada correctamente');
    return 'Observación enviada correctamente';
  } else {
    print('Error al enviar la observación: ${response.statusCode}');
    throw Exception('Error al enviar la observación');
  }
}
}
