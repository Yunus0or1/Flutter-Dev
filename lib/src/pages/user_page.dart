import 'package:axiluniv/src/component/constants/colors.dart';
import 'package:axiluniv/src/component/general/app_bar_back_button.dart';
import 'package:axiluniv/src/component/general/loading_widget.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/pages/user_details_page.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadUser(),
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return showLoading(snapshot);
        } else if (snapshot.data != null) {
          Key key = UniqueKey();
          return UserDetailsPage(
            snapshot.data,
            key: key,
          );
        }
        return showLoading(snapshot);
      },
    );
  }

  Future<User> loadUser() async {
    final user = Store.instance.appState.currentUser;
    return user;
  }

  Widget showLoading(snapshot) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Details', style: TextStyle(color: Colors.white)),
      ),
      body: LoadingWidget(
        status: 'Getting data',
      ),
    );
  }
}
