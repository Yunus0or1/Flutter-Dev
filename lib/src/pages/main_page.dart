import 'package:axiluniv/src/client/main_client.dart';
import 'package:axiluniv/src/dummy_reponses/dummy_response.dart';
import 'package:axiluniv/src/models/auth_credential.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/pages/user_page.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:axiluniv/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  final String title;

  MainPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTabIndex;

  @override
  void initState() {
    super.initState();
    currentTabIndex = 0;
    Util.getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final pages = getBottomNavPages();

    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        index: currentTabIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTabIndex,
        items: buildBottomBarItems(),
        elevation: 0,
        onTap: selectTab,
      ),
    );
  }

  void selectTab(int tabIndex) {
    setState(() {
      currentTabIndex = tabIndex;
    });
  }

  List<Widget> getBottomNavPages() {
    return [
      HomePage(),
      UserPage(),
    ];
  }

  List<BottomNavigationBarItem> buildBottomBarItems() {
    return [
      BottomNavigationBarItem(
        title: Text('Home', style: TextStyle(fontSize: 13)),
        icon: Icon(Icons.home, size: 24),
      ),
      BottomNavigationBarItem(
        title: Text('Account', style: TextStyle(fontSize: 13)),
        icon: Icon(Icons.account_circle, size: 24),
      ),
    ];
  }
}
