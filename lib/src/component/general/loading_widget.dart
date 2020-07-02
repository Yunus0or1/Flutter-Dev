import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String status;
  final bool displayHome;
  final bool displayRetry;
  final Function(BuildContext) retryAction;
  final Function(BuildContext) homeAction;

  LoadingWidget({
    this.status,
    this.displayHome = false,
    this.displayRetry = false,
    this.retryAction,
    this.homeAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buildChildren(context),
        ),
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context) {
    // Build children list
    final children = <Widget>[];
    // add retry or progressbar
    if (displayRetry) {
      children.add(buildRetryButton(context));
    } else {
      children.add(CircularProgressIndicator(
        backgroundColor: Colors.black,
      ));
    }
    // add status
    children.add(
      Text(
        status,
        style: TextStyle(color: Colors.grey),
      ),
    );
    // add home button
    if (displayHome) {
      children.add(buildHomeButton(context));
    }
    // Add padding to all children
    return children.map((child) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: child,
      );
    }).toList();
  }

  Widget buildRetryButton(BuildContext context) {

    return OutlineButton(
      child: Text('Retry'),
      onPressed: () => onRetryButtonPress(context),
      color: Colors.red,
      textColor: Colors.red,
      highlightColor: Colors.red,
      borderSide:
      BorderSide(color: Colors.red, style: BorderStyle.solid, width: 2.0),
    );
  }

  Widget buildHomeButton(BuildContext context) {
    return OutlineButton(
      child: Text('Home'),
      onPressed: () => onHomeButtonPress(context),
      color: Colors.red,
      textColor: Colors.red,
      highlightColor: Colors.red,
      borderSide:
      BorderSide(color: Colors.red, style: BorderStyle.solid, width: 2.0),
    );
  }

  void onRetryButtonPress(BuildContext context) {
    if (retryAction != null) {
      retryAction(context);
    }
  }

  void onHomeButtonPress(BuildContext context) {
    if (homeAction != null) {
      return retryAction(context);
    }
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
