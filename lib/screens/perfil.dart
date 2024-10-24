/**
 * Pantalla del Perfil.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/appinformacion.dart';
import 'package:skincanbe/screens/configuracion.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/screens/politcas.dart';
import 'package:skincanbe/services/AuthenticationService.dart';



class Perfil extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String correo;

  Perfil({ required this.nombre, required this.apellidos, required this.correo});

  @override
  _PerfilState createState () => _PerfilState();
}

class _PerfilState extends State<Perfil>{
  @override
  Widget build(BuildContext context) {
  final String name = widget.nombre;
  final String apellidos = widget.apellidos;
    return Scaffold(
        body: Center(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 104, 99, 99),
                  borderRadius: BorderRadius.circular(10)
                  ),
          accountName: Text(name +" "+apellidos),
          accountEmail: Text(widget.correo),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(name.substring(0,1) +""+apellidos.substring(0,1),
            style: TextStyle(fontSize: 35),),
          ),
                ),
                ListTile(
          leading: Icon(Icons.settings),
          title: Text('Configuración'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const Configuracion()));
          },
                ),
                ListTile(
          leading: Icon(Icons.policy),
          title: Text('Políticas'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const Politicas()));
          },
                ),
                ListTile(
          leading: Icon(Icons.info),
          title: Text('Información de la app'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const InformacionApp()));
          },
                ),
                ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Cerrar sesión'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Mostrar un diálogo de confirmación
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Cerrar sesión'),
                        content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                       actions: [
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();  // Cierra el diálogo sin cerrar sesión
                            },
                          ),
                          TextButton(
                            child: Text('Cerrar sesión'),
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

  
