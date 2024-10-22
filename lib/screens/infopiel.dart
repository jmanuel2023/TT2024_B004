/**
 * Pantalla de Información sobre la piel.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:skincanbe/data/infodatospiel.dart';


class InfoPiel extends StatefulWidget {
  const InfoPiel({super.key});

  @override
  _InfoPielState createState() => _InfoPielState();
}

class _InfoPielState extends State<InfoPiel> {
  // Crea una lista de objetos Item a partir de los datos obtenidos de infodatospiel.
// La lista se genera mapeando cada elemento en infodatospiel, que se asume es una colección de mapas.
  List<Item> _data = infodatospiel.map((item) {
    return Item(
      expandedValue: item['expandedValue']!, 
      headerValue: item['headerValue']!,
      description: item['description']!,
      );
  }).toList();
  /*El metodo map, devuelve un iterable, pero no tiene la estructura de una lista, por eso hay que 
  convertilo a una lista, es por ello que hasta el ultimo tiene .toList(); */

  @override
  //Widget para mostrar el diseño de la pantalla
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size; //Variable para calcular el tamaño de la pantalla
    return Scaffold(
      appBar: AppBar( //Widget para el diseño de la barra superior de la pantalla
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(233, 214, 204, 1), 
          title: Row(
            children: [
              Text("Todo acerca sobre la piel",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.04),
              Image.asset("assets/images/logo.png", 
              width: 45, 
              height: 45
              ),
            ],
          ),
        ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: ExpansionPanelList.radio( //Widget para la expansion de una lista de paneles
            dividerColor: Colors.grey[500],
            initialOpenPanelValue: null,
            children: _data.map<ExpansionPanelRadio>((Item item){
              return ExpansionPanelRadio( //Widget para mostrar los paneles
                value: item.headerValue,
                headerBuilder: (
                  BuildContext context, 
                  bool isExpanded
                  ) {
                  return ListTile(
                    subtitle: Text(item.description) ,
                    title: Text(item.headerValue),
                    trailing: Text("Abrir"),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(item.expandedValue, 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                        ),
                  ),
                ),
              );
            }).toList(),
          )
        ),
      ),
    );
  }
}
//Clase personalizada para el objeto Item
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.description
  });
  String expandedValue;
  String headerValue;
  String description;
}



