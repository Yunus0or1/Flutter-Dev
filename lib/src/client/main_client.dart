import 'dart:convert';
import 'dart:io';

import 'package:axiluniv/src/configs/server_config.dart';
import 'package:axiluniv/src/dummy_reponses/dummy_response.dart';
import 'package:axiluniv/src/models/auth_credential.dart';
import 'package:axiluniv/src/models/feed_info.dart';
import 'package:axiluniv/src/models/feed_request.dart';
import 'package:axiluniv/src/models/feed_response.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:http/http.dart' as http;

class MainClient {
  MainClient() {
    print("MainClient Initialized");
  }

  Future<bool> signIn(String email, String password) async {
    // This is Dummy offline Response

    bool matched = userCheck(email,
        password); // This part is actually to be coded in Server Side to read and check database

    if (matched) {
      // This is actually to show how Json is parsed for User and Auth Credential
      DummyResponse.signIn();
      return true;
    }
    // If not exist
    return false;

    // This would be real response between application and Server
    final http.Response response = await http.post(
      ServerConfig.SERVER_HOST + ServerConfig.SERVER_PORT.toString() + '/login',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final jsonReposne = json.decode(response.body);
      final user = User.fromJson(jsonReposne['user']);
      final authCredential =
          AuthCredential.fromJson(jsonReposne['authCredential']);

      Store.instance.updateUser(user, authCredential);
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<FeedResponse> getMainFeed(FeedRequest feedRequest) async {
    // This is Dummy offline Response
    return DummyResponse.getMainFeed();

    // This would be real response between application and Server with JWT Token
    final http.Response response = await http.post(
      ServerConfig.SERVER_HOST +
          ServerConfig.SERVER_PORT.toString() +
          '/mainfeed',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            Store.instance.appState.authCredential.jwtToken
      },
      body: jsonEncode(<String, dynamic>{
        'feedInfo': feedRequest.feedInfo.toJsonMap(),
        'nextFromId': feedRequest.nextFromId,
        "session": feedRequest.session,
        "userId": feedRequest.userId,
        "feedSize": feedRequest.feedSize
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return FeedResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<bool> changePassword(String email, String password) async {
    // This is Dummy offline Response

    try {
      Store.instance.appState.userList
          .firstWhere((user) => user.email == email)
          .password = new DBCrypt().hashpw(password, new DBCrypt().gensalt());
      Store.instance.putAppData();

      return true;
    } catch (err) {
      return false;
    }

    // I have not included the real Server call here cause the methods that are declared above
    // show how it should be done.
  }

  Future<bool> updateUser(User user) async {
    Store.instance.appState.userList.firstWhere((user) => user.id == user.id)
      ..firstName = user.firstName
      ..lastName = user.lastName
      ..phoneNumber = user.phoneNumber
      ..userImageUrl = user.userImageUrl;

    Store.instance.putAppData();
    return true;

    // I have not included the real Server call here cause the methods that are declared above
    // show how it should be done.
  }

  // This is actually Server Side code to verify an Existing User.
  static bool userCheck(String email, String password) {
    final userList = Store.instance.appState.userList;

    bool emailMatched = false;
    int index = 0;
    for (int i = 0; i < userList.length; i++) {
      if (userList[i].email == email) {
        index = i;
        emailMatched = true;
        break;
      }
    }

    if (emailMatched) {
      bool passwordMatched =
          new DBCrypt().checkpw(password, userList[index].password);

      if (passwordMatched) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static MainClient _instance;
  static MainClient get instance => _instance ??= MainClient();
}
