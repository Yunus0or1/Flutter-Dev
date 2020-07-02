import 'package:axiluniv/src/store/store.dart';
import 'package:flutter/material.dart';

import 'router.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSate();
  }
}

class _AppSate extends State<App> {

  @override
  void initState() {
    super.initState();
    initProject();
  }

  void initProject() async {
    await Store.initStore(context);
  }

  @override
  Widget build(BuildContext context) {
    // start app
    return MaterialApp(
      title: 'AxiLUniv',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
      onGenerateRoute: buildRouter,
      debugShowCheckedModeBanner: false,

    );
  }
}


