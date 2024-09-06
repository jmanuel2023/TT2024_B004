/**
 * Pantalla de carga o de espera.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/pantalla_entrada.dart';

void main() => runApp(const PantallaCarga());

class PantallaCarga extends StatefulWidget {
  const PantallaCarga({super.key});

  @override
  _PantallaCargaState createState() => _PantallaCargaState();
}

class _PantallaCargaState extends State<PantallaCarga> {
  @override
  void initState() {
    super.initState();
    _navegacionPantallaEntrada();
  }

  _navegacionPantallaEntrada () async {
    await Future.delayed(Duration(seconds: 3), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PantallaEntrada()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          
        ),
        body: Column(
          children: [
            Center(
            child: Image.asset("assets/images/logo.png",
            width: 100, height: 100,),
            ),
            SizedBox(height: 10,),
            Center(child: Text("Espere unos momentos...")),
            SizedBox(height: 10,),
            Center(child: CircularProgressIndicator(),),
          ],
        ),
    );
  }
}