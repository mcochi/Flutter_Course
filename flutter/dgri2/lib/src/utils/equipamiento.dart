

class Equipamiento {
  final String inv;
  final String descripcion;
  final String marca;
  final String modelo;
  final String dto;

  Equipamiento({this.inv, this.descripcion, this.marca, this.modelo, this.dto});

  factory Equipamiento.fromJson(Map<String,dynamic> json) {
    return Equipamiento(
      inv: json['INV'],
      descripcion: json['DESCRIPCION'],
      marca: json['MARCA'],
      modelo: json['MODELO'],
      dto: json['dto']
    );
  }
}






/*
class Convocatoria {
  final String id;
  final String deadline;
  final String title;

  Convocatoria({this.id, this.deadline, this.title});
  
  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      id: json['Id'],
      deadline: json['Deadline'],
      title: json['title'],
    );
  }
}*/