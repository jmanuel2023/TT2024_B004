import 'package:flutter/material.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';

class ResetPassword extends StatefulWidget {
  final String token; // Este es el token enviado por correo

  ResetPassword({required this.token});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordNewController = TextEditingController();
  final TextEditingController _passwordConfirmNewController =
      TextEditingController();
  UserService userService = UserService();
  bool cargando = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordNewController.dispose();
    _passwordConfirmNewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        title: Text(
          'Restablecer contraseña', // Texto centrado
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
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  //Este widget es para alinear el contenido
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Restablece tu contraseña",
                    style: TextStyle(
                      //Texto de que se alinea
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
                      //Este widget se utiliza cuando queremos dar estilos a un contenedor.
                      color: Color.fromARGB(255, 226, 222, 222),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        //Aqui se le da un estilo al container que contendra los botones
                        BoxShadow(
                            color: Color.fromRGBO(204, 87, 54, 1),
                            blurRadius: 15,
                            offset: Offset(0, 5))
                      ]),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomInputField(
                          hint: "Introduce tu nueva contraseña",
                          label: "Nueva Contraseña",
                          icon: Icon(Icons.email),
                          controller: _passwordNewController,
                          isPassword: true,
                          validator: (value) {
                            //Propiedad para validar el campo
                            return (value != null && value.length >= 6)
                                ? null
                                : 'La contraseña debe de ser de al menos 6 caracteres'; //Valida que la contraseña no se null y que sea mayor a 6 caracteres
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomInputField(
                          hint: "Confirma tu contraseña",
                          label: "Confirmar Contraseña",
                          icon: Icon(Icons.mark_email_read),
                          controller: _passwordConfirmNewController,
                          isPassword: true,
                          validator: (value) {
                            //Propiedad para validar el campo
                            return (value != null && value.length >= 6)
                                ? null
                                : 'La contraseña debe de ser de al menos 6 caracteres'; //Valida que la contraseña no se null y que sea mayor a 6 caracteres
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SubmitButton(
                            text: "Restablecer contraseña",
                            isLoading: cargando,
                            onPressed: () async {
                              final password = _passwordNewController.text;
                              final confirmPassword =
                                  _passwordConfirmNewController.text;
                              if (password == confirmPassword) {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  setState(() {
                                    cargando = true;
                                  });

                                  try {
                                    final response = await
                                        userService.restablecerContrasena(
                                            widget.token, password);
                                    if (response ==
                                        "Contraseña restablecida correctamente") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Contraseña actualizada correctamente'),
                                      ));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InicioDeSesion()));
                                    } else if (response ==
                                        "Token invalido o expirado") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Token inválido o expirado, por favor solicita uno nuevo.'),
                                      ));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InicioDeSesion()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Error al actualizar la contraseña, intenta nuevamente.'),
                                      ));
                                    }
                                  } catch (e) {
//En caso de un error con comunicación con el servicio, indicara un mensaje de error de conexión
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
                              } else {
                                // Si el checkbox no está seleccionado, mostramos un SnackBar con el mensaje de validación
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Las contraseñas no coinciden. Verifica')),
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
