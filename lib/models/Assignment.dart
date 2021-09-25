class Assignment {
  final int assignmentId;
  final String assignmentName;
  final int fullScore;
  final int? teachCourseId;
  Assignment(
      {required this.assignmentId,
        required this.assignmentName,
        required this.fullScore,
        this.teachCourseId});
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
        assignmentId: json["AssignmentId"],
        assignmentName: json["AssignmentName"],
        fullScore: json["FullScore"],
        teachCourseId: json["TeachCourseId"]);
  }
}
