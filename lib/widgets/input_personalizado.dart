/**
 * Widget correspondiente a un Input personalizado.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final String label;
  final Icon icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function()? onTap;

  const CustomInputField({
    Key? key,
    required this.hint,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
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
