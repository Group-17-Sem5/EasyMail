// To parse this JSON data, do
//
//     final addressList = addressListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AddressList {
  AddressList({
    required this.err,
    required this.addresses,
    required this.msg,
  });

  int err;
  List<Address> addresses;
  String msg;

  factory AddressList.fromRawJson(String str) =>
      AddressList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        err: json["err"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Address {
  Address({
    required this.addressId,
    required this.description,
    required this.lat,
    required this.lng,
    required this.branchId,
    required this.userIdList,
  });

  String addressId;
  String description;
  String lat;
  String lng;
  String branchId;
  List<String> userIdList;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json["addressID"],
        description: json["description"],
        lat: json["lat"],
        lng: json["lng"],
        branchId: json["branchID"],
        userIdList: List<String>.from(json["userIDList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "addressID": addressId,
        "description": description,
        "lat": lat,
        "lng": lng,
        "branchID": branchId,
        "userIDList": List<dynamic>.from(userIdList.map((x) => x)),
      };
}
