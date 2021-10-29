// To parse this JSON data, do
//
//     final moneyOrderDetails = moneyOrderDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MoneyOrderDetails {
  MoneyOrderDetails({
    required this.err,
    required this.moneyOrder,
    required this.msg,
  });

  int err;
  List<MoneyOrder> moneyOrder;
  String msg;

  factory MoneyOrderDetails.fromRawJson(String str) =>
      MoneyOrderDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoneyOrderDetails.fromJson(Map<String, dynamic> json) =>
      MoneyOrderDetails(
        err: json["err"],
        moneyOrder: List<MoneyOrder>.from(
            json["moneyOrder"].map((x) => MoneyOrder.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "moneyOrder": List<dynamic>.from(moneyOrder.map((x) => x.toJson())),
        "msg": msg,
      };
}

class MoneyOrder {
  MoneyOrder({
    required this.moneyOrderId,
    required this.specialCode,
    required this.amount,
    required this.sourceBranchId,
    required this.receivingBranchId,
    required this.senderId,
    required this.receiverId,
    required this.isDelivered,
    required this.isCancelled,
  });

  String moneyOrderId;
  String specialCode;
  String amount;
  String sourceBranchId;
  String receivingBranchId;
  String senderId;
  String receiverId;
  bool isDelivered;
  bool isCancelled;

  factory MoneyOrder.fromRawJson(String str) =>
      MoneyOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoneyOrder.fromJson(Map<String, dynamic> json) => MoneyOrder(
        moneyOrderId: json["moneyOrderID"],
        specialCode: json["specialCode"],
        amount: json["amount"],
        sourceBranchId: json["sourceBranchID"],
        receivingBranchId: json["receivingBranchID"],
        senderId: json["senderID"],
        receiverId: json["receiverID"],
        isDelivered: json["isDelivered"],
        isCancelled: json["isCancelled"],
      );

  Map<String, dynamic> toJson() => {
        "moneyOrderID": moneyOrderId,
        "specialCode": specialCode,
        "amount": amount,
        "sourceBranchID": sourceBranchId,
        "receivingBranchID": receivingBranchId,
        "senderID": senderId,
        "receiverID": receiverId,
        "isDelivered": isDelivered,
        "isCancelled": isCancelled,
      };
}
