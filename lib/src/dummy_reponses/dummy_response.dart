import 'dart:convert';

import 'package:axiluniv/src/models/auth_credential.dart';
import 'package:axiluniv/src/models/feed_response.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:password/password.dart';
import 'package:flutter/services.dart' show rootBundle;

class DummyResponse {
  static getDefaultUser() {
    User defaultUser = new User(
        id: 10000,
        firstName: "Admin",
        lastName: "admin",
        email: "admin@axiluniv.com",
        password: Password.hash("password", new PBKDF2()),
        userRole: UserRole.ADMIN);

    return defaultUser;
  }

  static Future<bool> signIn() async {
    final String response = await rootBundle.loadString('assets/json/responseUserAuth.txt');
    final jsonResponse = json.decode(response);

    AuthCredential authCredential  = new AuthCredential.fromJson(jsonResponse['authCredential']);
    final userId = authCredential.userId;
    final user = Store.instance.appState.userList.firstWhere((user)=> user.id == userId);

    Store.instance.updateUser(user, authCredential);

    return true;

  }

  static Future<FeedResponse> getMainFeed() async {
    final String response = await rootBundle.loadString('assets/json/responseMainFeed.txt');
    final jsonResponse = json.decode(response);

    FeedResponse feedResponse  = new FeedResponse.fromJson(jsonResponse);
    return feedResponse;

  }
}
