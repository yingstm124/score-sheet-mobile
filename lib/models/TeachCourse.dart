class TeachCourse {
  final int teachCourseId;
  final int courseId;
  final String courseName;
  final int term;
  final int year;

  TeachCourse({
    required this.teachCourseId,
    required this.courseId,
    required this.courseName,
    required this.term,
    required this.year
  });

  factory TeachCourse.fromJson(Map<String, dynamic> json) {
    return TeachCourse(
        teachCourseId: json["TeachCourseId"],
        courseId: json["CourseId"],
        courseName: json["CourseName"],
        term: json["Term"],
        year: json["Year"]);
  }
}