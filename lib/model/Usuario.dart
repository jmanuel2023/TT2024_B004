/**
 * Modelo de datos de Usuario
 * Proyecto: SkinCanBe
 * Equipo: 
 * Manuel Morales Joan Hanzka
 * Ojeda Gomez Angelo Mihaelle
 * Rodriguez Juarez Israel.
 */

/*Clase para representar a los usuarios de manera estructurada, 
facilitando el manejo de datos asociado, ya sea un paciente o un especialista*/
class Usuario {
  final int id;
  final String nombre;
  final String apellidos;
  final int edad;
  final String correo;
  final String password;
  final String tipoUsuario;
  String? cedula;
  String status;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.edad,
    required this.correo,
    required this.password,
    required this.tipoUsuario,
    this.cedula, //Este campo es opcional, ya que solo especialista lo puede tener
    this.status = 'Pendiente', 
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      edad: json['edad'],
      correo: json['correo'],
      password: json['password'],
      tipoUsuario: json['tipo_usuario'],
      cedula: json['cedula'], 
      status: json['status'] ?? 'Pendiente',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'edad': edad,
      'correo': correo,
      'password': password,
      'tipo_usuario': tipoUsuario,
      'cedula': cedula, 
      'status': status,
    };
  }
}
