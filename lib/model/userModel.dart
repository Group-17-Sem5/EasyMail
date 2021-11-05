// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserDetails {
  UserDetails({
    required this.err,
    required this.user,
    required this.msg,
  });

  int err;
  List<User> user;
  String msg;

  factory UserDetails.fromRawJson(String str) =>
      UserDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        err: json["err"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "msg": msg,
      };
}

class User {
  User(
      {required this.username,
      required this.password,
      required this.addressId,
      required this.phoneNumber,
      required this.branchId,
      required this.status,
      required this.email});

  String username;
  String password;
  String addressId;

  String phoneNumber;
  String branchId;
  bool status;
  String email;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        addressId: json["addressId"],
        phoneNumber: json["phoneNumber"],
        branchId: json["branchId"],
        status: json['status'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "addressId": addressId,
        "phoneNumber": phoneNumber,
        "branchId": branchId,
        "status": status,
        "email": email,
      };
}
