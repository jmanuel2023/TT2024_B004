/**
 * Pantalla del historial de lesiones.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skincanbe/data/datoshistorial.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {

  int? _expandedIndex; //Variable de ayuda para la expansion del widget PanelList
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
        body: SingleChildScrollView( //Cuerpo de la pantalla
        child: ExpansionPanelList.radio( //Widget para la expansion de una lista de paneles
          initialOpenPanelValue: _expandedIndex,//Valor unico para identificar el panel
          expandedHeaderPadding: EdgeInsets.all(8),
          children: datoshistorial.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> lesionData = entry.value;

            return ExpansionPanelRadio( //Retorna un panel con la información necesaria de la lesión
              value: index,
              headerBuilder: (context, isExpanded) {
                return ListTile( //Widegt para crear lista de elementos
                  leading: ClipOval(
                    child: Image.network(lesionData['imagen']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover
                    )
                    ),
                  title: Text(lesionData['ubicacion']!),
                  subtitle: Text("Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),
                );
              },
              body: ListTile(
                title: Text('Más detalles...'),
                onTap: () {
                  _showBottomSheet(context, lesionData); //Metodo para visualizar los detalles de la lesion en una mini pantalla
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

 void _showBottomSheet(BuildContext context, Map<String, String> lesionData) {

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
                    child: Image.network(
                      lesionData['imagen']!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text("Nombre: ${lesionData['nombre']}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    ),
                ),
                SizedBox(height: 8),
                Text("Ubicación: ${lesionData['ubicacion']}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text("Resultados: ${lesionData['resultados']}",
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