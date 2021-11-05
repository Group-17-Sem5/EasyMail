// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Result {
    Result({
        required this.err,
        required this.mailModel,
        required this.msg,
    });

    int err;
    List<MailModel> mailModel;
    String msg;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
        err: json["err"],
        mailModel: List<MailModel>.from(json["mailModel"].map((x) => MailModel.fromJson(x))),
        msg: json["msg"],
    );

    Map<dynamic, dynamic> toJson() => {
        "err": err,
        "mailModel": List<dynamic>.from(mailModel.map((x) => x.toJson())),
        "msg": msg,
    };
}

class MailModel {
    MailModel({
        required this.mailId,
        required this.addressId,
        required this.isAssigned,
        required this.isDelivered,
        required this.lastAppearedBranchId,
        required this.sourceBranchId,
        required this.receivingBranchId,
        required this.postManId,
        required this.senderId,
        required this.receiverId,
        required this.isCancelled,
    });

    String mailId;
    String addressId;
    bool isAssigned;
    bool isDelivered;
    String lastAppearedBranchId;
    String sourceBranchId;
    String receivingBranchId;
    String postManId;
    String senderId;
    String receiverId;
    bool isCancelled;

    factory MailModel.fromRawJson(String str) => MailModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MailModel.fromJson(Map<dynamic, dynamic> json) => MailModel(
        mailId: json["mailID"],
        addressId: json["addressID"],
        isAssigned: json["isAssigned"],
        isDelivered: json["isDelivered"],
        lastAppearedBranchId: json["lastAppearedBranchID"],
        sourceBranchId: json["sourceBranchID"],
        receivingBranchId: json["receivingBranchID"],
        postManId: json["postManID"],
        senderId: json["senderID"],
        receiverId: json["receiverID"],
        isCancelled: json["isCancelled"],
    );

    Map<dynamic, dynamic> toJson() => {
        "mailID": mailId,
        "addressID": addressId,
        "isAssigned": isAssigned,
        "isDelivered": isDelivered,
        "lastAppearedBranchID": lastAppearedBranchId,
        "sourceBranchID": sourceBranchId,
        "receivingBranchID": receivingBranchId,
        "postManID": postManId,
        "senderID": senderId,
        "receiverID": receiverId,
        "isCancelled":isCancelled,
    };
}









// class MailModel{
//   String mailID;
//   var addressID;
//   var lastAppearedBranch;
//   var postManID;
//   var sourceBranchID;
//   var receivingBranchID;
//   var senderID;
//   var receiverID;
//   var isAssigned;
//   var isDelivered;



//   MailModel({
//     required this.mailID,
//     this.addressID,
//     this.lastAppearedBranch,
//     this.postManID,
//     this.sourceBranchID,
//     this.receivingBranchID,
//     this.senderID,
//     this.receiverID,
//     this.isAssigned,
//     this.isDelivered
//     });

// }


