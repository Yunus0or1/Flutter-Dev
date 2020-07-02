import 'package:axiluniv/src/component/cards/course_slider_card.dart';
import 'package:axiluniv/src/models/feed_info.dart';
import 'package:axiluniv/src/models/feed_item.dart';
import 'package:flutter/material.dart';

class FeedCardHandler extends StatelessWidget {
  final FeedInfo feedInfo;
  final FeedItem item;

  const FeedCardHandler(this.feedInfo, this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (item.viewType) {
      case ViewCardType_Enum.GROUP_COURSE:
        {
          return CourseSliderCard(item.courses);
        }

      default:
        return Container();
    }
  }
}
