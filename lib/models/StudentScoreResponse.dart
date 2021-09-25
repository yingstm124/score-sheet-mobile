class StudentScoreResponse {
  final String message;

  StudentScoreResponse({
    required this.message
  });

  factory StudentScoreResponse.fromJson(Map<String,dynamic> json){
    return StudentScoreResponse(
        message: json["Message"]
    );
  }
}