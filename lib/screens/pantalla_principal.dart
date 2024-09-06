/**
 * Pantalla Principal de la aplicacion (PRIMERA PANTALLA).
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */


/*Primera Pantalla correspondiente al inicio de la aplicacion SkinCanBe, en la cual el usuario se podra registrar o iniciar sesion,
incluyendo el registro con una cuenta de Google */

import 'package:flutter/material.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/screens/registro.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(                                                          //Cuerpo de la pantalla, el cual es un container el cual tiene
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),       //el color de fondo, un padding, una pila de widgets, que son
        decoration: const BoxDecoration(                                        //el encabezado con el logo, y los botones que se usan para
        gradient: LinearGradient(colors: [                                      //registrarse o iniciar sesion
          Color.fromRGBO(233, 214, 204, 1),
          Color.fromRGBO(230, 226, 224, 1)]
          ),
       ),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: [
              _LogoEncabezado(size, context),             //---> Metodo donde se encuentra el widget correspondiente al encabezado con el logo
              _botones(context, size)                              //---> Metodo donde se encuentra el widget correspondiente a los botones
          ],
        ),
       ),      
      );
  }

  Container _botones(BuildContext context, Size size) {                             //METODO CORRESPONDIENTE AL WIDGET QUE CONTIENE LOS BOTONES QUE SE USAN
    return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,      //con esto los elementos del column se alinean al final de la pantalla en horizontal
                children: [
                _botonGoogle(),                               //--> Metodo propio para el boton de registro con Google
                SizedBox(
                  height: 30,
                ),
                _botonesAuth(context)                                //--> Metodo propio para los botones de registro e inicio de sesión
                ]
              ),
            );
  }

  Container _botonesAuth(BuildContext context) {                                  //METODO PARA LOS BOTONES DE REGISTRO E INICIO DE SESION
    return Container(
                padding: EdgeInsets.all(20),
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 189, 187, 187),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [                          //Aqui se le da un estilo al container que contendra los botones
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15,
                      offset: Offset(0, 5)
                    )                    
                  ]),
                  child: Row(                                 //Los botones se colocan en fila para que se coloquen uno a lado de otro
                    children: [
                      _botonAuth(label: "Registrarse",            //Tanto aqui como abajo, se manda a llamar otro metodo, el cual 
                      color: Color.fromARGB(255, 248, 240, 240), //requiere obligatoriamente algunos elementos, esto para indicar que 
                      textColor: Colors.black,                    //estilo e informacion contendra el boton
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => const Registrarse())
                        );
                      },),
                      SizedBox(width: 20),
                      _botonAuth(label: "Iniciar Sesión",
                      color: const Color.fromARGB(255, 12, 12, 12),
                      textColor: const Color.fromARGB(255, 236, 234, 234),
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => const InicioDeSesion())
                        );
                      },),
                    ],
                  ),
              );
  }

  MaterialButton _botonAuth({  //METODO PROPIO PARA UN SOLO BOTON
    required String label,      //--->Elementos requeridos para que este metodo funcione, ..>LABEL = Valor del boton
    required Color color,       //...>COLOR = color del boton
    required Color textColor,   //...>TEXTCOLOR = color de la letra del valor del boton
    required VoidCallback onPressed, //ONPRESS = accion obligatoria en un MaterialButton
  }) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(                                      //ESTILO DEL BOTON PROPIAMENTE PARA DESPUES USAR CADA UNO DE LOS
      borderRadius: BorderRadius.circular(10)),
      color: color,                                                       //ELEMENTOS QUE SE ENVIARON CUANDO SE MANDO A LLAMAR ESTE METODO
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(label, style: TextStyle(color: textColor)),
        ),
        );
  }

  Container _botonGoogle() {                      //METODO DEL BOTON DE REGISTRO CON GOOGLE
    return Container(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image.asset("assets/images/google.png", width: 70, height: 70,), //Logo de google desde la carpeta assets/images
                      SizedBox(width: 9),
                      Text("Registrate con Google", style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w200                         
                      ),),
                    ],
                  ),
                  ),
              );
  }

  Container _LogoEncabezado(Size size, BuildContext context) { //METODO PARA EL ENCABEZADO CON EL LOGO
    return Container(
              width: double.infinity,
              height: size.height * 0.82,
              child: Row(
                children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(
                width: 20,
              ),
              Text("SkinCanBe", style: Theme.of(context).textTheme.headlineLarge,
              ),
              ],   
              ),
            );
  }
}

//