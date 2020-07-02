import 'dart:convert';

import 'package:axiluniv/src/models/app_state.dart';
import 'package:axiluniv/src/models/auth_credential.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Store {
  AppState _appState;
  BuildContext _context;

  final String _APP_DATA_KEY = 'APP_DATA_KEY';

  Store(BuildContext context) {
    _context = context;
  }

  Future _initAppDataFromDB() async {
    final prefs = await SharedPreferences.getInstance();
//
//    prefs.remove(_APP_DATA_KEY);
//    return;
    if (prefs.containsKey(_APP_DATA_KEY)) {
      print("SharedPreference Key found");
      try {
        Map<String, dynamic> jsonMap =
            json.decode(prefs.getString(_APP_DATA_KEY));
        _appState = AppState.fromJsonMap(jsonMap);
      } catch (err) {
        print("SharedPreference Parse error");
        print(err);
        prefs.remove(_APP_DATA_KEY);
        _appState = new AppState();
      }
    } else {
      print("SharedPreference Key not found");
      _appState = new AppState();
      // Initializing every model, so these act as Database system
      Store.instance.appState.currentUser = User.blank();
      Store.instance.appState.authCredential = AuthCredential.blank();
      Store.instance.appState.userList.add(User.defaultUser());
      putAppData();
    }
  }

  Future putAppData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonMap = _appState.toJsonMap();
    prefs.setString(_APP_DATA_KEY, json.encode(jsonMap));
    print("Write sharedPreference");
  }

  Future deleteAppData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_APP_DATA_KEY);
    _appState = new AppState();
  }

  // ----------------------------------------------------------------------- //
  // This is called before getting instance.

  static Future initStore(BuildContext context) async {
    _instance = Store(context);
    await _instance._initAppDataFromDB();
  }

  static Store _instance;

  static Store get instance => _instance;

  // ------------------------------------------------------------------------------ //


  Future updateUser(User user, AuthCredential authCredential) async {
    _appState.currentUser = user;
    _appState.authCredential = authCredential;
    putAppData();
  }

  AppState get appState => _appState;
}
