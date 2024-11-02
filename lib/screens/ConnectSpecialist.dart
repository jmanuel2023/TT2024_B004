import 'package:flutter/material.dart';


class ConnectSpecialist extends StatefulWidget {
  const ConnectSpecialist({super.key});

  @override
  _ConnectSpecialistState createState() => _ConnectSpecialistState();
}

class _ConnectSpecialistState extends State<ConnectSpecialist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Vincular con Especialista"),
            Image.asset("assets/images/logo.png", width: 45, height: 45),
          ],
        ),
        leading: Icon(Icons.arrow_back), // Flecha de regreso
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de búsqueda
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Lista de especialistas
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Número de especialistas
                itemBuilder: (context, index) {
                  return EspecialistaCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
}
}
 
class EspecialistaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icono de persona
            Icon(
              Icons.person,
              size: 40,
            ),
            SizedBox(width: 10),
            // Información del especialista
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nombre Especialista",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("Correo: especialista@ejemplo.com"),
                  Text("Cédula: 123456"),
                ],
              ),
            ),
            // Botón de acción
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              child: Text("Vincular"),
            ),
          ],
        ),
      ),
    );
  }
}
