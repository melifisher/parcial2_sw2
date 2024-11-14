class Resultado {
  final int id;
  final String resultado;
  final String fecha;
  final String observaciones;
  final String interpretacion;
  final String detalles;
  final int testId;

  Resultado({
    required this.id,
    required this.resultado,
    required this.fecha,
    required this.observaciones,
    required this.interpretacion,
    required this.detalles,
    required this.testId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resultado': resultado,
      'fecha': fecha,
      'observaciones': observaciones,
      'interpretacion': interpretacion,
      'detalles': detalles,
      'test_id': testId,
    };
  }

  factory Resultado.fromJson(Map<String, dynamic> map) {
    return Resultado(
      id: map['id'] is String ? int.parse(map['id']) : map['id'],
      resultado: map['resultado'] ==null? '':map['resultado'] ,
      fecha: map['fecha'] ==null? '': map['fecha'],
      observaciones: map['observaciones'] ==null? '':map['observaciones'],
      interpretacion: map['interpretacion'] ==null? '': map['interpretacion'],
      detalles: map['detalles'] ==null? '':map['detalles'],
      testId: map['test_id'] is String ? int.parse(map['test_id']) : map['test_id'],
    );
  }
}
