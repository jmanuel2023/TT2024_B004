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
  final TextEditingController _emailController =
      TextEditingController(); //Variable para guardar el correo
  bool cargando = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  //Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const InicioDeSesion())); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          'Recuperar contraseña', // Texto centrado
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Asegura que el título esté centrado
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent, // Fondo transparente
              child: Image.asset(
                "assets/images/logo.png", // Ruta del logo
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        //Cuerpo de la pantalla
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            //Widget que permite bajar o subir la pantalla
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Recupera tu contraseña",
                    style: TextStyle(
                      color: Color.fromRGBO(204, 87, 54, 1),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 222, 222),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(204, 87, 54, 1),
                            blurRadius: 15,
                            offset: Offset(0, 5))
                      ]),
                  //Widget para el uso de un formulario
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomInputField(
                          //Widget personalizado para mostrar los input del formulario
                          hint: "Introduce tu correo",
                          label: "Correo electrónico",
                          icon: Icon(Icons.email),
                          controller: _emailController,
                          validator: (value) {
                            //Propiedad para validar el campo
                            return EmailValidator.validate(
                                    //Validacion del formato del correo electrónico
                                    value.toString())
                                ? null
                                : 'Correo incorrecto, por favor, ingresa un correo existente';
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SubmitButton(
                            text: "Mandar correo",
                            isLoading: cargando,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                setState(() {
                                  cargando = true;
                                });

                                String email = _emailController.text;

                                try {
                                  final resultado =
                                      await userService.recuperarPassword(
                                          email); //Llamada asincrona al metodo recuperarPassoword del servicio UserService, pasandole como parametro el correo electrónico
                                  //Condicion donde el correo es enviado correctamente
                                  if (resultado == 'Correo enviado') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Correo enviado para recuperar contraseña"),
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const InicioDeSesion()),
                                    );
                                  }
                                  //Condicion donde el correo que ha ingresado, no se encuentra registrado en la base de datos
                                  else if (resultado ==
                                      'Correo no registrado') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Correo no registrado"),
                                    ));
                                  }
                                  //Condicion donde ha ocurrido un error
                                  else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Ocurrió un error. Inténtalo de nuevo."),
                                    ));
                                  }
                                } catch (e) {
                                  print(
                                      'Error de autenticación: $e'); //En caso de un error con comunicación con el servicio, indicara un mensaje de error de conexión
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Error de conexión, intenta de nuevo más tarde'),
                                  ));
                                } finally {
                                  setState(() {
                                    cargando = false;
                                  });
                                }
                              } else {
                                // Si el checkbox no está seleccionado, mostramos un SnackBar con el mensaje de validación
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Debes de llenar los campos correctamente')),
                                );
                              }
                            })
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
}
