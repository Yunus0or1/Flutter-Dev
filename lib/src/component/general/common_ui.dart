import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


import 'app_bar_back_button.dart';
import 'loading_widget.dart';

Widget commonDivider() {
  return Divider(
    color: Colors.grey[400],
    height: 8.0,
  );
}

Widget showLoading(data, {String message}) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.white ,
      leading:   AppBarBackButton(),
    ),
    body: LoadingWidget(
      status: message,
    ),
  );
}


Widget noItemView(dynamic refreshCallback) {
  return RefreshIndicator(
    backgroundColor: Colors.black,
    onRefresh: refreshCallback,
    child: ListView.builder(
      padding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
      itemCount: 1,
      itemBuilder: (context, int index) {
        return index >= 1
            ? Container()
            : Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.symmetric(vertical: 100.0)),
              Text("Empty List",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    ),
  );
}

Widget noInternetView(dynamic refreshCallback) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/happy_internet.png',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          // width: 128.0,
          height: 100.0,
        ),
        SizedBox(height: 10),
        Text("No active internet connection"),
        SizedBox(height: 10),
        MaterialButton(
          child: new Text('Retry',
              style: new TextStyle(fontSize: 16.0, color: Colors.blue)),
          onPressed: refreshCallback,
        ),
      ],
    ),
  );
}

Widget noServerView(dynamic refreshCallback) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/happy_internet.png',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          // width: 128.0,
          height: 100.0,
        ),
        SizedBox(height: 10),
        Text("Something went wrong. Please try again."),
        SizedBox(height: 10),
        MaterialButton(
          child: new Text('Retry',
              style: new TextStyle(fontSize: 16.0, color: Colors.blue)),
          onPressed: refreshCallback,
        ),
      ],
    ),
  );



}
