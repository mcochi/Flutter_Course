


class Convocatoria {
  final String identifier;
  final List<dynamic> deadline;
  final String title;
  final int type;
  final int cftId;
  final String status;
  final String description;

  Convocatoria({this.identifier, this.deadline, this.title, this.type, this.cftId, this.status, this.description});
  
  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      identifier: json['identifier'],
      deadline: json['deadlineDatesLong'],
      title: json['title'],
      type: json['type'],
      cftId: json['cftId'],
      status: json['status']['abbreviation'],
      description: json['type'].toString().contains('0') ? json['descriptionTender'] : '',
    );
  }
}


