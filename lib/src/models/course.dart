class Course {
  final int id;
  final String courseName;
  final String imageUrl;
  final String courseTeacherName;
  final String courseDetails;

  Course(
      {this.id,
      this.courseName,
      this.imageUrl,
      this.courseTeacherName,
      this.courseDetails});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      courseName: json['courseName'],
      imageUrl: json['imageUrl'],
      courseTeacherName: json['courseTeacherName'],
      courseDetails: json['courseDetails'],
    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['courseName'] = courseName;
    data['imageUrl'] = imageUrl;
    data['courseTeacherName'] = courseTeacherName;
    data['courseDetails'] = courseDetails;
    return data;
  }
}
