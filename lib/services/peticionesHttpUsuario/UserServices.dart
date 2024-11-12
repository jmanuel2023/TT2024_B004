import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:skincanbe/model/Usuario.dart';
import 'package:skincanbe/data/constantes.dart';

class UserService {

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
    // Implementa aquí la petición HTTP para aceptar la vinculación
  }

  Future<dynamic> rechazarVinculacion(
      int pacienteId, String especialistaId, String token) async {
    // Implementa aquí la petición HTTP para rechazar la vinculación
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
        'fechaVinculacion': DateTime.now().toIso8601String(),
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
    usuario.apellidos;
    usuario.nombre;
    usuario.status;
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
