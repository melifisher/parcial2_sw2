class Usuario {
  final int id;
  final String user;
  final String password;
  final String nombre;
  final String apellidos;
  final String sexo;
  final DateTime fnac;
  final int telefono;
  final String correo;
  final String rol;
  final String fotopath;
  final String especialidad;

  Usuario({
    required this.id,
    required this.user,
    required this.password,
    required this.nombre,
    required this.apellidos,
    required this.sexo,
    required this.fnac,
    required this.telefono,
    required this.correo,
    required this.rol,
    required this.fotopath,
    required this.especialidad,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'password': password,
      'nombre': nombre,
      'apellidos': apellidos,
      'sexo': sexo,
      'fnac': fnac.toIso8601String(),
      'telefono': telefono,
      'correo': correo,
      'rol': rol,
      'fotopath': fotopath,
      'especialidad': especialidad,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] is String ? int.parse(map['id']) : map['id'],
      user: map['user'],
      password: map['password'] == null ? '' : map['password'],
      nombre: map['nombre'] == null ? '' : map['nombre'],
      apellidos: map['apellidos'] == null ? '' : map['apellidos'],
      sexo: map['sexo'] == null ? '' : map['sexo'],
      fnac: map['fnac'] == null ? DateTime.parse(map['fnac']) : DateTime.now(),
      telefono: map['telefono'] == null ? int.parse(map['telefono']) : 0,
      correo: map['correo'] == null ? '' : map['correo'],
      rol: map['rol'] == null ? '' : map['rol'],
      fotopath: map['fotopath'] == null ? '' : map['fotopath'],
      especialidad: map['especialidad'] == null ? '' : map['especialidad'],
    );
  }
}
