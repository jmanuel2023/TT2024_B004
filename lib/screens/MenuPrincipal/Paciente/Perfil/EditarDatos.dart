import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
// import 'package:skincanbe/screens/MenuPrincipal/Paciente/PatientScreen.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';
import 'package:skincanbe/widgets/boton_enviar.dart';
import 'package:skincanbe/widgets/input_personalizado.dart';

class EditDataScreen extends StatefulWidget {
  @override
  _EditDataScreenState createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  UserService userService = UserService();
  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? token;
  String? id;
  bool _isLoading = true;
  bool _isChangePassword = false;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    id = await storage.read(key: "idUsuario");
    _cargarDatosFormulario();
  }

  Future<void> _cargarDatosFormulario() async {
    try {
      final userData = await userService.obtenerUsuario(id!, token!);

      // Rellena los controladores con los datos obtenidos
      _nombreController.text = userData['nombre'];
      _apellidosController.text = userData['apellidos'];

      // Una vez que los datos están cargados, quita el estado de carga
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener datos del usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los datos del usuario')),
      );
      setState(() {
        _isLoading =
            false; // Quitar el estado de carga incluso en caso de error
      });
    }
  }

  @override
  void dispose() {
    // Liberar recursos cuando el widget se destruye
    _nombreController.dispose();
    _apellidosController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          'Editar Datos', // Texto centrado
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      //Campo para que el usuario ingrese su nombre
                      hint: "Juan", label: "Introduzca su nombre(s)",
                      icon: Icon(Icons.person_outline_outlined),
                      controller:
                          _nombreController, // Asignar el controlador aquí
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa tu nombre';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    CustomInputField(
                      //Campo para que el usuario ingrese su nombre
                      hint: "Pérez Perez",
                      label: "Introduzca sus apellidos",
                      icon: Icon(Icons.person_outline_outlined),
                      controller:
                          _apellidosController, // Asignar el controlador aquí
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa tu apellido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChangePassword,
                          onChanged: (value) {
                            setState(() {
                              _isChangePassword = value!;
                            });
                          },
                        ),
                        Text("¿Desea cambiar la contraseña?"),
                      ],
                    ),
                    if (_isChangePassword) // Mostrar el campo de contraseña si el checkbox está marcado
                      CustomInputField(
                        hint: "******",
                        label: "Introduzca una contraseña",
                        icon: Icon(Icons.lock_outlined),
                        isPassword: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (_isChangePassword) {
                            return (value != null && value.length >= 6)
                                ? null
                                : 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    SizedBox(height: 32),
                    Center(
                      child: SubmitButton(
                          text: "Editar Datos",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                // Capturamos los valores de los TextEditingController
                                String nombre = _nombreController.text;
                                String apellidos = _apellidosController.text;
                                String contra = _isChangePassword
                                    ? _passwordController.text
                                    : "";
                                // Llamada al método de registro de usuario
                                String respuesta =
                                    await userService.editarUsuario(
                                        id!, nombre, apellidos, contra, token!);

                                print("Respuesta:" + respuesta);

                                if (int.parse(respuesta) == 1) {
                                  print("Entre al if del 1");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Datos actualizados correctamente!, vuelve a iniciar sesión")),
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InicioDeSesion()));
                                } else if (int.parse(respuesta) == 2) {
                                  print("entre al else if");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Error al editar los datos intentalo mas tarde")),
                                  );
                                }
                              } catch (e) {
                                print('Error al editar el usuario: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Hubo un error al editar los datos del usuario')),
                                );
                              }
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
