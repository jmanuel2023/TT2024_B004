/**
 * Pantalla del Perfil.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/InfoAppScreen.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/PrivacyPoliciesScreen.dart';

import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/configuracion.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/services/peticionesHttpAutenticacion/AuthenticationService.dart';



class Perfil extends StatefulWidget {

  @override
  _PerfilState createState () => _PerfilState();
}

class _PerfilState extends State<Perfil>{
   String? nombre;
  String? apellidos;
  String? correo;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    nombre = await storage.read(key: "nombre");
    apellidos = await storage.read(key: "apellidos");
    correo = await storage.read(key: "email");

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
  final String name = nombre ?? "";
  final String apellido = apellidos ?? "";
  final String letraName = name.isNotEmpty ? name.substring(0,1) : "";
  final String letraApellido = apellido.isNotEmpty ? apellido.substring(0,1) :"";
    return Scaffold(
        body: Center(
            child: ListView(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color:  Color.fromRGBO(233, 214, 204, 1),
                  borderRadius: BorderRadius.circular(10)
                  ),
          accountName: Text(name +" "+apellido,
            style: TextStyle(
              color: Color.fromRGBO(204, 87, 54, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(correo ?? "",
            style: TextStyle(
              color: Color.fromRGBO(204, 87, 54, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(letraName+""+letraApellido,
            style: TextStyle(fontSize: 35,color: Color.fromRGBO(204, 87, 54, 1)),),
          ),
                ),
                ListTile(
          leading: Icon(Icons.settings,
            color: Color.fromRGBO(84, 47, 35, 1),
          ),
          title: Text('Configuración', style: TextStyle(
            color: Color.fromRGBO(84, 47, 35, 1),
            fontWeight: FontWeight.bold,
          ),),
          trailing: Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(84, 47, 35, 1),),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const Configuracion()));
          },
                ),
                ListTile(
          leading: Icon(Icons.policy, color: Color.fromRGBO(84, 47, 35, 1),),
          title: Text('Políticas', style: TextStyle(color: Color.fromRGBO(84, 47, 35, 1), fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(84, 47, 35, 1)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const PrivacyPoliciesScreen()));
          },
                ),
                ListTile(
          leading: Icon(Icons.info, color: Color.fromRGBO(84, 47, 35, 1),),
          title: Text('Información de la app', style: TextStyle(color: Color.fromRGBO(84, 47, 35, 1), fontWeight: FontWeight.bold),),
          trailing: Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(84, 47, 35, 1),),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const InfoAppScreen()));
          },
                ),
                ListTile(
                leading: Icon(Icons.exit_to_app, color: Color.fromRGBO(84, 47, 35, 1)),
                title: Text('Cerrar sesión', style: TextStyle(color: Color.fromRGBO(84, 47, 35, 1), fontWeight: FontWeight.bold),),
                trailing: Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(84, 47, 35, 1)),
                onTap: () {
                  // Mostrar un diálogo de confirmación
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromRGBO(204, 87, 54, 1),
                        title: Text('Cerrar sesión', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
                        content: Text('¿Estás seguro de que deseas cerrar sesión?', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
                       actions: [
                          TextButton(
                            child: Text('Cancelar', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                            onPressed: () {
                              Navigator.of(context).pop();  // Cierra el diálogo sin cerrar sesión
                            },
                          ),
                          TextButton(
                            child: Text('Cerrar sesión', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                            onPressed: () async {
                              final authService = AuthenticationService();
                              Navigator.of(context).pop();  // Cierra el diálogo
                              // Llama a la función logout y redirige a InicioDeSesion
                             await authService.logout();  // Asegúrate de haber instanciado _authService antes
                              Navigator.pushAndRemoveUntil(
                                context,
                               MaterialPageRoute(builder: (context) => InicioDeSesion()),  // Redirigir a la pantalla de inicio de sesión
                                (Route<dynamic> route) => false,  // Elimina todas las pantallas anteriores
                              );
                            },
                         ),
                        ],
                      );
                    },
                  );
                },
              ),
              ],
            ),
        )

      );
  }
}

  
