/**
 * Pantalla de inicio de sesión.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/EmailChangePassword.dart';
import 'package:skincanbe/screens/SpecialistScreen.dart';
import 'package:skincanbe/screens/PatientScreen.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/registro.dart';
import 'package:skincanbe/services/AuthenticationService.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';


class InicioDeSesion extends StatefulWidget {       
  const InicioDeSesion({super.key});                
                                                    
   @override                                        
  _InicioDeSesionState createState() => _InicioDeSesionState();
}

class _InicioDeSesionState extends State<InicioDeSesion>{ 

/*Variables para el controlador de los campos del formulario */
final TextEditingController emailController= TextEditingController();
final TextEditingController passwordController = TextEditingController();

  @override
  //Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
      final ancho = MediaQuery.of(context).size; //Variable para calcular el tamaño de pantalla
    return Scaffold(
    appBar: AppBar( //Widget para el diseño de la barra superior de la pantalla
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), 
            onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const PantallaPrincipal()) 
            );
          }, 
          ),
          title: Row( //Titulo de la pantalla
            children: [ 
              SizedBox(width: ancho.width * 0.64), 
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
            child: SingleChildScrollView( 
              child: Column( 
                children: [
                  Align( 
                    alignment: Alignment.topCenter,
                    child: Text("Entrar a SkinCanBe",
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
                    child: Form( 
                      autovalidateMode: AutovalidateMode.onUserInteraction, 
                      child: Column(
                      children: [
                        CustomInputField( //Widget personalizado para los input del formulario
                          hint: "correo@hotmail.com",
                          label: "Introduzca su correo electronico",
                          icon: Icon(Icons.email_outlined),
                          controller: emailController, //Controlador del contenido del input
                          validator: (value) { //Propiedad para validar el campo
                            return EmailValidator.validate( //Validacion del formato del correo electrónico
                              value.toString()) ? null : 'Correo incorrecto, por favor, ingresa un correo existente';
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomInputField( //Widger personalizado para los input del formulario
                          hint: "*******",
                          label: "Introduzca su contraseña", 
                          icon: Icon(Icons.lock_outline),
                          isPassword: true, //Propiedad que indica que es una contraseña, lo cual quiere decir que se encondera en asteriscos
                          controller: passwordController,//Controlador del contenido del input
                          validator: (value) { //Propiedad para validar el campo
                              return (value != null && value.length >= 6) ? null : 'La contraseña debe de ser de al menos 6 caracteres'; //Valida que la contraseña no se null y que sea mayor a 6 caracteres
                            },
                        ),
                        SizedBox(height: 30,),
                        ],
                    )),
                  ),
                  SizedBox(height: 30),
                  SubmitButton(
                    text: "Iniciar sesión", 
                    onPressed: () async { //Evento del boton al ser oprimido
                      final authService = AuthenticationService(); //Instancia del servicio authService
                      try{
                        final data = await authService.login( //Llamada al metodo login del servicio authService, pasandole de parametros el correo y contraseña
                          emailController.text, 
                          passwordController.text
                          );
                        //Condicion que indica que cuando la respuesta del servicio, incluya en el json message
                        if (data.containsKey('message')) {  
                          final errorMessage = data['message'];
                          ScaffoldMessenger.of(context).showSnackBar( //Mostrara un mensaje en la parte inferior de la pantalla
                            SnackBar(content: Text(errorMessage)),
                          );
                          return;
                        }
                        //Si no tiene message, la respuesta del servicio entonces continua con lo siguiente
                        final tipoUsuario = data['tipoUsuario'];
                        final nombre = data['nombre'];
                        final apellidos = data['apellidos'];
                        final email = data['username'];
                        //final idUsuario = data['Id'];
                        //Condicion que indica que si es tipo de usuario Paciente
                        if(tipoUsuario == "Paciente"){
                          Navigator.push(context, 
                          MaterialPageRoute(builder: 
                          (context) => PantallaEntrada())).then((_) {
                              _showWelcomeDialog(context, nombre, apellidos); //Llama a este metodo para mostrar un mensaje despues de la navegación
                              });
                        }
                        //Condicion que indica que si es tipo de usuario Especialista  
                        else if(tipoUsuario == "Especialista"){
                          Navigator.push(context, 
                          MaterialPageRoute(builder: 
                          (context) => SpecialistScreen( //Navega a esta pantalla
                            nombre: nombre,
                            apellidos: apellidos, 
                            correo: email,
                            )
                            )
                            ).then((_) {
                              _showWelcomeDialog(context, nombre, apellidos); //Muestra el mensaje de este metodo
                              });
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al iniciar sesión, revisa tus credenciales')) //En caso de que no sea ni Paciente ni Especialista, indica que hay un error en las credenciales
                      );

                        }
                      }catch (e){
                        print('Error de autenticación: $e'); //En caso de un error con comunicación con el servicio, indicara un mensaje de error de conexión
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error de conexión, intenta de nuevo más tarde'),
                          ));
                      }
                  }),
                  SizedBox(height: 10,),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EmailChangePassword()));
                  }, child: Text("¿Olvidaste tu contraseña?", //Boton para la recuperación de contraseña
                      style: TextStyle(
                        color: Colors.black),
                      ),
                  ), 
                  SizedBox(height: 30,),
                  TextButton(onPressed: (){ 
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const Registrarse())); //Botón para ir al pantalla de registro
                  }, 
                  child: Text("¿Aun no tienes cuenta? Registrate aqui",
                  style: TextStyle(
                    color: Color.fromARGB(239, 8, 8, 8),
                  ))),
                  ],
              ),
            ),
          ),
        ),
      );
  }
  
  //Metodo que muestra un mensaje despues de iniciar sesión
  void _showWelcomeDialog(BuildContext context, nombre, apellidos) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 5), () { //Pausa de 5 segundos
        Navigator.of(context).pop(true);
      });

      return AlertDialog(
        title: Text('Bienvenido'),
        content: Text('Hola $nombre $apellidos, ¡bienvenido a la aplicación!'),
        actions: [
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();  
            },
          ),
        ],
      );
    },
  );
  }
}



  

  