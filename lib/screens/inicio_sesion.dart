/**
 * Pantalla de Inicio de sesion.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
//import 'package:skincanbe/screens/pantalla_entrada.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/pantallacarga.dart';
import 'package:skincanbe/screens/registro.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';

void main() => runApp(const InicioDeSesion());

class InicioDeSesion extends StatefulWidget {
  const InicioDeSesion({super.key});

   @override
  _InicioDeSesionState createState() => _InicioDeSesionState();
}

class _InicioDeSesionState extends State<InicioDeSesion>{

  @override
  Widget build(BuildContext context) {
      final ancho = MediaQuery.of(context).size;
    return Scaffold(
    appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const PantallaPrincipal())
            );
          }, //iconSize: 35,
          ),
          title: Row(
            children: [
              SizedBox(width: ancho.width * 0.64),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text("Entrar a SkinCanBe",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(height: 20,), 
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 222, 222),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [                          //Aqui se le da un estilo al container que contendra los botones
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 15,
                          offset: Offset(0, 5)
                        )                    
                      ]),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                      children: [
                        CustomInputField(hint: "correo@hotmail.com", label: "Introduzca su correo electronico", icon: Icon(Icons.email_outlined),
                        validator: (value) {
                          return EmailValidator.validate(
                            value.toString()) ? null : 'Correo incorrecto, por favor, ingresa un correo existente';
                        },
                        ),
                        SizedBox(height: 20,),
                        CustomInputField(hint: "correo@hotmail.com", label: "Introduzca su contraseña", icon: Icon(Icons.lock_outline),
                        isPassword: true,
                        validator: (value) {
                            return (value != null && value.length >= 6) ? null : 'La contraseña debe de ser de al menos 6 caracteres';
                          },
                        ),
                        SizedBox(height: 30,),
                        ],
                    )),
                  ),
                  SizedBox(height: 30),
                  SubmitButton(text: "Iniciar Sesión", onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const PantallaCarga()));
                  }),
                  SizedBox(height: 30,),
                  TextButton(onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const Registrarse()));
                  }, 
                  child: Text("¿Aun no tienes cuenta? Registrate aqui",
                  style: TextStyle(
                    color: Color.fromARGB(239, 8, 8, 8),
                  ))) 
                  ],
              ),
            ),
          ),
        ),
      );
  }
}



  

  