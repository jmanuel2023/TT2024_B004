import 'package:flutter/material.dart';

class PrivacyPoliciesScreen extends StatelessWidget {
  const PrivacyPoliciesScreen({Key? key}) : super(key: key);

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
          'Políticas de privacidad', // Texto centrado
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
                      'POLÍTICAS DE PRIVACIDAD DE LA APLICACIÓN MÓVIL SKINCANBE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildRichTextSection('Introducción',
                      'En SkinCanBe, tu privacidad es nuestra prioridad. Este apartado se detalla cómo se recopilará, usará, compartirá y protegerá tu información personal al utilizar nuestra aplicación móvil. Al usar nuestra app, aceptas estas politicas de privacidad.'),
                  _buildRichTextSection('Información que recopilamos',
                      'Se recopilará información como el nombre, correo electrónico, edad, contraseña y cedula (en caso de identificarse como especialista). De igual forma se obtiene datos técnicas, como la dirección IP de tu dispositivo e información sobre tu sistema operativo.'),
                  _buildRichTextSection('¿Cómo usamos la información?',
                      'Se usará la información para poder identificarte en la app, personalizar tu experiencia, y enviarte comunicados relacionados con tu cuenta o actualizaciones de la aplicación.'),
                  _buildRichTextSection('Compartición de datos',
                      'Se compartirá información con proveedores de servicios esenciales, como el almacenamiento mediante una base de datos en la nube, sin embargo, nunca se harán tratos comerciales con tu información con terceros.'),
                  _buildRichTextSection('Seguridad de los datos',
                      'Se implementan medidas de seguridad avanzadas, como la encriptación de los controles de acceso como la contraseña, todo esto con el propósito de proteger tus datos. Sin embargo, ninguna aplicación móvil es completamente segura, por lo que no podemos garantizar protección absoluta.'),
                  _buildRichTextSection('Derechos de los usuarios',
                      'Se tiene todo el derecho de acceder, corregir o eliminar tu información personal en el cualquier momento. Para saber mas acerca, de esto, por favor contáctanos vía correo electrónico a skincanbejia@gmail.com.'),
                  _buildRichTextSection('Retención de datos',
                      'Los datos personales que se recopilan serán almacenados únicamente durante el tiempo necesario para cumplir los propósitos, que normalmente es hasta que se decide eliminar la cuenta.'),
                  _buildRichTextSection('Cambios en las politicas',
                      'Estas politicas de privacidad no están libres de cambios, por lo tanto, se notificará a través del correo electrónico con el cual se registró su cuenta en caso de que haya algún tipo de cambio.'),
                  _buildRichTextSection('Uso para menores de edad',
                      'Aunque la app no esta hecha para ser consumida por menores de edad, esta se puede utilizar siempre y cuando sea necesario analizar una lesión cuya aspecto sea anormal y esto siempre será acompañado por alguien mayor de edad, como el padre o tutor.'),
                  _buildRichTextSection('Contacto',
                      'Si tienes alguna pregunta o inquietud sobre lo que esta descrito en estas Politicas de Privacidad, puedes contactarnos mediante el correo electrónico skincanbejia@gmail.com.'),
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
