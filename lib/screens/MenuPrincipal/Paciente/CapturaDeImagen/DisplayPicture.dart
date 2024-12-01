import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/CapturaDeImagen/InformacionLesion.dart';
//import 'package:skincanbe/services/api_services.dart';
import 'package:skincanbe/services/peticionesHttpLesion/LesionServices.dart';

class DisplayPicture extends StatefulWidget {
  final XFile imagen;
  final String id;

  DisplayPicture({required this.imagen, required this.id});

  @override
  _DisplaypictureState createState() => _DisplaypictureState();
}

class _DisplaypictureState extends State<DisplayPicture> {
  Color _colorFondo = Color.fromRGBO(204, 87, 54, 1);
  Color _colorLetra = Color.fromRGBO(255, 255, 255, 1);

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _mensajeConfirmacion();
  });
}

void _mensajeConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: _colorFondo,
          title: Text(
            'Confirmación de Captura',
            style: TextStyle(
              color: _colorLetra,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '¿Está satisfecho con la imagen? Si no, ajuste la distancia y el ángulo y vuelva a intentarlo.',
            style: TextStyle(
              color: _colorLetra,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Entendido',
                style: TextStyle(
                  color: _colorLetra,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _colocarDescripcion(String lesion){

    if(lesion == 'Nevo melanocitico'){
      return "No se encontraron indicios de cáncer.";
    }
    else if (lesion == 'Carcinoma basocelular'){
      return "Llagas abiertas, manchas rojas, crecimientos rosados, bultos brillantes, cicatrices o crecimientos con bordes ligeramente elevados y enrollados o con una hendidura central.";
    }
    else if (lesion == 'Queratosis seborreica'){
      return "Neoplasia cutánea común no cancerosa (benigna). Se presenta a menudo en personas de mayor edad, y se aparecen más de estas a medida que envejece la persona.";
    }
    else if (lesion == 'Queratosis actinica'){
      return "Mancha áspera y escamosa en la piel que se presenta después de años de exposición al sol, a menudo, aparece en la cara, labios, las orejas, los antebrazos, el cuero cabelludo, el cuello y el dorso de las manos.";
    }
    else if (lesion == 'Lesión vascular'){
      return "Daño o anormalidad que afecta los vasos sanguíneos del cuerpo, como las arterias, venas o capilares. Estas lesiones pueden ser congénitas (presentes desde el nacimiento) o adquiridas a lo largo de la vida debido a diversos factores, como enfermedades, traumatismos o infecciones.";
    }
    else if (lesion == 'Melanoma'){
      return "Se origina cuando los melanocitos (las células que dan el color a la piel) comienzan a crecer de una manera incontrolable. Este tipo de cáncer no es tan frecuente a comparación de los otros tipos de cáncer, pero si es el más peligroso, ya que es mucho más probable que se propague a otras partes del cuerpo si no se descubre y trata a tiempo.";
    }
    else if (lesion == 'Dermatofibroma'){
      return "Tumor cutáneo benigno originado por una proliferación excesiva del tejido fibroso de la dermis, la capa intermedia de la piel.";
    }
    else{
      return "Otro tipo de lesión";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
        title: Text(
          'Foto capturada', // Texto centrado
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Se muestra la imagen que se capturo
          Expanded(
              child: Center(
            child: Image.file(File(widget.imagen.path)),
          )),
          Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text("Confirmar"),
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.green,
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Foto confirmada")));
                        /** AQUI VA LA API */
                        final lesionService = LesionServices();
                        // final api_service = ApiServicios();
                        // final respuesta =
                        //     await api_service.peticion_api(widget.imagen);
                        // final String nombreLesion =
                        //     respuesta['predicted_class'];
                        //  final String porcentaje = respuesta['prob'];
                        //
                        final String nombreLesion = "Nevo melanocitico";
                        final String porcentaje = "%67.23";

                        
                        final String descripcion = _colocarDescripcion(nombreLesion);
                        try {
                          // Llamar al servicio para registrar la lesión
                          final data = await lesionService.registrarLesion(
                              widget.id,
                              widget.imagen,
                              nombreLesion,
                              descripcion, porcentaje);
                          // Verificar si data no es nulo y contiene los datos esperados
                          if (data['id_lesion'] != null) {
                            // Asegúrate de que 'id' sea una clave que esperas en la respuesta
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Lesión registrada correctamente")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InformacionLesion(
                                        nombreLesion: nombreLesion,
                                        descripcion: descripcion,
                                        porcentaje: porcentaje,
                                        imagen: widget.imagen,
                                        idLesion:
                                            data['id_lesion'].toString())));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("No se ha podido guardar la lesión")));
                          }
                        } catch (e) {
                          // Manejo de excepciones para errores que puedan ocurrir al registrar la lesión

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Error al registrar la lesión: ${e.toString()}")));
                        }
                      },
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        label: Text("Volver a tomar"),
                        style: ElevatedButton.styleFrom(
                          iconColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ]))
        ],
      ),
    );
  }
}
