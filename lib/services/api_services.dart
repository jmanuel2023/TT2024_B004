import 'dart:convert'; //para uso del json
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class ApiServicios {
  Future<Map<String, dynamic>> peticion_api(XFile imagen) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://20.120.242.184:5000/open_image"));

    request.files.add(await http.MultipartFile.fromPath('imagen', imagen.path));
    //clave, nombre_imagen
    var response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var respuesta = await response.stream.bytesToString();
      return json.decode(respuesta);
    } else {
      print("Error al analizar la imagen");
      throw Exception('Error al analizar la imagen: ${response.statusCode}');
    }
  }
}