import 'package:flutter/material.dart';

class InfoAppScreen extends StatelessWidget {
  const InfoAppScreen({Key? key}) : super(key: key);

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
          'Información sobre la app', // Texto centrado
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
                      'INFORMACIÓN SOBRE LA APLICACIÓN MÓVIL SKINCANBE',
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
                      'Nombre de la aplicación y su descripción',
                      'SkinCanBe es una aplicación móvil diseñada para la detección temprana de cáncer en la piel u otros tipos de lesiones benignas, mediante herramientas avanzadas de Inteligencia artificial. Se ofrece un diseño intuitivo para pacientes y especialista en dermatología.'),
                  _buildRichTextSection('Propósito principal',
                      'El objetivo principal de la app es proporcionar una herramienta accesible y confiable para ayudar a los pacientes a identificar posibles anomalías en la piel y conectarse con especialista expertos en la dermatología.'),
                  _buildRichTextSection('Público objetivo',
                      'Esta aplicación esta dirigida a personas mayores de 18 años preocupados por su salud dermatológica y a especialista que buscan optimizar la atención de sus pacientes. '),
                  _buildRichTextSection('Funcionalidades principales',
                      'Como funciones principales se tienen: \n\n1. Registro y autenticación de usuarios (pacientes y especialistas).\n\n2. Captura de imágenes de lesiones en la piel.\n\n3. Análisis inicial mediante inteligencia artificial.\n\n4. Resultados interpretados en tiempo real.\n\n5. Vinculación con especialistas.\n\n6. Historial de análisis y seguimiento de consultas mediante observaciones.'),
                  _buildRichTextSection('Tecnología utilizada',
                      'La aplicación móvil utiliza una red neuronal convolucional para el análisis de las imágenes de la piel capturadas. Además, se implementan estándares de seguridad avanzados para proteger tus datos personales, haciendo uso de tecnologías emergentes para un desarrollo más efectivo.'),
                  _buildRichTextSection('Compatibilidad',
                      'SkinCanBe esta disponible para dispositivos Android con versiones 8.0 o superior, y próximamente para iOS.'),
                  _buildRichTextSection('Requisitos mínimos',
                      'Para un funcionamiento óptimo, se requiere una conexión a internet estable, 400 MB de espacio libre en tu dispositivo móvil, además de aceptar permisos de cámara y almacenamiento.'),
                  _buildRichTextSection('Actualizaciones',
                      'Se hacen actualizaciones periódicas para mejorar la funcionalidad, la seguridad y la experiencia de usuario. Asegúrate de tener la versión mas reciente para aprovechar todas las características.'),
                  _buildRichTextSection('Colaboradores',
                      'La información acerca del cáncer en la piel, fue proporcionada por el Instituto Nacional de Cancerología ubicado en Av. San Fernando 22, Belisario Domínguez Sección 16, Tlalpan, C.P. 14080, Ciudad de México, CDMX. El equipo de SkinCanBe agradece todo el tiempo proporcionado para esta investigación.'),
                  _buildRichTextSection('Contacto y soporte',
                      'Si necesitas ayuda con la aplicación o tienes dudas, contáctanos por medio del correo electrónico skincanbejia@gmail.com.'),
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
