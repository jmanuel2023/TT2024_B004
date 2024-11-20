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
import 'package:skincanbe/screens/MenuPrincipal/Especialista/PatientCatalog.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/InformacionCancer/infopiel.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/perfil.dart';
import 'package:skincanbe/screens/MenuPrincipal/Especialista/PatientRequests.dart';




class SpecialistScreen extends StatefulWidget {
  

  SpecialistScreen();

  @override
  _SpecialistScreenState createState() => _SpecialistScreenState(); 
  }

  class _SpecialistScreenState extends State<SpecialistScreen>{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            InfoPiel(),
            PatientRequests(),
            PatientCatalog(),
            Perfil()
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
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Solicitudes'),
          BottomNavigationBarItem(icon:Icon(Icons.book), label: 'Mis pacientes'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil') 
        ],),
      );
  }
  }

  
