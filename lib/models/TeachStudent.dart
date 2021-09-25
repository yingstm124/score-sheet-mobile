class TeachStudent {
  final String firstName;
  final String lastName;
  final String nickName;
  final int secNo;
  final int studentId;
  final int teachStudentId;
  final bool? isRegister;

  TeachStudent(
      {required this.firstName,
        required this.lastName,
        required this.nickName,
        required this.secNo,
        required this.studentId,
        required this.teachStudentId,
        this.isRegister
      });

  factory TeachStudent.fromJson(Map<String, dynamic> json) {
    return TeachStudent(
        firstName: json["FirstName"],
        lastName: json["LastName"],
        nickName: json["NickName"],
        secNo: json["SecNo"],
        studentId: json["StudentId"],
        teachStudentId: json["TeachStudentId"],
        isRegister: json["IsRegister"]
    );
  }
}