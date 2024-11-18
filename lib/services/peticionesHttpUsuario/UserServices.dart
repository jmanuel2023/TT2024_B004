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
  print("Nuevo nombre: " + nombre);
  print("Nuevo apellidos: " + apellidos);
  print("Nueva contraseña: " + password);
  print("ID Usuario: " + id);

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

    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Se han editado correctamente los datos: ${response.body}');
      return ("1");
    } else if (response.statusCode == 400) {
      print('Error al editar los datos del usuario. Código de estado: ${response.statusCode}');
      return ("2");
    } else {
      return ("3");
    }
  } catch (e) {
    print('Error: $e');
    return ("Ha ocurrido un error con la edición de datos");
  }
}


Future<List<Paciente>> lesionesPacientesAceptados(String token, String especialistaId) async {
  final url = metodo +ip+puerto+'/pacientes-vinculados-aceptados/$especialistaId';
  print(url);

  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print(response.body);
  print(response.statusCode);
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
  print("PacienteId"+pacienteId);
  print(especialistaId);
  print(token);
  final url = metodo + ip + puerto + '/vinculos/estado/$pacienteId/$especialistaId';
  print(url);
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print(response.body);

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

    print(url);

    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception("Error al obtener los usuarios Pacientes");
    }
  }

  Future<dynamic> aceptarVinculacion(
      int pacienteId, String especialistaId, String token) async {
    
    print(pacienteId);
    print(especialistaId);
    print(token);
    String urlAceptar = metodo + ip+ puerto +'/vinculacion/aceptar/$pacienteId/$especialistaId';
    print(urlAceptar);
    final response = await http.put(Uri.parse(urlAceptar), headers: {'Authorization': 'Bearer $token'});

    print(response.body);
    print(response.statusCode);
    return response.statusCode == 200 ? response.body : 'Error al aceptar vinculación';


  }

  Future<dynamic> rechazarVinculacion(
      int pacienteId, String especialistaId, String token) async {
    print(pacienteId);
    print(especialistaId);
    print(token);
    String urlAceptar = metodo + ip+ puerto +'/vinculacion/rechazar/$pacienteId/$especialistaId';
    print(urlAceptar);
    final response = await http.put(Uri.parse(urlAceptar), headers: {'Authorization': 'Bearer $token'});

    print(response.body);
    print(response.statusCode);
    return response.statusCode == 200 ? response.body : 'Error al rechazar vinculación';
  }

  Future<dynamic> vincularConEspecialista(
      String pacienteId, int especialistaId, String token) async {
    final url = metodo + ip + puerto + '/vinculos/crear';
    print(url);
    print(pacienteId);
    print(especialistaId);
    print(token);
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

    print(response.statusCode);
    print(response.body);

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
    print(filtro);
    if (filtro.isEmpty) {
      url = "/specialistFilter";
    } else {
      url = "/specialistFilter/$filtro";
    }

    print(url);

    final response = await http.get(Uri.parse(metodo + ip + puerto + url),
        headers: {'Authorization': 'Bearer $token'});

    print(response.statusCode);
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
    print("Estoy en la funcion restablecer contraseña");
    final url = Uri.parse(metodo + ip + puerto + "/reset-password");
    final body = jsonEncode({"token": token, "password": password});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print(response.body);

      if (response.statusCode == 200) {
        print("Contraseña restablecida con exito!");
        return "Contraseña restablecida correctamente";
      } else if (response.statusCode == 400) {
        print("Token inválido o expirado");
        return "Token invalido o expirado";
      } else {
        print("Error al restablecer la contraseña: ${response.body}");
        return "Error al restablecer la contraseña";
      }
    } catch (error) {
      print("Error en la solicitud: $error");
      return "Error en la solicitud";
    }
  }
/*********************************************************************************************** */
/*********************************************************************************************** */

//Servicio para registrar un usuario
  Future<String> registroUsuario(Usuario usuario) async {
    print("Datos:"+ usuario.nombre);
    print("Datos:"+ usuario.apellidos);
    try {
      var response = await http.post(
        Uri.parse(metodo + ip + puerto + '/crear'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toJson()),
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Usuario registrado con éxito: ${response.body}');
        return ("1");
      } else if (response.statusCode == 400) {
        print(
            'Error al registrar usuario. Código de estado: ${response.statusCode}');
        return ("2");
      } else if (response.statusCode == 401) {
        print("envio esto ${response.body} ${response.statusCode}");
        return (response.body);
      } else {
        return (response.body);
      }
    } catch (e) {
      print('Error: $e');
      return ("Ha ocurrido un error");
    }
  }

/*********************************************************************************************** */
/*********************************************************************************************** */

//Servicio para mandar correo para el restablecimiento de contraseña
  Future<String> recuperarPassword(String email) async {
    print("Entre a la funcion recuperarPassword");
    final url = Uri.parse(metodo + ip + puerto + '/forgotpassword');
    final body = jsonEncode({"email": email});
    print(body);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      print(response.statusCode);

      // Manejar respuesta según el código de estado
      if (response.statusCode == 200) {
        print("Correo enviado para la recuperación de contraseña");
        return 'Correo enviado';
      } else if (response.statusCode == 404) {
        print("Correo no encontrado");
        return 'Correo no registrado';
      } else {
        print("Error desconocido: ${response.body}");
        return 'Error en el servidor';
      }
    } catch (error) {
      print("Error en la solicitud: $error");
      return 'Error en la solicitud';
    }
  }
}
