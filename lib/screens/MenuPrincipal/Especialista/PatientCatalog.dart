/**
 * Pantalla de catalogo de pacientes (Especialista).
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';

class PatientCatalog extends StatefulWidget {
  const PatientCatalog({super.key});

  @override
  _PatientCatalogState createState() => _PatientCatalogState();
}

class _PatientCatalogState extends State<PatientCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("CATALOGO DE PACIENTES"),),
    );
  }
}