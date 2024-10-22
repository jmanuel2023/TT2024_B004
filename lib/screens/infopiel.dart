/**
 * PantalLa de Informacion sobre la piel.
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
  List<Item> _data = infodatospiel.map((item) {
    return Item(
      expandedValue: item['expandedValue']!, 
      headerValue: item['headerValue']!,
      description: item['description']!,
      );
  }).toList();

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(233, 214, 204, 1), 
          /*leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const PantallaEntrada())
            );
          }, //iconSize: 35,
          ),*/
          title: Row(
            children: [
              //SizedBox(width: 1),
              Text("Todo acerca sobre la piel",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(width: ancho.width * 0.04),
              Image.asset("assets/images/logo.png", width: 45, height: 45),
            ],
          ),
        ),
      body: Container(
        padding: EdgeInsets.all(10),
//        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ExpansionPanelList.radio(
            dividerColor: Colors.grey[500],
            initialOpenPanelValue: null,
            children: _data.map<ExpansionPanelRadio>((Item item){
              return ExpansionPanelRadio(
                //backgroundColor: Colors.grey,
                value: item.headerValue,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    subtitle: Text(item.description) ,
                    title: Text(item.headerValue),
                    trailing: Text("Abrir"),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(title: Text(item.expandedValue, style: TextStyle(fontWeight: FontWeight.bold),),
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



