/**
 * Pantalla de entrada a la aplicacion.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Vinculo/ConnectSpecialist.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/CapturaDeImagen/PantallaCamara.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Historial/historialLesion.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/InformacionCancer/infopiel.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/perfil.dart';


/*En esta pantalla, se muestran todas las funcionalidades que tiene la aplicacion, ya sea informacion, acceeso a la camara 
para un posterior analisis, historial de lesiones, opciones de configuracion,etc.*/

class PantallaEntrada extends StatefulWidget {

  @override
  _PantallaEntradaState createState() => _PantallaEntradaState(); 
  }

  class _PantallaEntradaState extends State<PantallaEntrada>{
  final PageController pageController = PageController(initialPage: 0); //Aqui se declara una variable que va tener el valor de initialPage 0
  int _selectIndex =0; //variable que posteriormente nos va servir para hacer el cambio de pantalla.
  
  String? nombre;
  String? apellidos;
  String? correo;
  String? id;

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
    id = await storage.read(key: "idUsuario");

    setState(() {
      
    });
  }


//Aqui es donde se encuentra todo el contenido que tendra la pantalla
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            InfoPiel(),
            ConnectSpecialist(),
            PantallaCamara(),
            Historial(),
            Perfil()
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        type:BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        selectedItemColor: Color.fromRGBO(204, 87, 54, 1),
        unselectedItemColor: Color.fromRGBO(84, 47, 35, 1),
        onTap: (index){
          setState(() {
          _selectIndex=index;
          pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Información'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Conectar'),
          BottomNavigationBarItem(icon:Icon(Icons.camera), label: 'Cámara'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil') 
        ],),
      );
  }
  }

  
