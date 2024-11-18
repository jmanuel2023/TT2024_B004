import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

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
          'Aviso de privacidad', // Texto centrado
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Text(
                      'AVISO DE PRIVACIDAD DE LA APLICACIÓN MÓVIL SKINCANBE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRichTextSection(
                      'Lea cuidadosamente...',
                      'El equipo de SkinCanBe, ubicado en ESCOM IPN, Unidad Profesional Adolfo López Mateos, Av. Juan de Dios Bátiz, Nueva ' +
                          'Industrial Vallejo, Alcaldía Gustavo I. Madero, Ciudad de México, CDMX. C.P. 07320 , conforme a lo establecido en la Ley ' +
                          'Federal de Protección de Datos en Posesión de Particulares, pone a disposición de nuestros pacientes y especialistas y ' +
                          'público en general, nuestro Aviso de Privacidad. \n\nLos datos personales que nos proporciona son utilizados estrictamente en ' +
                          'la realización de funciones propias de nuestra empresa y por ningún motivo serán transferidos a terceros.\n\nA nuestros usuarios ' +
                          '(pacientes y especialistas) les solicitamos los siguientes datos personales: \n\nNombre completo (Nombre de pila y apellidos): ' +
                          'Ayudan a identificarse dentro de la aplicación móvil. \n\nCorreo electrónico en uso: Se usa como medio de comunicación, además sirve ' +
                          'para ingresar a la aplicación móvil. \n\nEdad: Se solicita este dato para asegurar de que el usuario sea mayor de edad. \n\nContraseña: ' +
                          'Dato que sirve para el ingreso a la aplicación móvil. \n\nIdentificador de tipo de usuario (Paciente o especialista): Dato para ' +
                          'identificar el tipo de usuario que se está registrando. En caso de que se especifique como Especialista, se solicita la cedula ' +
                          'profesional.\n\nEn caso de realizar modificaciones al presente Aviso de Privacidad, le informaremos mediante correo electrónico y ' +
                          'redes sociales.'),
                  _buildRichTextSection(
                      '__________________________________________',
                      'He leído y acepto los términos del presente Aviso de Privacidad.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichTextSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
