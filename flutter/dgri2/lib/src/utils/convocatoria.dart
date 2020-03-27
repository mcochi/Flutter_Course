


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
}


