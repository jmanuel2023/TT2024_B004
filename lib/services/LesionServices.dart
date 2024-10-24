import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LesionServices {
  final String _registerInjuryUrl = "http://192.168.100.63:8080/register-injury";
 

  Future<String> registrarLesion (String id, XFile imagen, String nombreLesion, String descrip) async{
    final response = await http.post(
      Uri.parse(_registerInjuryUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({id: id, imagen: imagen, nombreLesion: nombreLesion, descripcion: descrip}),
    );
  if(response.statusCode == 200){
    final data= jsonDecode(response.body);
    print(data);
    return data;
  }else{
    final data= jsonDecode(response.body);
    print(data);
    return data;
}
}
  

  
}
