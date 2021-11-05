// To parse this JSON data, do
//
//     final courierDetails = courierDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CourierDetails {
  CourierDetails({
    required this.err,
    required this.couriers,
    required this.msg,
  });

  int err;
  List<Courier> couriers;
  String msg;

  factory CourierDetails.fromRawJson(String str) =>
      CourierDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourierDetails.fromJson(Map<String, dynamic> json) => CourierDetails(
        err: json["err"],
        couriers: List<Courier>.from(
            json["couriers"].map((x) => Courier.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "couriers": List<dynamic>.from(couriers.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Courier {
  Courier({
    required this.id,
    required this.sourceBranchId,
    required this.lastAppearedBranchId,
    required this.receivingBranchId,
    required this.senderId,
    required this.receiverId,
    required this.postManId,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.addressId,
    required this.isAssigned,
    required this.isCancelled,
    required this.isDelivered,
  });

  String id;
  String sourceBranchId;
  String lastAppearedBranchId;
  String receivingBranchId;
  String senderId;
  String receiverId;
  dynamic postManId;
  int weight;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String addressId;
  bool isAssigned;
  bool isCancelled;
  bool isDelivered;

  factory Courier.fromRawJson(String str) => Courier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
        id: json["_id"],
        sourceBranchId: json["sourceBranchID"],
        lastAppearedBranchId: json["lastAppearedBranchID"],
        receivingBranchId: json["receivingBranchID"],
        senderId: json["senderID"],
        receiverId: json["receiverID"],
        postManId: json["postManID"],
        weight: json["weight"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        addressId: json["addressID"],
        isAssigned: json["isAssigned"],
        isCancelled: json["isCancelled"],
        isDelivered: json["isDelivered"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sourceBranchID": sourceBranchId,
        "lastAppearedBranchID": lastAppearedBranchId,
        "receivingBranchID": receivingBranchId,
        "senderID": senderId,
        "receiverID": receiverId,
        "postManID": postManId,
        "weight": weight,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "addressID": addressId,
        "isAssigned": isAssigned,
        "isCancelled": isCancelled,
        "isDelivered": isDelivered,
      };
}
