import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthenticationService {
  final String _loginUrl = "http://192.168.100.63:8080/login";
  final _storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async{
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
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
  }

  Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

}