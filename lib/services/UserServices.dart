  import 'package:http/http.dart' as http;
  import 'dart:convert';

import 'package:skincanbe/model/Usuario.dart';

  class UserService {
    final String baseUrl;

    UserService(this.baseUrl);

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
  }
