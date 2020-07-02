import 'dart:async';
import 'package:axiluniv/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:axiluniv/src/store/store.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initAppAndNavigate();
  }

  Future initAppAndNavigate() async {
    final isInternet = await Util.checkInternet();
    if (isInternet) {
      var _duration = new Duration(seconds: 1);
      return new Timer(_duration, navigationPage);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/noInternet', (Route<dynamic> route) => false);
    }
  }

  void navigationPage() {
    if (Store.instance.appState.currentUser.id == 0) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
      }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildLogo(),
            SizedBox(height: 100.0),
            buildSpinner(),
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Container(
      height: 100,
      width: 180,
      child: Image.asset('assets/images/logo.png',
        alignment: Alignment.center,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget buildSpinner() {
    return SpinKitPulse(color: Colors.blue);
  }
}
