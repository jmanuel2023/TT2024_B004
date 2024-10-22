/**
 * Pantalla de carga o de espera.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';

/*En esta pantalla se carga el logo de la aplicacion y un texto de espera,con un tiempo de 3 segundos 
para dar tiempo al registro del usuario en la BD*/

class PantallaCarga extends StatefulWidget { //clase StatefuLWidget
  const PantallaCarga({super.key});

  @override
  _PantallaCargaState createState() => _PantallaCargaState();
}

class _PantallaCargaState extends State<PantallaCarga> {
  @override
  void initState() { //initState es un funcion de estado,que indica que cuando se inicie la pantalla
    super.initState(); //va hacer lo siguiente
    //_navegacionPantallaEntrada(); //funcion que hace el delay de 3 segundos
  }
 /*La funcion _navegacionPantallaEntrada es asincrona ya que tiene que esperar una respuesta, 
 dicha respuesta es un delay de 3 segundos, durante estos 3 segundos se va mostrar el contenido
 del Scaffold, para luego navegar a otra pantalla. */
  /*_navegacionPantallaEntrada () async {
    await Future.delayed(Duration(seconds: 3), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PantallaEntrada()));
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, //esta propiedad de AppBar, ee para que no aparezca la flecha de retroceso          
        ),
        body: Column( //Widget para poder poner otros widgets, uno abajo de otro
          children: [
            Center(
            child: Image.asset("assets/images/logo.png", //imagen envuelta en un center
            width: 100, height: 100,),
            ),
            SizedBox(height: 10,),
            Center(child: Text("Espere unos momentos...")), //Texto envuelto en un center.
            SizedBox(height: 10,),
            Center(child: CircularProgressIndicator(),),//Aqui se muestra un widgets, el cual es un icono de circulo,simulando que carga
          ],
        ),
    );
  }
}