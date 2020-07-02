import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  final bool drawCircle;

  AppBarBackButton({this.drawCircle});

  @override
  Widget build(BuildContext context) {
    return (drawCircle == true)
        ? IconButton(
      icon: Container(
        child: CircleAvatar(
          maxRadius: 16,
          child: Icon(Icons.arrow_back, color: Colors.white),
          backgroundColor: new Color.fromARGB(150, 50, 40, 99),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    )
        : IconButton(
      icon: Container(
        child: Icon(Icons.arrow_back, color: Colors.white, size: 25,),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class AppBarBackButtonIOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        child: Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
