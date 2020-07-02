import 'package:axiluniv/src/client/main_client.dart';
import 'package:axiluniv/src/component/general/loading_widget.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:axiluniv/src/util/util.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:tuple/tuple.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = new TextEditingController();
  final passwordController1 = new TextEditingController();
  final passwordController2 = new TextEditingController();
  bool isVerificationOngoing = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(15, 100, 15, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildLogo(),
                        SizedBox(height: 30.0),
                        buildBody(),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      'assets/images/logo.png',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      // width: 128.0,
      height: 56.0,
    );
  }

  Widget buildBody() {
    return isVerificationOngoing
        ? buildVerificationLoadingWidget()
        : buildLoginBox();
  }

  Widget buildVerificationLoadingWidget() {
    return LoadingWidget(
      status: 'Verify login...',
    );
  }

  Widget buildLoginBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text("Change Password"),
          SizedBox(height: 10.0),
          buildEmailInput(),
          SizedBox(height: 20.0),
          buildPasswordInput1(),
          SizedBox(height: 10.0),
          buildPasswordInput2(),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          buildSubmitButton(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget buildEmailInput() {
    return TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[800],
      ),
      decoration: InputDecoration(
        hintText: getHintText(),
        hintStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(
          Icons.email,
          size: 20,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }

  Widget buildPasswordInput1() {
    return TextFormField(
      autofocus: false,
      controller: passwordController1,
      obscureText: _obscureText1,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[800],
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: _toggle,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }

  Widget buildPasswordInput2() {
    return TextFormField(
      autofocus: false,
      controller: passwordController2,
      obscureText: _obscureText2,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[800],
      ),
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        hintStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: _toggle2,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return SizedBox(
      width: 220,
      height: 35,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onPressed: () => makeLogin(),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Submit',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Icon(Icons.chevron_right, size: 28.0,color: Colors.white,),
          ],
        ),
      ),
    );
  }

  void makeLogin() async {
    final email = emailController.text;
    final password1 = passwordController1.text;
    final password2 = passwordController2.text;

    if (email.isEmpty || password1.isEmpty || password2.isEmpty) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Please fill all the data properly');

      return;
    }

    if (password1 != password2) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey, message: 'Two passwords did not match');

      return;
    }

    if (!email.contains('@axiluniv')) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Please provide valid axiluniv email address');
      return;
    }

    if (password1.length < 7) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Password must be at least 7 characters');

      return;
    }

    if (!password1.contains(new RegExp(r'[A-Z]')) ||
        !password1.contains(new RegExp(r'[0-9]')) ||
        !password1.contains(new RegExp(r'[a-z]')) ||
        !password1.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message:
          'Password must contain at least one uppecase letter, one lowercase letter,'
              ' a number and a special character');
      return;
    }

    final bool changePassworSuccessfull =
    await MainClient.instance.changePassword(email, password1);

    if (changePassworSuccessfull) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey, message: 'Password changed successfully');
      await Future.delayed(const Duration(seconds: 1), () {});
      Navigator.of(context).pop();
      return;
    } else {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey, message: "Email does not exist");
      return;
    }
  }

  String getHintText() {
    return "student@axiluniv.com";
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
}