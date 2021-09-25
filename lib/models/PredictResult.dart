class PredictResult {
  int? studentId;
  int? teachStudentId;
  List<dynamic> scores;
  final String message;

  PredictResult({
    this.studentId,
    this.teachStudentId,
    required this.scores,
    required this.message
  });

  factory PredictResult.fromJson(Map<String, dynamic> json){
    return PredictResult(
        studentId: json["StudentId"],
        teachStudentId: json["TeachStudentId"],
        scores: json["Scores"],
        message: json["Message"]
    );
  }
}