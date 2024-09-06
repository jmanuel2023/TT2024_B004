/**
 * Pantalla de Registro del usuario.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/inicio_sesion.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';
import 'package:skincanbe/widgets/selector_fecha.dart';

/**
 * Esta pantalla es la correspondiente al Registro del usuario, de la forma tradicional, ya que tambie existira la opcion 
 * de registrarse con una cuenta de google.
 */

void main() => runApp(const Registrarse());

/**La clase extiende de la clase StatefulWidget ya que debe de tener cambios de estado durante su ejecucion, bondades 
 * que nos ofrece esta clase.  
 */

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

   @override
  _RegistrarseState createState() => _RegistrarseState();
}


class _RegistrarseState extends State<Registrarse> {
  String _date = "Selecciona tu fecha de nacimiento";  //Variable String con una oracion que ayudara despues
  bool? _isChecked = false; //Variable Booleana la cual puede o no estar inicializada (?), pero en esta caso, si lo esta.


  @override
  Widget build(BuildContext context) {
    final ancho=MediaQuery.of(context).size; //Variable que nos permitira sacar valores de la altura y el ancho de la pantalla.
  /**
   * La clase retorna un Scaffold, ya que este widget es el que permite que se vea la aplicacion. Si no existe este widget
   * la pantalla sale en negro.
   * 
   * La propiedad appBar, es para el encabezado que sale en la pantalla.
   * La propuedad body, es la pante de abajo del appBar, donde iran todos los widgets que necesitemso.
   */
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), //La propiedad de leading es para que salga el icono de la flechita hacia la izquierda, que nos permite pasar a la pantalla que le indiquemos.
          onPressed: (){ /**Si esta flechita es presionada, nos mandara a la pantalla Principal */
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const PantallaPrincipal())); //Navigator.push es para poder indicar la nevagacion entre pantallas
          }, 
          ),
          title: Row( //La propiedad de title, es el texto o imagenes que requieras que salgan en el encabezado.
            //El widget row es para poder acomodar otros widgets uno debajo del otro, estos widgets deben estar dentro de children
            children: [
              SizedBox(width: ancho.width * 0.64), //SizedBox es un widget que nos permite que haya un espacio entre widgets
              Image.asset("assets/images/logo.png", width: 45, height: 45), //Widget para insertar una imagen que esta guardada en la carpeta de assets/images/
            ],
          ),
        ),
        body: Container( //Este widget funge como contenedor de otros widgets, los cuales deben de estar dentro de la propiedad child.
          padding: EdgeInsets.all(10), //El padding es para guardar espacios entre el contenedor y el contorno de la pantalla.
          child: SingleChildScrollView( //Este widget es para poder hacer scroll al contenido del contenedor. Aqui se le puede agregar otro widget dentro de la propiedad child.
            child: Column( //Column es un widget que permite acomodar N widgets uno a un lado del otro.
              children: [
                Align( //Este widget nos sirve para poder alinear un texto, donde se requiera, en este caso en el centro.
                  alignment: Alignment.topCenter,
                  child: Text("Registrate con SkinCanBe",style: TextStyle( //Texto que se alinea.
                    color: Colors.grey, //Color de la letra
                    fontSize: 23, //Tamaño de la letra
                    fontWeight: FontWeight.bold, //Estilo de la letra, en este caso, es en negritas.
                  ),),
                ),
                SizedBox(height: 20,), 
                Container( //Otro widget dentro del column, que es un contenedor.
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
                  child: Form( //Este widget se usa para hacer formularios de edicion.
                    autovalidateMode: AutovalidateMode.onUserInteraction, //Sirve para poder validar la informacion que el usuario esta ingresando
                    child: Column(
                    children: [
                      CustomInputField( //Campo para que el usuario ingrese su nombre
                        hint: "Juan Pérez", label: "Introduzca su nombre completo", icon: Icon(Icons.person_outline_outlined)),
                     SizedBox(height: 20,),
                    CustomInputField( //Campo para que el usuario ingrese su correo electronico
                      hint: "correo@hotmail.com", label: "Introduzca su correo electrónico", icon: Icon(Icons.email_outlined),
                    validator: (value) {
                          return EmailValidator.validate( //Funcion que valida si el correo es correcto, si no manda un error.
                            value.toString()) ? null : 'Correo incorrecto, por favor, ingresa un correo existente';
                        },
                    ),
                      SizedBox(height: 20,),
                      DatePickerField(date: _date, onConfirm: (date) { //Este widget es para el selector de fecha, el cual esta en un widget aparte.
                        setState(() { //Aqui es donde se maneja el cambio de estado en la pantalla.
                          _date = '${date.day}/${date.month}/${date.year}'; //Se indica que fecha se selecciono.
                        });
                      },),
                      SizedBox(height: 20),
                      //Campo para que el usuario coloque su contraseña
                      CustomInputField(hint: "******", label: "Introduzca una contraseña", icon: Icon(Icons.lock_outlined),
                      isPassword: true,
                      validator: (value) { //Validacion para que la contraseña sea mayor a 6 caracteres
                        return (value != null && value.length >= 6)
                        ? null : 'La contraseña debe de ser de al menos 6 caracteres';
                      },
                      ),
                      SizedBox(height: 30,),
                      Row( //Aqui se hace uso del widget Row para acomodar un checkbox y un texto, uno a lado del otro.
                        children: [
                          Checkbox(value: _isChecked, //Checkbox
                          onChanged: (bool? value){ //Aqui verifica si ha cambiado de estado el checkbox, y si si cambia el estado de la pantalla.
                            setState(() {
                              _isChecked = value!;
                            });
                          },),
                          SizedBox(width:6),
                          RichText( //Widget que nos permite poner diferentes estilos a texto. Esto se hace para que pudiera caber el texto y que se vea de forma correcta.
                            text: TextSpan( //Este widget contendra un texto con diferente estilo
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 53, 51, 51), 
                             ),
                              children: [
                                TextSpan(text: 'He leído y acepto los '),
                                TextSpan(
                                 text: 'Términos \ny Condiciones',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                   fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: ' del uso de SkinCanBe'),
                              ],
                            ),
                          )
                        ],
                      )
                      ],
                  )),
                ),
                SizedBox(height: 30),
                SubmitButton(text: "Registrarme", onPressed: (){ //Boton de Registrarse, el estilo del boton esta dentro de un widget que esta en un archivo aparte.
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InicioDeSesion()), //Se usa Navigator.push para poder navegar entre pantallas.
                  );
                },),
                SizedBox(height: 30,),
                TextButton(onPressed: (){ //Widget que nos permite poner un Boton de texto
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const InicioDeSesion()));//Se usa el navigator.push para poder navegar entre pantallas.
                }, 
                child: Text("¿Ya tienes cuenta? Inicia sesión aqui", //Texto que sera boton.
                style: TextStyle(
                  color: Color.fromARGB(239, 8, 8, 8),
                ))) 
                ],
            ),
          ),
        ),
      );
  }
}



