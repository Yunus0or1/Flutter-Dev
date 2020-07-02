import 'package:axiluniv/src/client/main_client.dart';
import 'package:axiluniv/src/component/general/loading_widget.dart';
import 'package:axiluniv/src/store/store.dart';
import 'package:axiluniv/src/util/util.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:tuple/tuple.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailController =
      new TextEditingController();
  final passwordController = new TextEditingController();
  bool isVerificationOngoing = false;
  bool _obscureText = true;
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
          SizedBox(height: 10.0),
          buildEmailInput(),
          SizedBox(height: 20.0),
          buildPasswordInput(),
          SizedBox(height: 10.0),
          buildForgetPassword(),
          SizedBox(height: 15.0),
          buildLoginButton(),
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

  Widget buildPasswordInput() {
    return TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _obscureText,
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

  Widget buildForgetPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/forget_password');
      },
      child: Container(
        padding: EdgeInsets.only(left: 0),
        alignment: Alignment.topLeft,
        child: Text(
          "Forget Password?",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
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
              'Log In    ',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Icon(Icons.chevron_right, size: 28.0, color: Colors.white,),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterButton() {
    return SizedBox(
      width: 220,
      height: 35,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        onPressed: () {},
        color: Colors.green[500],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Icon(Icons.chevron_right, size: 28.0),
          ],
        ),
      ),
    );
  }

  void makeLogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Please fill all the data properly');

      return;
    }

    if (!email.contains('@axiluniv')) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Please provide valid axiluniv email address');
      return;
    }

    final bool loginSuccessfull =
        await MainClient.instance.signIn(email, password);

    if (loginSuccessfull) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
      return;
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Email/Password mismatch'),
      ));
      return;
    }
  }

  String getHintText() {
    return "student@axiluniv.com";
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
