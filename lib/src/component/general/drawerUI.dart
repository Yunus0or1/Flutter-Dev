import 'package:axiluniv/src/models/auth_credential.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  static final MainDrawer _drawer = new MainDrawer._internal();

  factory MainDrawer() {
    return _drawer;
  }

  MainDrawer._internal();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: buildDrawer(context),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return ListView(
      children: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          width: double.infinity,
          height: 150,
        ),
        Divider(
          color: Colors.black,
          thickness: 0.5,
        ),
        ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.all_out,
              color: Colors.black,
            ),
            onTap: () {
              Store.instance.updateUser(User.blank(), AuthCredential.blank());
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }),
      ],
    );
  }
}
