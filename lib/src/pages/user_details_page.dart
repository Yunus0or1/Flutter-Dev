import 'dart:io';
import 'package:axiluniv/src/client/main_client.dart';
import 'package:axiluniv/src/component/constants/colors.dart';
import 'package:axiluniv/src/models/user.dart';
import 'package:axiluniv/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserDetailsPage extends StatefulWidget {
  final User currentUser;
  UserDetailsPage(this.currentUser, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  User user;
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController phoneNumber;
  String imageUrl;
  final formKey = GlobalKey();
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    user = widget.currentUser;
    firstName = new TextEditingController(text: user.firstName);
    lastName = new TextEditingController(text: user.lastName);
    phoneNumber = new TextEditingController(text: user.phoneNumber);
    imageUrl = user.userImageUrl;
  }

  @override
  void dispose() {
    super.dispose();
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
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text('My Details', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            buildSaveAction(),
          ],
        ),
        body: SingleChildScrollView(child: buildBody(context)),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: buildFormBox(context),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }

  Widget buildFormBox(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildImage(context),
          SizedBox(height: 10),
          Divider(height: 3),
          SizedBox(height: 10),
          buildFirstName(),
          buildLastName(),
          buildEmail(),
          buildPhoneNumber(),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Container(
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: ClipOval(child: getImageWidget()),
                ),
                Positioned(
                  bottom: 2.0,
                  right: 0.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: ClipOval(
                      child: IconButton(
                        onPressed: () async {
                          var cameraStatus = await Permission.camera.status;
                          var storeageStatus = await Permission.storage.status;
                          if (cameraStatus ==
                                  PermissionStatus.permanentlyDenied ||
                              storeageStatus ==
                                  PermissionStatus.permanentlyDenied) {
                            Util.showSnackBar(
                                scaffoldKey: _scaffoldKey,
                                message:
                                    "Please provide Camera and Storage permissions from Settings");
                          } else {
                            showAlertDialog(context);
                          }
                        },
                        iconSize: 15,
                        icon: Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget buildFirstName() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: firstName,
              decoration: new InputDecoration(
                labelText: "First Name",
                hintText: 'Enter your first name',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  borderSide: new BorderSide(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLastName() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: lastName,
              decoration: new InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  borderSide: new BorderSide(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumber,
              decoration: new InputDecoration(
                labelText: 'Contact Number',
                hintText: 'Enter your contact number',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  borderSide: new BorderSide(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              enabled: false,
              initialValue: user.email,
              decoration: new InputDecoration(
                labelText: 'Email address',
                hintText: 'Enter your email address',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  borderSide: new BorderSide(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSaveAction() {
    if (user == null) {
      return Container();
    }
    return Builder(
      builder: (context) {
        return MaterialButton(
          child: Text('SAVE',style: TextStyle(color: Colors.white),),
          onPressed: () async {
            (formKey.currentState as FormState).save();

            if (firstName.text.isEmpty ||
                lastName.text.isEmpty ||
                phoneNumber.text.isEmpty) {
              Util.showSnackBar(
                  scaffoldKey: _scaffoldKey,
                  message: "Please fill all the data properly");
              return;
            }

            if (!phoneNumber.text.contains(new RegExp(r'[0-9]')) ||
                phoneNumber.text.contains(new RegExp(r'[a-z]')) ||
                phoneNumber.text.contains(new RegExp(r'[A-Z]'))) {
              Util.showSnackBar(
                  scaffoldKey: _scaffoldKey,
                  message: 'Enter a valid phone number');
              return;
            }

            user.firstName = firstName.text;
            user.lastName = lastName.text;
            user.phoneNumber = phoneNumber.text;
            user.userImageUrl = imageUrl;

            final response = await MainClient.instance.updateUser(user);

            if (response == true) {
              Util.showSnackBar(
                  scaffoldKey: _scaffoldKey,
                  message: 'Your details has been saved');
            } else {
              Util.showSnackBar(
                  scaffoldKey: _scaffoldKey, message: 'An error happened');
            }
          },
        );
      },
    );
  }

  void pickImage(String method) async {
    try {
      if (method == "camera") {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        imageUrl = pickedFile.path;
      } else if (method == "file") {
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        imageUrl = pickedFile.path;
      }
      if (mounted) setState(() {});
    } catch (err) {}
  }

  Widget getImageWidget() {
    try {
      if (imageUrl == "assets/images/avatar.png")
        return Image.asset(imageUrl, width: 110, height: 110);
      else
        return File(imageUrl).existsSync()
            ? Image.file(File(imageUrl), width: 110, height: 110)
            : Image.asset("assets/images/avatar.png", width: 110, height: 110);
    } catch (err) {
      return Image.asset("assets/images/avatar.png", width: 110, height: 110);
    }
  }

  void refresh() {
    setState(() {});
  }

  void showAlertDialog(BuildContext mainContext) {
    showDialog(
        context: mainContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
              height: 120,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("PICK IMAGE BY ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Divider(height: 1,color: Colors.grey[700]),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            pickImage("camera");
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.camera, color: Colors.black),
                              Text(
                                "Camera",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            pickImage("file");
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.insert_drive_file,
                                  color: Colors.black),
                              Text(
                                "File",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
