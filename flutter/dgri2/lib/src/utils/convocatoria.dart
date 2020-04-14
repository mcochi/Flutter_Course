


class Convocatoria {
  final String identifier;
  final int deadline;
  final String title;
  final int type;
  final int cftId;
  final String status;
  final String description;
  final String programa;

  Convocatoria({this.identifier, this.deadline, this.title, this.type, this.cftId, this.status, this.description, this.programa});
  
  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      identifier: json['identifier'],
      deadline: json['deadlineDatesLong'].isEmpty ? 0 : json['deadlineDatesLong'].last, //Some tenders have empty deadline, this way, I put a ramdom
      title: json['title'],
      type: json['type'],
      cftId: json['cftId'],
      status: json['status']['abbreviation'],
      description: json['type'].toString().contains('0') ? json['descriptionTender'] : '',
      programa: json['type'].toString().contains('0') ? 'e-tendering' : json['frameworkProgramme']['abbreviation'],
    );
  }
}


