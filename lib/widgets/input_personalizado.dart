/**
 * Widget correspondiente a un Input personalizado.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final String label;
  final Icon icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function()? onTap;
  final TextInputType? keyboardType; // Añadir la opción para especificar el tipo de teclado
  final List<TextInputFormatter>? inputFormatters; // Añadir los inputFormatters


  const CustomInputField({
    Key? key,
    required this.hint,
    required this.label,  
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.onTap,
    this.keyboardType, // Agregar el nuevo parámetro
    this.inputFormatters, // Agregar el nuevo parámetro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: TextFormField(
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          autocorrect: false,
          obscureText: isPassword,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 2),
            ),
            hintText: hint,
            labelText: label,
            prefixIcon: icon,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
