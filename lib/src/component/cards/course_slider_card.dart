import 'package:axiluniv/src/models/course.dart';
import 'package:flutter/material.dart';
import 'course_single_card.dart';

class CourseSliderCard extends StatelessWidget {
  final List<Course> courses;

  CourseSliderCard(this.courses);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:0,bottom: 0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0),
            buildTitle(),
            SizedBox(height: 5.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildMerchantList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5),
      child: Text(
        'All Courses',
      ),
    );
  }

  Widget buildMerchantList(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: courses.map((singleCourse) {
        return CourseSingleCard(
            course: singleCourse);
      }).toList(),
    );
  }
}
