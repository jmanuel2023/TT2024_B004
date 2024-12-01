/**
 * Pantalla de Registro del usuario.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skincanbe/model/Usuario.dart';
import 'package:skincanbe/screens/Registro/EsperaConfirmacionCorreo.dart';
import 'package:skincanbe/screens/Registro/PrivacyPolicyScreen.dart';
import 'package:skincanbe/screens/Registro/TermsAndConditionsScreen.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/screens/pantalla_principal.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';
//import 'package:skincanbe/widgets/selector_fecha.dart';

/**
 * Esta pantalla es la correspondiente al Registro del usuario, de la forma tradicional, ya que tambie existira la opcion 
 * de registrarse con una cuenta de google.
 */

/**La clase extiende de la clase StatefulWidget ya que debe de tener cambios de estado durante su ejecucion, bondades 
 * que nos ofrece esta clase.  
 */

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  @override
  _RegistrarseState createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  UserService userService = UserService();
  //String _date = "Selecciona tu fecha de nacimiento";  //Variable String con una oracion que ayudara despues
  bool _isChecked =
      false; //Variable Booleana la cual puede o no estar inicializada (?), pero en esta caso, si lo esta.
  String tipoUsuario = 'Paciente';
  bool mostrarCedula = false;

  final TextEditingController nombreControlador = TextEditingController();
  final TextEditingController apellidosControlador = TextEditingController();
  final TextEditingController correoControlador = TextEditingController();
  final TextEditingController edadControlador = TextEditingController();
  final TextEditingController passwordControlador = TextEditingController();
  final TextEditingController tipoUsuarioControlador = TextEditingController();
  final TextEditingController cedulaControlador = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool cargando = false;

  @override
  void initState() {
    super.initState();
    tipoUsuarioControlador.text = tipoUsuario;
  }

  @override
  void dispose() {
    nombreControlador.dispose();
    apellidosControlador.dispose();
    correoControlador.dispose();
    edadControlador.dispose();
    passwordControlador.dispose();
    tipoUsuarioControlador.dispose();
    cedulaControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /**
   * La clase retorna un Scaffold, ya que este widget es el que permite que se vea la aplicacion. Si no existe este widget
   * la pantalla sale en negro.
   * 
   * La propiedad appBar, es para el encabezado que sale en la pantalla.
   * La propuedad body, es la pante de abajo del appBar, donde iran todos los widgets que necesitemso.
   */
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
                        const PantallaPrincipal())); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          '', // Texto centrado
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
      body: Stack(
        children: [
          Container(
            //Este widget funge como contenedor de otros widgets, los cuales deben de estar dentro de la propiedad child.
            padding: EdgeInsets.all(
                10), //El padding es para guardar espacios entre el contenedor y el contorno de la pantalla.
            child: SingleChildScrollView(
              //Este widget es para poder hacer scroll al contenido del contenedor. Aqui se le puede agregar otro widget dentro de la propiedad child.
              child: Column(
                //Column es un widget que permite acomodar N widgets uno a un lado del otro.
                children: [
                  Align(
                    //Este widget nos sirve para poder alinear un texto, donde se requiera, en este caso en el centro.
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Registrate con SkinCanBe",
                      style: TextStyle(
                        //Texto que se alinea.
                        color:
                            Color.fromRGBO(204, 87, 54, 1), //Color de la letra
                        fontSize: 23, //Tamaño de la letra
                        fontWeight: FontWeight
                            .bold, //Estilo de la letra, en este caso, es en negritas.
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    //Otro widget dentro del column, que es un contenedor.
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 226, 222, 222),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          //Aqui se le da un estilo al container que contendra los botones
                          BoxShadow(
                              color: Color.fromRGBO(204, 87, 54, 1),
                              blurRadius: 15,
                              offset: Offset(7, 7))
                        ]),
                    child: Form(
                        //Este widget se usa para hacer formularios de edicion.
                        key: _formKey,
                        autovalidateMode: AutovalidateMode
                            .onUserInteraction, //Sirve para poder validar la informacion que el usuario esta ingresando
                        child: Column(
                          children: [
                            CustomInputField(
                              //Campo para que el usuario ingrese su nombre
                              hint: "Juan", label: "Introduzca su nombre(s)",
                              icon: Icon(Icons.person_outline_outlined),
                              controller:
                                  nombreControlador, // Asignar el controlador aquí
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, ingresa tu nombre';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomInputField(
                              //Campo para que el usuario ingrese su nombre
                              hint: "Pérez Perez",
                              label: "Introduzca sus apellidos",
                              icon: Icon(Icons.person_outline_outlined),
                              controller:
                                  apellidosControlador, // Asignar el controlador aquí
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, ingresa tu apellido';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomInputField(
                              //Campo para que el usuario ingrese su correo electronico
                              hint: "correo@hotmail.com",
                              label: "Introduzca su correo electrónico",
                              icon: Icon(Icons.email_outlined),
                              keyboardType: TextInputType.emailAddress,
                              controller: correoControlador,
                              validator: (value) {
                                return EmailValidator.validate(
                                        //Funcion que valida si el correo es correcto, si no manda un error.
                                        value.toString())
                                    ? null
                                    : 'Correo incorrecto, por favor, ingresa un correo existente';
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomInputField(
                              hint: "18",
                              label: "Introduzca su edad",
                              icon: Icon(Icons.add_box_outlined),
                              controller: edadControlador,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Asegura que solo se ingresen dígitos
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu edad';
                                }
                                int? valor;
                                try {
                                  valor = int.parse(
                                      value); // Convertir a int si no hay error
                                } catch (e) {
                                  return 'Por favor ingresa un número válido'; // Captura errores de conversión
                                }
                                if (valor < 18) {
                                  return 'Debes tener al menos 18 años';
                                } else if (valor > 99) {
                                  return 'Edad no admitida';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            //Campo para que el usuario coloque su contraseña
                            CustomInputField(
                              hint: "******",
                              label: "Introduzca una contraseña",
                              icon: Icon(Icons.lock_outlined),
                              isPassword: true,
                              controller: passwordControlador,
                              validator: (value) {
                                //Validacion para que la contraseña sea mayor a 6 caracteres
                                return (value != null && value.length >= 6)
                                    ? null
                                    : 'La contraseña debe de ser de al menos 6 caracteres';
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText:
                                    'Selecciona el tipo de Usuario', // Etiqueta del combo box
                                border:
                                    OutlineInputBorder(), // Añade un borde al combo box
                              ),
                              value: tipoUsuario, // Valor predeterminado
                              items: [
                                DropdownMenuItem(
                                  value: 'Paciente',
                                  child: Text('Paciente'),
                                ),
                                DropdownMenuItem(
                                  value: 'Especialista',
                                  child: Text('Especialista'),
                                ),
                              ],
                              onChanged: (value) {
                                // Aquí puedes manejar el cambio de valor
                                setState(() {
                                  tipoUsuario = value!;
                                  mostrarCedula = (tipoUsuario ==
                                      'Especialista'); // Muestra el campo solo si es "Especialista"
                                  tipoUsuarioControlador.text = tipoUsuario;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Has seleccionado: $value'),
                                  ),
                                );
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                   return 'Por favor, selecciona un tipo de usuario';                                   
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            if (mostrarCedula) // Si "mostrarCedula" es true, se muestra el CustomInputField
                              CustomInputField(
                                hint: '12345678',
                                label: 'Ingresa tu cedula',
                                icon: Icon(Icons.badge),
                                keyboardType: TextInputType.number,
                                controller: cedulaControlador,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Asegura que solo se ingresen dígitos
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa tu cédula';
                                  } else if (value.length < 5 ||
                                      value.length > 8) {
                                    return 'La cédula debe tener entre 5 y 8 dígitos';
                                  }
                                  return null;
                                },
                              ),
                            SizedBox(height: 10),
                            Row(
                              //Aqui se hace uso del widget Row para acomodar un checkbox y un texto, uno a lado del otro.
                              children: [
                                Checkbox(
                                  value: _isChecked, //Checkbox
                                  onChanged: (bool? value) {
                                    //Aqui verifica si ha cambiado de estado el checkbox, y si si cambia el estado de la pantalla.
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                                ),
                                SizedBox(width: 6),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 53, 51, 51),
                                    ),
                                    children: [
                                      TextSpan(text: 'He leído y acepto los\n'),
                                      TextSpan(
                                        text: 'Términos y Condiciones',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navega a la pantalla de Términos y Condiciones
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TermsAndConditionsScreen(),
                                              ),
                                            );
                                          },
                                      ),
                                      TextSpan(text: ' y el\n '),
                                      TextSpan(
                                        text: 'Aviso de Privacidad',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navega a la pantalla del Aviso de Privacidad
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PrivacyPolicyScreen(),
                                              ),
                                            );
                                          },
                                      ),
                                      TextSpan(text: '\ndel uso de SkinCanBe'),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 15),
                  SubmitButton(
                    text: "Registrarme",
                    isLoading: cargando,
                    onPressed: () async {
                      if (_isChecked) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            cargando = true; // Muestra el indicador
                          });

                          try {
                            // Capturamos los valores de los TextEditingController
                            String nombre = nombreControlador.text;
                            String apellidos = apellidosControlador.text;
                            String correo = correoControlador.text;
                            String age = edadControlador.text;
                            String contra = passwordControlador.text;
                            String tipousuario = tipoUsuarioControlador.text;
                            String cedula = cedulaControlador.text;
                            Usuario user = new Usuario(
                                id: 0,
                                nombre: nombre,
                                apellidos: apellidos,
                                edad: int.parse(age),
                                correo: correo,
                                password: contra,
                                tipoUsuario: tipousuario,
                                cedula: cedula);
                            // Llamada al método de registro de usuario
                            String respuesta =
                                await userService.registroUsuario(user);

                            if (int.parse(respuesta) == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Usuario registrado con exito!")),
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EsperaConfirmacion(correo: correo,)));
                            } else if (int.parse(respuesta) == 2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "El correo que ingresaste ya existe!, vuelve a intentarlo con otro, porfavor")),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Hubo un error al registrar el usuario')),
                            );
                          } finally {
                            // Oculta el indicador de carga sin importar qué pase
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
                                  'Debes aceptar los términos y condiciones')),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        //Widget que nos permite poner un Boton de texto
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InicioDeSesion())); //Se usa el navigator.push para poder navegar entre pantallas.
                      },
                      child: Text(
                          "¿Ya tienes cuenta? Inicia sesión aqui", //Texto que sera boton.
                          style: TextStyle(
                            color: Color.fromARGB(239, 8, 8, 8),
                          )))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
