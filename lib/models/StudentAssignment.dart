class StudentAssignment {
  final int studentAssignmentId;
  final int teachStudentId;
  final int studentId;
  final String firstName;
  final String lastName;
  final String? img;
  final int? score;
  final int secNo;

  StudentAssignment({
    required this.studentAssignmentId,
    required this.teachStudentId,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    this.img,
    this.score,
    required this.secNo
  });

  factory StudentAssignment.fromJson(Map<String, dynamic> json){
    return StudentAssignment(
        studentAssignmentId: json["StudentAssignmentId"],
        teachStudentId: json["TeachStudentId"],
        studentId: json["StudentId"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        img: json["Img"] ,
        score: json["Score"],
        secNo: json["SecNo"]);
  }
}