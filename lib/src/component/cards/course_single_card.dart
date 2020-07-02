import 'package:axiluniv/src/models/course.dart';
import 'package:axiluniv/src/util/image_util.dart';
import 'package:flutter/material.dart';

class CourseSingleCard extends StatelessWidget {
  final Course course;

  CourseSingleCard(
      {this.course});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width * .85;
    double height = 300;
    double left = 5;
    double right = 5;


    return GestureDetector(
      onTap: () async {
        showAlertDialog(context,course);
      },
      child: Center(
        child: Container(
          padding:
              EdgeInsets.only(left: left, top: 10, bottom: 10, right: right),
          width: width,
          height: height,
          child: Material(
            shadowColor: Colors.grey[100].withOpacity(0.4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            elevation: 3,
            clipBehavior: Clip.antiAlias, // Add This
            child: buildStack(course),
          ),
        ),
      ),
    );
  }

  Widget buildStack(Course course) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 75.0),
          child: Image.asset(course.imageUrl,height: 250,width: double.infinity,),
        ),
        Positioned(
          bottom: 8.0,
          left: 12.0,
          right: 12.0,
          child: courseTitle(course),
        ),
      ],
    );
  }


  Widget courseTitle(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          course.courseName,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          "by " + course.courseTeacherName,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 13.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void showAlertDialog(
      BuildContext mainContext, Course course) {
    showDialog(
        context: mainContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
              height: 170,
              width: 70,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      course.courseName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      course.courseDetails,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
