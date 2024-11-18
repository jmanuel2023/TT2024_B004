import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

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
          'Términos y condiciones', // Texto centrado
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
                      'TÉRMINOS Y CONDICIONES DEL USO DE LA APLICACIÓN MÓVIL SKINCANBE',
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
                      'I. OBJETO',
                      'El objeto es regular el acceso y utilización del contenido y servicios a disposición' +
                          'del público en general en la aplicación móvil Skincanbe.\nLos titulares se reservan el derecho de realizar cualquier tipo' +
                          'de modificación en la aplicación móvil en cualquier momento y sin previo aviso, el usuario acepta dichas modificaciones.\n' +
                          'Las modificaciones serán notificadas a través de la aplicación móvil y/o por correo electrónico.\nEl acceso a la aplicación' +
                          'móvil por parte del usuario es libre y gratuito, en un futuro, la utilización de los servicios implicaría un costo para el' +
                          'usuario. \nLa aplicación móvil solo admite el acceso a personas mayores de edad y no se hace responsable por el incumplimiento' +
                          'de esto. \nEn primeras instancias, la aplicación móvil está dirigida a usuarios residentes en México. \nLa administración de la' +
                          'aplicación móvil no podrá ejercerse por terceros, es decir, personas distintas al titular, esto para no afectar los presentes' +
                          'términos y condiciones.'),
                  _buildRichTextSection(
                      'II. USUARIO',
                      'Las actividades del usuario en la aplicación móvil como la captura y análisis de lesiones y' +
                          'vinculación con un especialista estarán sujetas a los presentes términos y condiciones. \nEl usuario se compromete a utilizar el contenido' +
                          'y servicios de forma lícita, sin faltar a la moral o al orden público, absteniéndose de realizar cualquier acto que afecte los derechos' +
                          'de terceros o el funcionamiento de la aplicación móvil. \nEl usuario se compromete a proporcionar información verídica en los formularios' +
                          'de la aplicación móvil. \nEl acceso a la aplicación móvil no supone una relación entre el usuario y los titulares de esta misma.' +
                          '\nEl usuario manifiesta ser mayor de edad y contar con la capacidad jurídica de acatar los presentes términos y condiciones.'),
                  _buildRichTextSection(
                    'III. ACCESO Y NAVEGACIÓN EN LA APLICACIÓN MÓVIL',
                    'Los titulares no garantizan la continuidad y disponibilidad del contenido y servicios en la aplicación móvil, realizaran' +
                        'acciones que fomenten el buen funcionamiento de dicha aplicación móvil sin responsabilidad alguna. \nLos titulares no se' +
                        'responsabilizan de que la aplicación móvil esté libre de errores que puedan causar un daño al software y hardware del' +
                        'dispositivo móvil en el cual el usuario accede a la aplicación móvil. De igual forma, no se responsabilizan por los daños' +
                        'causados por el acceso y/o utilización de la aplicación móvil. ',
                  ),
                  _buildRichTextSection(
                    'IV. POLÍTICA DE PRIVACIDAD Y PROTECCIÓN DE DATOS',
                    'Conforme a lo establecido en la Ley Federal de Protección de Datos Personales en Posesión de Particulares, los titulares' +
                        'se comprometen a tomar las medidas necesarias que garanticen la seguridad del usuario, evitando que se haga uso indebido' +
                        'de los datos personales que el usuario proporcione en la aplicación móvil. \nLos titulares corroboraran que los datos' +
                        'personales contenidos en las bases de datos sean correctos, verídicos y actuales, así como que se utilicen únicamente con' +
                        'el fin con el que fueron recabados. \nEl uso de datos personales se limitará a lo previsto en el Aviso de Privacidad disponible' +
                        'en el apartado Aviso de privacidad. \nSkincanbe se reserva el derecho de realizar cualquier tipo de modificación en el Aviso de' +
                        'Privacidad en cualquier momento y sin previo aviso, de acuerdo con sus necesidades o cambios en la legislación aplicable, ' +
                        'el usuario acepta dichas modificaciones. \nLa aplicación móvil implica la utilización del almacenamiento interno del dispositivo' +
                        'móvil, de esta forma se guardan datos necesarios para la sesión del usuario, además de poder guardar las imágenes de lesiones que' +
                        'se capturan y solo se utilizaran para mejorar la experiencia en la aplicación móvil. \nEl uso del almacenamiento interno del' +
                        'dispositivo móvil facilita la navegación y la hacen más amigable. No hay manera de desactivar, ya que es necesario para el' +
                        'funcionamiento de la aplicación móvil. ',
                  ),
                  _buildRichTextSection('V. POLÍTICA DE ENLACES',
                      'La aplicación móvil puede contener enlaces a sitios de internet pertenecientes a terceros de los cuales no se hace responsable.'),
                  _buildRichTextSection(
                    'VI. POLÍTICA DE PROPIEDAD INTELECTUAL E INDUSTRIAL',
                    'Los titulares manifiestan tener los derechos de propiedad intelectual de la aplicación móvil incluyendo imágenes, archivos PDF,' +
                        'logotipos, marcas, colores, estructuras, tipografías, diseños y demás elementos que lo distinguen, protegidos por la legislación' +
                        'mexicana e internacional en materia de propiedad intelectual e industrial. \nEl usuario se compromete a respetar los derechos de' +
                        'propiedad intelectual de los titulares pudiendo visualizar los elementos de la aplicación móvil, almacenarlos, copiarlos e ' +
                        'imprimirlos exclusivamente para uso personal. ',
                  ),
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
