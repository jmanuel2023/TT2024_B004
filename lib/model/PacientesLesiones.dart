import 'package:intl/intl.dart';

class Paciente {
  final String nombre;
  final String correo;
  final String apellidos;
  final List<Lesion> lesiones;

  Paciente({required this.nombre, required this.correo, required this.apellidos, required this.lesiones});

  factory Paciente.fromJson(Map<String, dynamic> json) {
    var lesionesFromJson = json['lesiones'] as List;
    List<Lesion> lesionesList = lesionesFromJson.map((i) => Lesion.fromJson(i)).toList();

    return Paciente(
      nombre: json['nombre'],
      correo: json['correo'],
      apellidos: json['apellidos'],
      lesiones: lesionesList,
    );
  }
}

class Lesion {
  final int id_lesion;
  final String nombre;
  final String descripcion;
  final String imagen;
  final String porcentaje;
  final DateTime fecha;

  Lesion({required this.nombre, required this.descripcion, required this.imagen, required this.id_lesion, required this.porcentaje, required this.fecha});

  factory Lesion.fromJson(Map<String, dynamic> json) {
    return Lesion(
      id_lesion: json['id_lesion'],
      nombre: json['nombre_lesion'],
      descripcion: json['descripcion'],
      porcentaje: json['porcentaje'],
      imagen: json['imagen'],
      fecha: DateTime.parse(json['fecha']),
    );
  }
   String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(fecha); // Ejemplo: "2023-11-23"
  }
}