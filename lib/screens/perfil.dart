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
//import 'package:skincanbe/screens/pantalla_entrada.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/politcas.dart';

void main() => runApp(const Perfil());

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  _PerfilState createState () => _PerfilState();
}

class _PerfilState extends State<Perfil>{
  @override
  Widget build(BuildContext context) {
  //final ancho = MediaQuery.of(context).size;
    return Scaffold(
        /*appBar: AppBar(
          automaticallyImplyLeading: false,
          /*leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const PantallaEntrada())
            );
          }, //iconSize: 35,
          ),*/
          title: Row(
            children: [
              SizedBox(width: ancho.width * 0.64),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
        ),*/
        body: Center(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 104, 99, 99),
                  borderRadius: BorderRadius.circular(10)
                  ),
          accountName: Text("Nombre del Usuario"),
          accountEmail: Text("usuario@correo.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) 
            => const PantallaPrincipal()));
          },
                ),
              ],
            ),
        )

      );
  }
}

  
