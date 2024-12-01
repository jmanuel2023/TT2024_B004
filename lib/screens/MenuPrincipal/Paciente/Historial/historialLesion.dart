/**
 * Pantalla del historial de lesiones.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/CapturaDeImagen/compartirReporte.dart';
import 'package:skincanbe/screens/MenuPrincipal/Paciente/Historial/PantallaObservaciones.dart';
// import 'package:skincanbe/data/datoshistorial.dart';
import 'package:skincanbe/services/peticionesHttpLesion/LesionServices.dart';
import 'package:skincanbe/services/peticionesHttpReporte/ReporteServices.dart';

class Historial extends StatefulWidget {
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  final reporteService = ReporteServices();
  int?
      _expandedIndex; //Variable de ayuda para la expansion del widget PanelList
  final lesionServices = new LesionServices();
  late Future<List<dynamic>>? _lesiones = Future.value([]);
  String? id;
  String? token;

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    id = await storage.read(key: "idUsuario");
    token = await storage.read(key: "token");

    _lesiones = LesionServices().obtenerLesionesPorUsuarioId(id ?? "");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  //Widget que muestra el diseño de la pantalla
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(233, 214, 204, 1),
          title: Text(
            'Historial de lesiones', // Texto centrado
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
        body: FutureBuilder<List<dynamic>>(
            future: _lesiones,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(204, 87, 54, 1)));
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "No hay lesiones registradas",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ));
              } else {
                final lesiones = snapshot.data!;
                return SingleChildScrollView(
                  //Cuerpo de la pantalla
                  child: ExpansionPanelList.radio(
                    //Widget para la expansion de una lista de paneles
                    initialOpenPanelValue:
                        _expandedIndex, //Valor unico para identificar el panel
                    expandedHeaderPadding: EdgeInsets.all(8),
                    children: lesiones.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> lesionData = entry.value;
                      return ExpansionPanelRadio(
                        backgroundColor: Color.fromRGBO(233, 214, 204, 1),
                        value: index,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            //Widegt para crear lista de elementos
                            leading: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                    'assets/images/loading.gif', // Coloca aquí un GIF o imagen local para el loading
                                image: lesionData["imagen"],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) => Icon(Icons
                                        .error), // En caso de error al cargar la imagen
                              ),
                            ),

                            title: Text(
                              lesionData['nombre_lesion'] ?? 'Sin nombre',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(204, 87, 54, 1)),
                            ),
                            subtitle: Text(
                                'Fecha de registro: ${lesionData['fecha']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(204, 87, 54, 1))),
                          );
                        },
                        body: ListTile(
                          title: Text('Más detalles...'),
                          onTap: () {
                            _showBottomSheet(context, lesionData, token!,
                                reporteService); //Metodo para visualizar los detalles de la lesion en una mini pantalla
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            }));
  }
}

void _showBottomSheet(BuildContext context, Map<String, dynamic> lesionData,
    String token, ReporteServices servicioReporte) {
  showModalBottomSheet(
    backgroundColor: Color.fromRGBO(233, 214, 204, 1),
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        'assets/images/loading.gif', // Coloca aquí un GIF o imagen local para el loading
                    image: lesionData["imagen"],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) => Icon(
                        Icons.error), // En caso de error al cargar la imagen
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Resultados: ${lesionData['nombre_lesion']}",
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(204, 87, 54, 1),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Descripción: ${lesionData['descripcion']}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Porcentaje de coincidencia: ${lesionData['porcentaje']}",
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(204, 87, 54, 1),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompartirReporte(
                                    id_lesion:
                                        lesionData['id_lesion'].toString(),
                                    tipo_lesion: lesionData['nombre_lesion'],
                                    porcentaje: lesionData['porcentaje'],
                                  )));
                    },
                    child: Text("Generar reporte"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color.fromRGBO(204, 87, 54, 1),
                    textColor: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PantallaObservaciones(
                                  id_lesion: lesionData['id_lesion'])));
                    },
                    child: Text("Ver observaciones"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    textColor: Color.fromRGBO(204, 87, 54, 1),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
