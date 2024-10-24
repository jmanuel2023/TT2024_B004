/**
 * Pantalla de entrada a la aplicacion.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/PatientCatalog.dart';
import 'package:skincanbe/screens/infopiel.dart';
import 'package:skincanbe/screens/perfil.dart';



class SpecialistScreen extends StatefulWidget {
  final String? nombre;
  final String? apellidos;
  final String? correo;

  SpecialistScreen({this.nombre, this.apellidos, this.correo});

  @override
  _SpecialistScreenState createState() => _SpecialistScreenState(); 
  }

  class _SpecialistScreenState extends State<SpecialistScreen>{
  final PageController pageController = PageController(initialPage: 0); //Aqui se declara una variable que va tener el valor de initialPage 0
  int _selectIndex =0; //variable que posteriormente nos va servir para hacer el cambio de pantalla.
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            InfoPiel(),
            PatientCatalog(),
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
          BottomNavigationBarItem(icon:Icon(Icons.book), label: 'Mis pacientes'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil') 
        ],),
      );
  }
  }

  
