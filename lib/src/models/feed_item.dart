import 'package:axiluniv/src/models/course.dart';

class FeedItem {
  int id;
  ViewCardType_Enum viewType;
  List<Course> courses;

  FeedItem({this.id,this.viewType,this.courses});

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'],
      viewType: getViewType(json['viewType']),
      courses: (json['courses'] as List).map((item) => Course.fromJson(item)).toList(),
    );
  }



  static ViewCardType_Enum getViewType(String viewType) {
    if(viewType == "GROUP_COURSE")
      return ViewCardType_Enum.GROUP_COURSE;
  }
}

enum ViewCardType_Enum { GROUP_COURSE }
