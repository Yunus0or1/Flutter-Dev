import 'package:dbcrypt/dbcrypt.dart';
import 'package:password/password.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  String phoneNumber;
  UserRole userRole;
  String userImageUrl;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.userRole,
      this.userImageUrl});

  // When App loads for the first time, this is the data that can be used to Login first
  User.defaultUser()
      : id = 10000,
        firstName = "student",
        lastName = "_one",
        email = "student_one@axiluniv.com",
        password = new DBCrypt().hashpw('password', new DBCrypt().gensalt()),
        phoneNumber = "+880141100110",
        userRole = UserRole.STUDENT,
        userImageUrl = "assets/images/avatar.png";

  User.blank()
      : id = 0,
        firstName = "",
        lastName = "",
        email = "",
        password = "",
        phoneNumber = "",
        userRole = UserRole.GUEST,
        userImageUrl = "";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      userRole: getUserRole(json['userRole']),
      userImageUrl: json['userImageUrl'],
    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['userRole'] = userRole.toString();
    data['userImageUrl'] = userImageUrl;
    return data;
  }

  static UserRole getUserRole(String userRole) {
    if (userRole == UserRole.SUPER_ADMIN.toString())
      return UserRole.SUPER_ADMIN;
    if (userRole == UserRole.ADMIN.toString()) return UserRole.ADMIN;
    if (userRole == UserRole.TEACHER.toString()) return UserRole.TEACHER;
    if (userRole == UserRole.STUDENT.toString()) return UserRole.STUDENT;
    if (userRole == UserRole.GUEST.toString()) return UserRole.GUEST;
  }
}

enum UserRole { SUPER_ADMIN, ADMIN, TEACHER, STUDENT, GUEST }
