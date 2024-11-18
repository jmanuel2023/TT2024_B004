/**
 * Pantalla de configuración.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

/*Pantalla para la configuracion de la aplicacion para el usuario */
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/InicioDeSesion/inicio_sesion.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/DesactivarNotificacion.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Perfil/EditarDatos.dart';
import 'package:skincanbe/services/peticionesHttpUsuario/UserServices.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  UserService userService = UserService();
  String? token;
  String? id;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    token = await storage.read(key: "token");
    id = await storage.read(key: "idUsuario");
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
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        title: Text(
          'Configuración', // Texto centrado
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMenuOption(
              context,
              'Desactivar Notificaciones',
              Icons.notifications_off,
              () {
                // Acción para desactivar notificaciones
                print('Desactivar Notificaciones');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisableNotificationsScreen()));
              },
            ),
            SizedBox(height: 16),
            _buildMenuOption(
              context,
              'Editar Datos',
              Icons.edit,
              () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditDataScreen()));
              },
            ),
            SizedBox(height: 16),
            _buildMenuOption(
              context,
              'Eliminar Cuenta',
              Icons.delete,
              () {
                // Mostrar un diálogo de confirmación
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmación'),
                      content: Text(
                          '¿Estás seguro de que deseas eliminar tu cuenta? Esta acción no se puede deshacer.'),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            // Cerrar el diálogo sin hacer nada
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Eliminar'),
                          onPressed: () async {
                            try {
                              String respuesta = await userService
                                  .eliminarUsuario(id!, token!);
                              if (respuesta == "Eliminada") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Cuenta eliminada correctamente."),
                                  ),
                                );
                                // Redirigir al usuario al inicio de sesión
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InicioDeSesion()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Error al eliminar la cuenta, intenta más tarde."),
                                  ),
                                );
                              }
                            } catch (e) {
                              print('Error al eliminar la cuenta: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Ocurrió un error al intentar eliminar la cuenta."),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(233, 214, 204, 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Color.fromRGBO(204, 87, 54, 1)),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
