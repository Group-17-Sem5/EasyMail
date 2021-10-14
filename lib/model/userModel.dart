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
  User({
    required this.username,
    required this.password,
    required this.addressId,
    // required this.addressDescription,
    required this.phoneNumber,
    required this.branchId,
    required this.sentPostIdList,
    required this.receivedPostIdList,
    required this.sentMoneyOrdersList,
    required this.receivedMoneyOrdersList,
  });

  String username;
  String password;
  String addressId;
  // String addressDescription;
  String phoneNumber;
  String branchId;
  List<dynamic> sentPostIdList;
  List<dynamic> receivedPostIdList;
  List<dynamic> sentMoneyOrdersList;
  List<dynamic> receivedMoneyOrdersList;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        addressId: json["addressID"],
        // addressDescription: json["addressDescription"],
        phoneNumber: json["phoneNumber"],
        branchId: json["branchID"],
        sentPostIdList:
            List<dynamic>.from(json["sentPostIDList"].map((x) => x)),
        receivedPostIdList:
            List<dynamic>.from(json["receivedPostIDList"].map((x) => x)),
        sentMoneyOrdersList:
            List<dynamic>.from(json["sentMoneyOrdersList"].map((x) => x)),
        receivedMoneyOrdersList:
            List<dynamic>.from(json["receivedMoneyOrdersList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "addressID": addressId,
        // "addressDescription": addressDescription,
        "phoneNumber": phoneNumber,
        "branchID": branchId,
        "sentPostIDList": List<dynamic>.from(sentPostIdList.map((x) => x)),
        "receivedPostIDList":
            List<dynamic>.from(receivedPostIdList.map((x) => x)),
        "sentMoneyOrdersList":
            List<dynamic>.from(sentMoneyOrdersList.map((x) => x)),
        "receivedMoneyOrdersList":
            List<dynamic>.from(receivedMoneyOrdersList.map((x) => x)),
      };
}
