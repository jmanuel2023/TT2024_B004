import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/services/UserServices.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';

class EmailChangePassword extends StatefulWidget {
  const EmailChangePassword({super.key});

  @override
  _EmailChangePasswordState createState() => _EmailChangePasswordState();
}

class _EmailChangePasswordState extends State<EmailChangePassword> {
UserService userService = UserService("http://192.168.100.63:8080/");
final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar( //La propiedad appBar de Scaffold, es para dar diseño a la barra superior que tiene por defecto cada pantalla, si no se pone esta propiedad, la propiedad body ocupara todo el espacio de la pantalla
          leading: IconButton(icon: const Icon(Icons.arrow_back), //La propiedad leading del widget AppBar, es para poder dar mas funcionalidades y/o caracteristicas al icono de retroceso
          onPressed: (){
            Navigator.push(context, //La propiedad onPressed indica cuando este icono de retroceso es presionado 
            MaterialPageRoute(builder: (context) => const InicioDeSesion()) //Aqui se indica la pantalla a la que se va a navegar
            );
          }, 
          ),
          title: Row( //La propiedad title del widget AppBar, nos permite agregar otros widgets a un lado del icono de retroceso.
            children: [ //El widget Row se utiliza para poder poner widgets uno a un lado del otro.
              Text("Recuperar contraseña"),
              SizedBox(width: ancho.width * 0.1), //El widget SizedBox es para poder dar un espacio entre filas(rows).
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
                child: Text("Recupera tu contraseña",style: TextStyle( //Texto de que se alinea
                  color: Colors.grey,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 20,), 
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration( //Este widget se utiliza cuando queremos darr estilos a un contenedor.
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
                      CustomInputField(hint: "Introduce tu correo", label: "Correo electrónico", icon: Icon(Icons.email),
                      controller: _emailController
                      ),
                      SizedBox(height: 20,),
                      SubmitButton(text: "Recuperar Contraseña", onPressed: _enviarSolicitudEmail,)
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
  final email = _emailController.text;

  // Verificación de que el email sea válido
  if (EmailValidator.validate(email)) {
    // Llamamos al servicio para la comunicación con el backend
    final resultado = await userService.recuperarPassword(email);
    
    // Manejo de la respuesta
    if (resultado == 'Correo enviado') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Correo enviado para recuperar contraseña"),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InicioDeSesion()),
      );
    } else if (resultado == 'Correo no registrado') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Correo no registrado"),
      ));
    } else {
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