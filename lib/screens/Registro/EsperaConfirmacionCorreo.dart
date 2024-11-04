/**
 * Pantalla de aviso para confirmación del correo electrónico.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

/*Pantalla donde se mostrara un aviso indicando al usuario que ya se le ha mandado un correo 
electronico para la confirmación del mismo. Esta pantalla solo se mostrara 5 segundos*/

import 'package:flutter/material.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';

class EsperaConfirmacion extends StatefulWidget {
  const EsperaConfirmacion({super.key});

  @override
  _EsperaConfirmacionState createState() => _EsperaConfirmacionState();
}

class _EsperaConfirmacionState extends State<EsperaConfirmacion> {

   @override
  void initState() { //metodo del ciclo de vida del dart, el cual se ejecuta cuando inicia la pantalla
    super.initState();
    Future.delayed(Duration(seconds: 5), () { //Un pausa de 3 segundos
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => InicioDeSesion()),
      );
    });
  }

  @override
  //Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //variable para calcular el tamaño de la pantalla.
    return Scaffold(
      body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: size.height*0.15),
            decoration: const BoxDecoration(                                        
            gradient: LinearGradient(colors: [                                      
            Color.fromRGBO(233, 214, 204, 1),
            Color.fromRGBO(230, 226, 224, 1)]
            ),
          ),
            child: Column(
              children: [
                Icon(Icons.mark_email_read, size: 300),
                SizedBox(height:20,),
                Text("Favor de confirmar la existencia de su cuenta de correo electrónico.",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600, 
                  color: Colors.black87, 
                 letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center, 
              ),
                SizedBox(height:20),
                Text("Haz clic en el enlace que se hizo llegar al correo electrónico que ingresaste.",
                style: TextStyle(
                  fontSize: 18.0, 
                  fontWeight: FontWeight.w600, 
                  color: Colors.black87, 
                 letterSpacing: 1.2, 
                ),
                textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
        );
  }
}