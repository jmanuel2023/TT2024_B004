import 'package:flutter/material.dart';
import 'package:skincanbe/screens/EmailChangePassword.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/services/UserServices.dart';
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
  final TextEditingController _passwordConfirmNewController = TextEditingController();
  UserService userService = UserService("http://192.168.100.63:8080/");
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar( //La propiedad appBar de Scaffold, es para dar diseño a la barra superior que tiene por defecto cada pantalla, si no se pone esta propiedad, la propiedad body ocupara todo el espacio de la pantalla
          leading: IconButton(icon: const Icon(Icons.arrow_back), //La propiedad leading del widget AppBar, es para poder dar mas funcionalidades y/o caracteristicas al icono de retroceso
          onPressed: (){
            Navigator.push(context, //La propiedad onPressed indica cuando este icono de retroceso es presionado 
            MaterialPageRoute(builder: (context) => const EmailChangePassword()) //Aqui se indica la pantalla a la que se va a navegar
            );
          }, 
          ),
          title: Row( //La propiedad title del widget AppBar, nos permite agregar otros widgets a un lado del icono de retroceso.
            children: [ //El widget Row se utiliza para poder poner widgets uno a un lado del otro.
              Text("Restablecer contraseña"),
              SizedBox(width: ancho.width * 0.05), //El widget SizedBox es para poder dar un espacio entre filas(rows).
              Image.asset("assets/images/logo.png", width: 45, height: 45), //Este widget nos sirve para poder poner una imagen, esta imagen esta alojada dentro del prpoyecto en la carpeta assets/images/
            ],
          ),
        ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
              Align( //Este widget es para alinear el contenido
                alignment: Alignment.topCenter,
                child: Text("Restablece tu contraseña",style: TextStyle( //Texto de que se alinea
                  color: Colors.grey,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 20,), 
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration( //Este widget se utiliza cuando queremos dar estilos a un contenedor.
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
                  child: Column(
                    children: [
                      CustomInputField(hint: "Introduce tu nueva contraseña", label: "Nueva Contraseña", icon: Icon(Icons.email),
                      controller: _passwordNewController,
                      isPassword: true,
                      ),
                      SizedBox(height: 20,),
                      CustomInputField(hint: "Confirma tu contraseña", label: "Confirmar Contraseña", icon: Icon(Icons.mark_email_read),
                      controller: _passwordConfirmNewController,
                      isPassword: true,
                      ),
                      SizedBox(height: 20,),
                      SubmitButton(text: "Restablecer Contraseña", onPressed: _mResetPassword)
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
  void _mResetPassword() {
    final password = _passwordNewController.text;
    final confirmPassword = _passwordConfirmNewController.text;

    if (password == confirmPassword && password.length >= 6) {
      userService.restablecerContrasena(widget.token, password).then((response) {
        if (response == "Contraseña restablecida correctamente") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Contraseña actualizada correctamente'),
          ));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InicioDeSesion()));
        } else if (response == "Token invalido o expirado") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Token inválido o expirado, por favor solicita uno nuevo.'),
          ));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InicioDeSesion()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error al actualizar la contraseña, intenta nuevamente.'),
          ));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error en la solicitud, por favor intenta más tarde.'),
        ));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InicioDeSesion()));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Las contraseñas no coinciden o son muy cortas'),
      ));
    }
  }
}