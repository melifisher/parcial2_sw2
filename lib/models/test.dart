class Test {
  final int id;
  final String nombre;
  final String fecha;
  final String fechaEntrega;
  final String estado;
  final String observaciones;
  final String calificacion;
  final int userId;

  Test({
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.fechaEntrega,
    required this.estado,
    required this.observaciones,
    required this.calificacion,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fecha': fecha,
      'fechaEntrega': fechaEntrega,
      'estado': estado,
      'observaciones': observaciones,
      'calificacion': calificacion,
      'userId': userId,
    };
  }

  factory Test.fromJson(Map<String, dynamic> map) {
    return Test(
      id: int.parse(map['id']),
      nombre: map['nombre'] ?? '',
      fecha: map['fecha'] ?? '',
      fechaEntrega: map['fechaEntrega'] ?? '',
      estado: map['estado'] ?? '',
      observaciones: map['observaciones'] ?? '',
      calificacion: map['calificacion'] ?? '',
      userId: int.parse(map['userId']),
    );
  }
}
