import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Util {
  static String getCoverPhotoUrl(List<String> urls) {
    if (urls.length == 0) return 'http://dummyUrl.com/test.jpg';
    return urls.elementAt(0);
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static showSnackBar({GlobalKey<ScaffoldState> scaffoldKey, String message}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    ));
  }

  static Future<void> getPermissions() async {
    if (Platform.isAndroid) {
      await Permission.camera.request();
      await Permission.storage.request();
    }
  }
}
