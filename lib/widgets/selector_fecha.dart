/**
 * Widget correspondiente a un selector de fecha.
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class DatePickerField extends StatelessWidget {
  final String date;
  final Function(DateTime) onConfirm;

  const DatePickerField({
    Key? key,
    required this.date,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(1900, 1, 1),
          maxTime: DateTime(2101, 12, 31),
          onConfirm: onConfirm,
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      child: AbsorbPointer(
        child: TextFormField(
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "",
            labelText: date,
            prefixIcon: Icon(Icons.edit_calendar_outlined),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
