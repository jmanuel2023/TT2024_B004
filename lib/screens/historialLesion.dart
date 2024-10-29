/**
 * Pantalla del historial de lesiones.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
// import 'package:skincanbe/data/datoshistorial.dart';
import 'package:skincanbe/services/LesionServices.dart';

class Historial extends StatefulWidget {
  /*final String? usuarioId;
  const Historial({this.usuarioId});*/

  @override
  _HistorialState createState() => _HistorialState();
}



class _HistorialState extends State<Historial> {

  int? _expandedIndex; //Variable de ayuda para la expansion del widget PanelList
  final lesionServices = new LesionServices();
  late Future<List<dynamic>>? _lesiones = Future.value([]);
  String? id;

  Future<void> _cargarDatos() async {
    final storage = FlutterSecureStorage();
    id = await storage.read(key: "idUsuario");

    
    _lesiones = LesionServices().obtenerLesionesPorUsuarioId(id ?? "");

    setState(() {
    });
  }
  
  @override
  void initState() {
    super.initState();
    _cargarDatos();
   
  }

   String obtenerNombreOriginal(String nombreConPrefijo) {
  int index = nombreConPrefijo.indexOf('_');
  return index != -1 ? nombreConPrefijo.substring(index + 1) : nombreConPrefijo;
}
  
  @override
  //Widget que muestra el diseño de la pantalla
  Widget build(BuildContext context) {

    final ancho = MediaQuery.of(context).size; //Variable para calcular el tamaño de la pantalla
    return Scaffold(
      appBar: AppBar( //Widget para el diseño de la barra superior de la pantalla
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(233, 214, 204, 1),
          title: Row( //Titulo de la barra superior
            children: [
              SizedBox(width: ancho.width * 0.01),
              Text("Historial de lesiones",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.065),
              Image.asset("assets/images/logo.png",
              width: 45,
              height: 45
              ),
            ],
          ),
        ),
        body:FutureBuilder<List<dynamic>>(
        future: _lesiones,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay lesiones registradas"));
          } else {
            final lesiones = snapshot.data!; 
        return SingleChildScrollView( //Cuerpo de la pantalla
        child: ExpansionPanelList.radio( //Widget para la expansion de una lista de paneles
          initialOpenPanelValue: _expandedIndex,//Valor unico para identificar el panel
          expandedHeaderPadding: EdgeInsets.all(8),
          children: lesiones.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> lesionData = entry.value;

             // Obtener el nombre de archivo sin el prefijo
            String nombreImagenOriginal = obtenerNombreOriginal(lesionData['imagen']);


            return ExpansionPanelRadio( //Retorna un panel con la información necesaria de la lesión
              value: index,
              headerBuilder: (context, isExpanded) {
                return ListTile( //Widegt para crear lista de elementos
                  leading: ClipOval(
                    child: Image.file(File("/data/user/0/com.example.skincanbe/cache/"+ nombreImagenOriginal),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover
                    ),
                    ),
                  title: Text(lesionData['nombre_lesion'] ?? 'Sin nombre'),
                  subtitle: Text("Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
                );
              },
              body: ListTile(
                title: Text('Más detalles...'),
                onTap: () {
                  _showBottomSheet(context, lesionData, nombreImagenOriginal); //Metodo para visualizar los detalles de la lesion en una mini pantalla
                },
              ),
            );
          }).toList(),
        ),
      );
          }  
        }
        )
    );
  }
}

 void _showBottomSheet(BuildContext context, Map<String, dynamic> lesionData, String imagen) {

    showModalBottomSheet(
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
                    child: Image.file(File(
                      "/data/user/0/com.example.skincanbe/cache/"+ imagen
                    ),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),     
                SizedBox(height: 8),
                Text("Resultados: ${lesionData['nombre_lesion']}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent),
                ),
                SizedBox(height: 8),
                Text("Descripción: ${lesionData['descripcion']}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
 }

