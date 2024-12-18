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
  final TextInputType? keyboardType; 
  final List<TextInputFormatter>? inputFormatters;


  const CustomInputField({
    Key? key,
    required this.hint,
    required this.label,  
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.onTap,
    this.keyboardType, 
    this.inputFormatters, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: TextFormField(
          style: TextStyle(
            color: Colors.black
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          autocorrect: false,
          obscureText: isPassword,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(204, 87, 54, 1)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(204, 87, 54, 1), width: 2),
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
