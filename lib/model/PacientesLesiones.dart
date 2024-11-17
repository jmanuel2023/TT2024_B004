

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

  Lesion({required this.nombre, required this.descripcion, required this.imagen, required this.id_lesion});

  factory Lesion.fromJson(Map<String, dynamic> json) {
    return Lesion(
      id_lesion: json['id_lesion'],
      nombre: json['nombre_lesion'],
      descripcion: json['descripcion'],
      imagen: json['imagen']
    );
  }
}