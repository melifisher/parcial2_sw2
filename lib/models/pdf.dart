class Pdf {
  final String nombre;
  final String fechaExamen;
  final String resultado;
  final String fechaResultado;
  final String observaciones;
  final String interpretacion;
  final String detalles;

  Pdf({
    required this.nombre,
    required this.fechaExamen,
    required this.resultado,
    required this.fechaResultado,
    required this.observaciones,
    required this.interpretacion,
    required this.detalles,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'fecha_examen': fechaExamen,
      'resultado': resultado,
      'fecha_resultado': fechaResultado,
      'observaciones': observaciones,
      'interpretacion': interpretacion,
      'detalles': detalles,
    };
  }

  factory Pdf.fromJson(Map<String, dynamic> map) {
    return Pdf(
      nombre: map['nombre'] ?? '',
      fechaExamen: map['fecha_examen'] ?? '',
      resultado: map['resultado'] ?? '',
      fechaResultado: map['fecha_resultado'] ?? '',
      observaciones: map['observaciones'] ?? '',
      interpretacion: map['interpretacion'] ?? '',
      detalles: map['detalles'] ?? '',
    );
  }
}
