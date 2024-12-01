import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DisableNotificationsScreen extends StatefulWidget {
  @override
  _DisableNotificationsScreenState createState() =>
      _DisableNotificationsScreenState();
}

class _DisableNotificationsScreenState
    extends State<DisableNotificationsScreen> {
  bool isChecked = false;

  // Inicializa el plugin de notificaciones
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void deactivateNotifications() async {
    try {
      // Cancela todas las notificaciones programadas o activas
      await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
    }
  }

  // Función para programar una notificación diaria
  Future<void> activateNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Mexico_City'));
    await flutterLocalNotificationsPlugin.show(
      0,
      'Reactivacion de Notificaciones',
      'Recuerda revisar cualquier mancha o lunar con la aplicación.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'tu_id_diario',
          'Recordatorio Diario. Recordatorio para revisar manchas o lunares',
          channelDescription: 'Recordatorio para revisar manchas o lunares',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
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
          'Desactivar Notificaciones', // Texto centrado
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Deseas desactivar las notificaciones?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                      if (isChecked) {
                        deactivateNotifications();
                      } else {
                        activateNotifications();
                      }
                    });
                  },
                ),
                Text(
                  'Sí, desactivar notificaciones',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
