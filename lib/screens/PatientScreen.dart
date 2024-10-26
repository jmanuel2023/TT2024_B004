/**
 * Pantalla de entrada a la aplicacion.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

import 'package:flutter/material.dart';
import 'package:skincanbe/screens/PantallaCamara.dart';
import 'package:skincanbe/screens/historialLesion.dart';
import 'package:skincanbe/screens/infopiel.dart';
import 'package:skincanbe/screens/perfil.dart';


/*En esta pantalla, se muestran todas las funcionalidades que tiene la aplicacion, ya sea informacion, acceeso a la camara 
para un posterior analisis, historial de lesiones, opciones de configuracion,etc.*/

class PantallaEntrada extends StatefulWidget {
  final String? nombre;
  final String? apellidos;
  final String? correo;
  final String? id;

  PantallaEntrada({this.id, this.nombre, this.apellidos, this.correo});

  @override
  _PantallaEntradaState createState() => _PantallaEntradaState(); 
  }

  class _PantallaEntradaState extends State<PantallaEntrada>{
  final PageController pageController = PageController(initialPage: 0); //Aqui se declara una variable que va tener el valor de initialPage 0
  int _selectIndex =0; //variable que posteriormente nos va servir para hacer el cambio de pantalla.
  
  
//Aqui es donde se encuentra todo el contenido que tendra la pantalla
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            InfoPiel(),
            PantallaCamara(
              id: widget.id
            ),
            Historial(
              usuarioId:widget.id
            ),
            Perfil(nombre: widget.nombre!, apellidos: widget.apellidos!,correo: widget.correo!)
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        selectedItemColor: Color.fromARGB(255, 87, 86, 86),
        unselectedItemColor: Color.fromARGB(255, 19, 20, 20),
        onTap: (index){
          setState(() {
          _selectIndex=index;
          pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Información'),
          BottomNavigationBarItem(icon:Icon(Icons.camera), label: 'Cámara'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil') 
        ],),
      );
  }
  }

  
