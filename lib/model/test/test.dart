// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.err,
    required this.obj,
    required this.msg,
  });

  int err;
  List<Obj> obj;
  String msg;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        err: json["err"],
        obj: List<Obj>.from(json["obj"].map((x) => Obj.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "obj": List<dynamic>.from(obj.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Obj {
  Obj({
    required this.mailId,
    required this.addressId,
    required this.isAssigned,
    required this.isDelivered,
    required this.lastAppearedBranch,
    required this.sourceBranchId,
    required this.receivingBranchId,
    required this.postManId,
    required this.senderId,
    required this.receiverId,
  });

  String mailId;
  String addressId;
  bool isAssigned;
  bool isDelivered;
  String lastAppearedBranch;
  String sourceBranchId;
  String receivingBranchId;
  String postManId;
  String senderId;
  String receiverId;

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
        mailId: json["mailID"],
        addressId: json["addressID"],
        isAssigned: json["isAssigned"],
        isDelivered: json["isDelivered"],
        lastAppearedBranch: json["lastAppearedBranch"],
        sourceBranchId: json["sourceBranchID"],
        receivingBranchId: json["receivingBranchID"],
        postManId: json["postManID"],
        senderId: json["senderID"],
        receiverId: json["receiverID"],
      );

  Map<String, dynamic> toJson() => {
        "mailID": mailId,
        "addressID": addressId,
        "isAssigned": isAssigned,
        "isDelivered": isDelivered,
        "lastAppearedBranch": lastAppearedBranch,
        "sourceBranchID": sourceBranchId,
        "receivingBranchID": receivingBranchId,
        "postManID": postManId,
        "senderID": senderId,
        "receiverID": receiverId,
      };
}
