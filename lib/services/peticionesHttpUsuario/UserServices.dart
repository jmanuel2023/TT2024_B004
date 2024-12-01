import 'package:http/http.dart' as http;
import 'package:skincanbe/model/PacientesLesiones.dart';
import 'dart:convert';

import 'package:skincanbe/model/Usuario.dart';
import 'package:skincanbe/data/constantes.dart';

class UserService {

 Future<Map<String, dynamic>> obtenerUsuario(String id, String token) async {
  var response = await http.get(
    Uri.parse(metodo+ip+puerto+'/usuario/$id'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body); // Decodifica la respuesta JSON
  } else {
    throw Exception('Error al obtener los datos del usuario');
  }
}

Future<String> eliminarUsuario(String id, String token) async {
  var response = await http.delete(
    Uri.parse(metodo+ip+puerto+'/$id'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return ("Eliminada");
  } else {
    throw Exception('Error al eliminar la cuenta');
  }
}



Future<String> editarUsuario(String id, String nombre, String apellidos, String password, String token) async {

  try {
    // Construir el cuerpo dinámicamente
    Map<String, dynamic> body = {
      'id_usuario': id,
      'nombreNuevo': nombre,
      'apellidosNuevo': apellidos,
      'contraNueva': (password.isNotEmpty) ? password: "Sin cambios" // Solo agregar si no está vacío
    };

    var response = await http.put(
      Uri.parse(metodo + ip + puerto + '/editar'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      return ("1");
    } else if (response.statusCode == 400) {
      return ("2");
    } else {
      return ("3");
    }
  } catch (e) {
    return ("Ha ocurrido un error con la edición de datos");
  }
}


Future<List<Paciente>> lesionesPacientesAceptados(String token, String especialistaId) async {
  final url = metodo +ip+puerto+'/pacientes-vinculados-aceptados/$especialistaId';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);
  if (response.statusCode == 200) {
    String utf8Response = utf8.decode(response.bodyBytes);
    List<dynamic> listaLesionesPacientes = jsonDecode(utf8Response);
    return listaLesionesPacientes.map((item) => Paciente.fromJson(item)).toList();  // Asumiendo que el JSON tiene un campo 'status'
  } else {
    throw Exception("Error al obtener el catalogo de pacientes");  // En caso de error o si no hay vínculo
  }

}

//Obtener el estatus de la soliciutd del paciente al especialista
Future<List<String>?> obtenerEstadoVinculacion(String pacienteId, int especialistaId, String token) async {
  final url = metodo + ip + puerto + '/vinculos/estado/$pacienteId/$especialistaId';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> listaStatus = jsonDecode(response.body);
    return listaStatus.map((e) => e['status'] as String). toList();  // Asumiendo que el JSON tiene un campo 'status'
  } else {
    return null;  // En caso de error o si no hay vínculo
  }
}


//Servicio para obtener a los pacientes que se quieren vincular con un especialista
  Future<List<dynamic>> obtenerPacientesPorFiltro(
      String especialistaId, String token) async {
    int idE = int.parse(especialistaId);
    String url = metodo + ip + puerto + "/solicitudes/$idE";


    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("Error al obtener los usuarios Pacientes");
    }
  }

  Future<dynamic> aceptarVinculacion(
      int pacienteId, String especialistaId, String token) async {

    String urlAceptar = metodo + ip+ puerto +'/vinculacion/aceptar/$pacienteId/$especialistaId';

    final response = await http.put(Uri.parse(urlAceptar), headers: {'Authorization': 'Bearer $token'});

    return response.statusCode == 200 ? response.body : 'Error al aceptar vinculación';


  }

  Future<dynamic> rechazarVinculacion(
      int pacienteId, String especialistaId, String token) async {

    String urlAceptar = metodo + ip+ puerto +'/vinculacion/rechazar/$pacienteId/$especialistaId';

    final response = await http.put(Uri.parse(urlAceptar), headers: {'Authorization': 'Bearer $token'});

    return response.statusCode == 200 ? response.body : 'Error al rechazar vinculación';
  }

  Future<dynamic> vincularConEspecialista(
      String pacienteId, int especialistaId, String token) async {
    final url = metodo + ip + puerto + '/vinculos/crear';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'paciente': {'id': int.parse(pacienteId)},
        'especialista': {'id': especialistaId},
        'fechaVinculacion': DateTime.now().toIso8601String().split('T')[0],
      }),
    );


    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
/*********************************************************************************************** */
/*********************************************************************************************** */


//Servicio para obtener a todos los especialistas para que el paciente se pueda vincular con uno
  Future<List<dynamic>> obtenerTodosLosEspecialistasPorFiltro(
      String filtro, String token) async {
    String url;
    if (filtro.isEmpty) {
      url = "/specialistFilter";
    } else {
      url = "/specialistFilter/$filtro";
    }

    final response = await http.get(Uri.parse(metodo + ip + puerto + url),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("Error al obtener los usuarios Especialistas");
    }
  }

/*********************************************************************************************** */
/*********************************************************************************************** */

//Servicio para restablecer la contraseña
  Future<String> restablecerContrasena(String token, String password) async {
    final url = Uri.parse(metodo + ip + puerto + "/reset-password");
    final body = jsonEncode({"token": token, "password": password});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );


      if (response.statusCode == 200) {
        return "Contraseña restablecida correctamente";
      } else if (response.statusCode == 400) {
        return "Token invalido o expirado";
      } else {
        return "Error al restablecer la contraseña";
      }
    } catch (error) {
      return "Error en la solicitud";
    }
  }
/*********************************************************************************************** */
/*********************************************************************************************** */

//Servicio para registrar un usuario
  Future<String> registroUsuario(Usuario usuario) async {
    try {
      var response = await http.post(
        Uri.parse(metodo + ip + puerto + '/crear'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ("1");
      } else if (response.statusCode == 400) {
        return ("2");
      } else if (response.statusCode == 401) {
        return (response.body);
      } else {
        return (response.body);
      }
    } catch (e) {
      return ("Ha ocurrido un error");
    }
  }

/*********************************************************************************************** */
/*********************************************************************************************** */

//Servicio para mandar correo para el restablecimiento de contraseña
  Future<String> recuperarPassword(String email) async {
    final url = Uri.parse(metodo + ip + puerto + '/forgotpassword');
    final body = jsonEncode({"email": email});

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      // Manejar respuesta según el código de estado
      if (response.statusCode == 200) {
        return 'Correo enviado';
      } else if (response.statusCode == 404) {
        return 'Correo no registrado';
      } else {
        return 'Error en el servidor';
      }
    } catch (error) {
      return 'Error en la solicitud';
    }
  }
}
