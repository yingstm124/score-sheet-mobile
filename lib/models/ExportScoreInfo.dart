class ExportScoreInfo {
  final String assignmentName;
  final String fullName;
  final int fullScore;
  final int? score;
  final int studentId;

  ExportScoreInfo({
    required this.studentId,
    required this.fullName,
    required this.assignmentName,
    required this.fullScore,
    this.score
  });

  factory ExportScoreInfo.fromJson(Map<String,dynamic> json) {
    return ExportScoreInfo(
        studentId: json["StudentId"],
        assignmentName: json["AssignmentName"],
        fullScore: json["FullScore"],
        score: json["Score"],
        fullName: json["FullName"]
    );
  }
}