  import 'package:http/http.dart' as http;
  import 'dart:convert';

import 'package:skincanbe/model/Usuario.dart';

  class UserService {
    final String baseUrl;

    UserService(this.baseUrl);

    Future<String> restablecerContrasena(String token, String password) async{
      print("Estoy en la funcion restablecer contraseña");
      final url = Uri.parse("http://192.168.100.63:8080/reset-password");
      final body = jsonEncode({"token": token,"password": password});

      try {
        final response = await http.post(url,
        headers: {
          "Content-Type": "application/json"
        },
        body: body,);

        print(response.body);

        if(response.statusCode == 200){
          print("Contraseña restablecida con exito!");
          return "Contraseña restablecida correctamente";
        } else if(response.statusCode == 400){
          print("Token inválido o expirado");
          return "Token invalido o expirado";
        } else{
          print("Error al restablecer la contraseña: ${response.body}");
          return "Error al restablecer la contraseña";
        }
      } catch (error) {
        print("Error en la solicitud: $error");
        return "Error en la solicitud";
      }
    }

    Future<String> registroUsuario(Usuario usuario) async {
      usuario.apellidos;
      usuario.nombre;
      usuario.status;
      try {
        var response = await http.post(
          Uri.parse('http://192.168.100.63:8080/crear'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(usuario.toJson()),
        );
        print(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Usuario registrado con éxito: ${response.body}');
          return("1");
          } else if(response.statusCode == 400) {
            print('Error al registrar usuario. Código de estado: ${response.statusCode}');
            return ("2");
          }
          else if(response.statusCode == 401){
            print("envio esto ${response.body} ${response.statusCode}");
            return(response.body);
          }
          else{
            return(response.body);
          }
      } catch (e) {
        print('Error: $e');
        return("Ha ocurrido un error");
      }
    }

    Future<String> recuperarPassword(String email) async {
      print("Entre a la funcion recuperarPassword");
      final url = Uri.parse('http://192.168.100.63:8080/forgotpassword');
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
