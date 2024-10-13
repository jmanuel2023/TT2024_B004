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
import 'package:skincanbe/screens/pantalla_entrada.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/screens/registro.dart';
import 'package:skincanbe/services/AuthenticationService.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';

void main() => runApp(const InicioDeSesion());

/**
 * En esta pantalla se hace el inicio de sesion(Login) del usuario
 *Primeramente la clase extiende de un StatefuLWidget, ya que esta pantalla necesita reflejar
 sus cambios en tiempo real(estados). 
 */

class InicioDeSesion extends StatefulWidget {       //Esta clase se puede crear facilmente
  const InicioDeSesion({super.key});                //con las recomendaciones que te da VSC
                                                    //solo tienes que poner statefulw y te va
   @override                                        //dar la opcion y solita e crea
  _InicioDeSesionState createState() => _InicioDeSesionState();
}

class _InicioDeSesionState extends State<InicioDeSesion>{ //Aqui hace extension del estado de la clase principal, esto para poder hacer cambios en la pantalla y esta no sea estatica

final TextEditingController emailController= TextEditingController();
final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      final ancho = MediaQuery.of(context).size; //Esta variable es para mantener un parametro del ancho y alto de la pantalla.
    return Scaffold(
    appBar: AppBar( //La propiedad appBar de Scaffold, es para dar diseño a la barra superior que tiene por defecto cada pantalla, si no se pone esta propiedad, la propiedad body ocupara todo el espacio de la pantalla
          leading: IconButton(icon: const Icon(Icons.arrow_back), //La propiedad leading del widget AppBar, es para poder dar mas funcionalidades y/o caracteristicas al icono de retroceso
          onPressed: (){
            Navigator.push(context, //La propiedad onPressed indica cuando este icono de retroceso es presionado 
            MaterialPageRoute(builder: (context) => const PantallaPrincipal()) //Aqui se indica la pantalla a la que se va a navegar
            );
          }, 
          ),
          title: Row( //La propiedad title del widget AppBar, nos permite agregar otros widgets a un lado del icono de retroceso.
            children: [ //El widget Row se utiliza para poder poner widgets uno a un lado del otro.
              SizedBox(width: ancho.width * 0.64), //El widget SizedBox es para poder dar un espacio entre filas(rows).
              Image.asset("assets/images/logo.png", width: 45, height: 45), //Este widget nos sirve para poder poner una imagen, esta imagen esta alojada dentro del prpoyecto en la carpeta assets/images/
            ],
          ),
        ),
        body: Center( //La propiedad body de Scaffold, se usa para poner todo el contenido necesario de la pantalla.
          child: Container(  //AAqui se usan dos widgets primeramente,uno que centra el contenedor,  y el otro que es el contenedor para otros widgets
            padding: EdgeInsets.all(10), //padding es para poder poner margenes
            child: SingleChildScrollView( //Este widget se utiliza para poner scrollear en la pantalla.
              child: Column( //El widget Column se utiliza  para poder poner un widget abajo de otro widget.
                children: [
                  Align( //Este widget es para alinear el contenido
                    alignment: Alignment.topCenter,
                    child: Text("Entrar a SkinCanBe",style: TextStyle( //Texto de que se alinea
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
                    child: Form( //este widget se utiliza para hacer uso de formularios
                      autovalidateMode: AutovalidateMode.onUserInteraction, //Esta propiedad es para poder validar los campos
                      child: Column(
                      children: [ //Aqui se ponen otros widgets para formar el formulario
                        CustomInputField(hint: "correo@hotmail.com",
                        label: "Introduzca su correo electronico",
                        icon: Icon(Icons.email_outlined),
                        controller: emailController,
                        validator: (value) { //Esta funcion se utiliza para validar el campo de correo.
                          return EmailValidator.validate(
                            value.toString()) ? null : 'Correo incorrecto, por favor, ingresa un correo existente';
                        },
                        ),
                        SizedBox(height: 20,),
                        CustomInputField(hint: "*******",
                        label: "Introduzca su contraseña", 
                        icon: Icon(Icons.lock_outline),
                        isPassword: true, //Esta propiedad permite que cuando se digite la contraseña, se  veaan asteriscos.
                        controller: passwordController,
                        validator: (value) { //Funcion para validar que la contraseña sea de mas de 6 caracteres.
                            return (value != null && value.length >= 6) ? null : 'La contraseña debe de ser de al menos 6 caracteres';
                          },
                        ),
                        SizedBox(height: 30,),
                        ],
                    )),
                  ),
                  SizedBox(height: 30),
                  SubmitButton(
                    text: "Iniciar Sesión", 
                    onPressed: () async { //Aqui se hace uso de un widget que esta aparte en otro archivo,el cual nos regresa un widget Button, con estilos
                    final authService = AuthenticationService();
                    try{
                      final data = await authService.login(emailController.text, passwordController.text);
                      final tipoUsuario = data['tipoUsuario'];
                      final nombre = data['nombre'];
                      final apellidos = data['apellidos'];
                      final email = data['username'];
                      print(tipoUsuario);
                      print(nombre);
                      print(apellidos);
                      print(email);

                      if(tipoUsuario == "Paciente"){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: 
                        (context) => PantallaEntrada(
                          nombre: nombre, 
                          apellidos: apellidos, 
                          correo: email,
                          )
                          )
                          ).then((_) {
                              // Muestra el mensaje emergente después de la navegación
                             _showWelcomeDialog(context, nombre, apellidos);
                            });
                      } else if(tipoUsuario == "Especialista"){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: 
                        (context) => PantallaEntrada(
                          nombre: nombre,
                          apellidos: apellidos, 
                          correo: email,
                          )
                          )
                          ).then((_) {
                              // Muestra el mensaje emergente después de la navegación
                             _showWelcomeDialog(context, nombre, apellidos);
                            });
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al iniciar sesión, revisa tus credenciales'))
                    );

                      }
                    }catch (e){
                      print('Error de autenticación: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error de conexión, intenta de nuevo más tarde'),
                        ));
                    }
                  }),
                  SizedBox(height: 30,),
                  TextButton(onPressed: (){ //Aqui se usa el widget TextButton que convierte un texto en un boton
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const Registrarse())); //Aqui se indica a que pantalla  va a navegar este textbutton al ser presionado.
                  }, 
                  child: Text("¿Aun no tienes cuenta? Registrate aqui", //texto del textbutton
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
  
  void _showWelcomeDialog(BuildContext context, nombre, apellidos) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      // Esto permite que el dialog se cierre automáticamente después de 5 segundos
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop(true);
      });

      return AlertDialog(
        title: Text('Bienvenido'),
        content: Text('Hola $nombre $apellidos, ¡bienvenido a la aplicación!'),
        actions: [
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();  // Cierra el diálogo
            },
          ),
        ],
      );
    },
  );
  }
}



  

  