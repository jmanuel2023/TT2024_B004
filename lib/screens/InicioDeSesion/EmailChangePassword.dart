/**
 * Pantalla de Restablecimiento de contraseña via correo electrónico
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

/*Pantalla donde el usuario podra colocar un correo electronico, donde desea que le llegue un enlace
para el restablecimiento de contraseña*/

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';

class EmailChangePassword extends StatefulWidget {
  const EmailChangePassword({super.key});

  @override
  _EmailChangePasswordState createState() => _EmailChangePasswordState();
}

class _EmailChangePasswordState extends State<EmailChangePassword> {

UserService userService = UserService(); //Instancia del servicio de usuario
final TextEditingController _emailController = TextEditingController(); //Variable para guardar el correo

  @override
  //Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size; //Variable para calcular el ancho de la pantalla
    return Scaffold(
      appBar: AppBar( //Widget para el diseño de la barra superior
          leading: IconButton(icon: const Icon(Icons.arrow_back), 
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const InicioDeSesion())
            );
          }, 
          ),
          title: Row( //Titulo de la pantalla
            children: [ 
              Text("Recuperar contraseña"),
              SizedBox(width: ancho.width * 0.1), 
              Image.asset("assets/images/logo.png", 
              width: 45, 
              height: 45
              ), 
            ],
          ),
        ),
      body: Center( //Cuerpo de la pantalla
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView( //Widget que permite bajar o subir la pantalla
            child: Column(
              children: [
              Align( 
                alignment: Alignment.topCenter,
                child: Text("Recupera tu contraseña",
                style: TextStyle( 
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
                  boxShadow: const [                          
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15,
                      offset: Offset(0, 5)
                    )                    
                  ]),
                  //Widget para el uso de un formulario
                child: Form(
                  child: Column(
                    children: [
                      CustomInputField( //Widget personalizado para mostrar los input del formulario
                        hint: "Introduce tu correo",
                        label: "Correo electrónico",
                        icon: Icon(Icons.email),
                        controller: _emailController //Controlador del contenido del input
                      ),
                      SizedBox(height: 20,),
                      SubmitButton(
                        text: "Recuperar Contraseña",
                        onPressed: _enviarSolicitudEmail //Llama al metodo para toda la logica de esta pantalla
                      )
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _enviarSolicitudEmail() async {
  final email = _emailController.text; //Guarda en una variable lo que tiene el controlador de los campos del formulario


  if (EmailValidator.validate(email)) { //Metodo para validar el formato del correo electrónico

    final resultado = await userService.recuperarPassword(email); //Llamada asincrona al metodo recuperarPassoword del servicio UserService, pasandole como parametro el correo electrónico
    //Condicion donde el correo es enviado correctamente
    if (resultado == 'Correo enviado') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Correo enviado para recuperar contraseña"),
      ));
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => const InicioDeSesion()),
      );
    }
    //Condicion donde el correo que ha ingresado, no se encuentra registrado en la base de datos 
    else if (resultado == 'Correo no registrado') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Correo no registrado"),
      ));
    } 
    //Condicion donde ha ocurrido un error
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Ocurrió un error. Inténtalo de nuevo."),
      ));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Correo inválido"),
    ));
  }
}

}