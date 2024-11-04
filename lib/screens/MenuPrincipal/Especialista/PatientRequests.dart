/**
 * Pantalla de solicitudes de vinculación de pacientes.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';



class PatientRequests extends StatefulWidget {

  @override
  _PatientRequestsState createState() => _PatientRequestsState(); 
  }

  class _PatientRequestsState extends State<PatientRequests>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:Text("Solicitudes de vinculación de pacientes")
          ),
      );
  }
  }
