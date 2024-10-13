class Usuario {
  final int id;
  final String nombre;
  final String apellidos;
  final int edad;
  final String correo;
  final String password;
  final String tipoUsuario;
  String? cedula; // Campo opcional
  String status;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.edad,
    required this.correo,
    required this.password,
    required this.tipoUsuario,
    this.cedula, // Opcional
    this.status = 'Pendiente',
  });

  // Asegúrate de incluir este campo en el mapeo de JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      edad: json['edad'],
      correo: json['correo'],
      password: json['password'],
      tipoUsuario: json['tipo_usuario'],
      cedula: json['cedula'], // Podría ser null si no existe
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
      'cedula': cedula, // Puede ser null
      'status': status,
    };
  }
}
