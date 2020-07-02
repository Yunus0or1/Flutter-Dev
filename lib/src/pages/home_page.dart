import 'package:axiluniv/src/blocks/event_stream.dart';
import 'package:axiluniv/src/component/constants/colors.dart';
import 'package:axiluniv/src/component/general/drawerUI.dart';
import 'package:axiluniv/src/feed/feed_container.dart';
import 'package:axiluniv/src/models/event.dart';
import 'package:axiluniv/src/models/feed_info.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
    eventChecker();
  }

  void eventChecker() async {
    EventStream.getStream().listen((data) {
      if (data.eventType == EventType.PAGE_REFRESHED) refreshUI();
    });
  }

  void refreshUI() {
    if (mounted) {
      setState(() {
        key = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Home',style: TextStyle(color: Colors.white),),
      ),
      body: FeedContainer(
        FeedInfo(FeedType_Enum.MAIN_FEED),
        key: key,
      ),
    );
  }
}
