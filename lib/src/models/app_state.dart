import 'dart:convert';
import 'package:axiluniv/src/models/auth_credential.dart';
import 'package:axiluniv/src/models/course.dart';
import 'package:axiluniv/src/models/user.dart';


class AppState {
  List<User> userList = new List();
  User currentUser = new User();
  AuthCredential authCredential = new AuthCredential();
  List<Course> courseList = new List();

  AppState() {}


  AppState.fromJsonMap(Map<String, dynamic> data) {
    userList = getUserList(data['userList']);
    currentUser = User.fromJson(data['currentUser']);
    authCredential = AuthCredential.fromJson(data['authCredential']);
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['userList'] = getUserJsonList(userList);
    data['currentUser'] = currentUser.toJsonMap();
    data['authCredential'] = authCredential.toJsonMap();
    return data;
  }

  static List<String> getUserJsonList(List<User> users) {
    List<String> jsonList = new List();
    for (int i = 0; i < users.length; i++) {
      jsonList.add(jsonEncode(users[i].toJsonMap()));
    }
    return jsonList;
  }

  static List<User> getUserList(List<dynamic> jsonUserList) {


    if (jsonUserList == null) return List();
    List<User> users = new List();
    for (int i = 0; i < jsonUserList.length; i++) {
      users.add(User.fromJson(json.decode(jsonUserList[i])));
    }
    return users;
  }
}
