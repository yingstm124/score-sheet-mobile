class AddStudent {
  final String studentId;
  final bool isRegister;
  final int secNo;
  AddStudent(
      {
        required this.studentId,
        required this.isRegister,
        required this.secNo
      });
  factory AddStudent.fromJson(Map<String, dynamic> json) {
    return AddStudent(
        studentId: json["StudentId"],
        isRegister: json["IsRegister"],
        secNo: json["SecNo"]
    );
  }
}