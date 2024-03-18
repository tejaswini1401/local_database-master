class Note{
  final String company;
  final String jobRole;
  final String jobId;
  final String jdis;
  final int? id;

  const Note(
    {
      this.id,
      required this.company, 
      required this.jobRole, 
      required this.jobId, 
      required this.jdis,
    }
  );

  factory Note.fromJson(Map<String,dynamic> json) => Note(
    id: json['id'],
    company: json['company'],
    jobRole: json['jobRole'],
    jobId : json['jobId'],
    jdis : json['jd'],
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'company': company,
    'jobRole': jobRole,
    'jobId':jobId,
    'jd':jdis
  };
}