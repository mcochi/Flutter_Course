class Coordinate {
  final int id;
  final String fechahora;
  final String latitud;
  final String longitud;

  Coordinate({this.id, this.fechahora, this.latitud, this.longitud});

  factory Coordinate.fromJson(Map<String,dynamic> json) {
    return Coordinate(
      id: json['id'],
      fechahora: json['fechahora'],
      latitud: json['latitud'],
      longitud: json['longitud']
    );
  }
}