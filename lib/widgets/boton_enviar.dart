/**
 * Widget correspondiente a un boton de submit.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading; // Nuevo parámetro

  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // Valor por defecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? null : onPressed, // Deshabilita el botón si está cargando
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color.fromARGB(255, 226, 222, 222),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color.fromRGBO(204, 87, 54, 1),
                ),
              )
            : Text(
                text,
                style: TextStyle(color: const Color.fromARGB(255, 10, 10, 10)),
              ),
      ),
    );
  }
}
