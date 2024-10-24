import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LesionServices {
  final String _registerInjuryUrl = "http://192.168.100.63:8080/register-injury";
 

  /*Future<String> registrarLesion () async{
    final response = await http.post(
      Uri.parse(_registerInjuryUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({})
    );
  }*/

  /*Future<Map<String, dynamic>> login(String email, String password) async{
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"correo": email, "password": password}),
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      await _storage.write(key: "token", value: data['token']);
      return data;
    } else if(response.statusCode == 401){
      final data2 = jsonDecode(response.body);
      return data2;
    }else if(response.statusCode == 403){
      final data3= jsonDecode(response.body);
      print(data3);
      return data3;
    }
    else{
      print(response.statusCode);
      throw Exception('Error al iniciar sesión');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
  }

  Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }*/

}