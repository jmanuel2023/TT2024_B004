import 'package:flutter/material.dart';

void main() => runApp(const EsperaConfirmacion());

class EsperaConfirmacion extends StatefulWidget {
  const EsperaConfirmacion({super.key});

  @override
  _EsperaConfirmacionState createState() => _EsperaConfirmacionState();
}

class _EsperaConfirmacionState extends State<EsperaConfirmacion> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: size.height*0.15),
            decoration: const BoxDecoration(                                        //el encabezado con el logo, y los botones que se usan para
            gradient: LinearGradient(colors: [                                      //registrarse o iniciar sesion
            Color.fromRGBO(233, 214, 204, 1),
            Color.fromRGBO(230, 226, 224, 1)]
            ),
          ),
            child: Column(
              children: [
                Icon(Icons.mark_email_read, size: 300),
                SizedBox(height:20,),
                Text(
                "Favor de confirmar la existencia de su cuenta de correo electrónico.",
                style: TextStyle(
                  fontSize: 18.0, // Tamaño de la fuente
                  fontWeight: FontWeight.w600, // Grosor de la fuente
                  color: Colors.black87, // Color del texto
                 letterSpacing: 1.2, // Espaciado entre letras
                ),
                textAlign: TextAlign.center, // Centrar el texto
              ),
                SizedBox(height:20),
                Text("Haz clic en el enlace que se hizo llegar al correo electrónico que ingresaste.",
                style: TextStyle(
                  fontSize: 18.0, // Tamaño de la fuente
                  fontWeight: FontWeight.w600, // Grosor de la fuente
                  color: Colors.black87, // Color del texto
                 letterSpacing: 1.2, // Espaciado entre letras
                ),
                textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                Container(
                padding: EdgeInsets.all(20),
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 189, 187, 187),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [                          //Aqui se le da un estilo al container que contendra los botones
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15,
                      offset: Offset(0, 5)
                    )                    
                  ]),
                  child: Row(
                    children: [
                      MaterialButton(onPressed: (){},
                    shape: RoundedRectangleBorder(                                      //ESTILO DEL BOTON PROPIAMENTE PARA DESPUES USAR CADA UNO DE LOS
                    borderRadius: BorderRadius.circular(10)),
                    color: Color.fromARGB(255, 248, 240, 240),                                                     //ELEMENTOS QUE SE ENVIARON CUANDO SE MANDO A LLAMAR ESTE METODO
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Editar Correo", style: TextStyle(color: Colors.black,)),
                      ),
                    ),
                    SizedBox(width: 40,),
                    MaterialButton(onPressed: (){},
                    shape: RoundedRectangleBorder(                                      //ESTILO DEL BOTON PROPIAMENTE PARA DESPUES USAR CADA UNO DE LOS
                    borderRadius: BorderRadius.circular(10)),
                    color: const Color.fromARGB(255, 12, 12, 12),                                                     //ELEMENTOS QUE SE ENVIARON CUANDO SE MANDO A LLAMAR ESTE METODO
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Reenviar Correo", style: TextStyle(color: Color.fromARGB(255, 236, 234, 234),)),
                      ),
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        )
        );
  }
}