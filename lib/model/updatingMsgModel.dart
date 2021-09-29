// To parse this JSON data, do
//
//     final msgRes = msgResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MsgRes {
  MsgRes({
    required this.err,
    required this.obj,
    required this.msg,
  });

  int err;
  Obj obj;
  String msg;

  factory MsgRes.fromRawJson(String str) => MsgRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MsgRes.fromJson(Map<String, dynamic> json) => MsgRes(
        err: json["err"],
        obj: Obj.fromJson(json["obj"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "obj": obj.toJson(),
        "msg": msg,
      };
}

class Obj {
  Obj();

  factory Obj.fromRawJson(String str) => Obj.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Obj.fromJson(Map<String, dynamic> json) => Obj();

  Map<String, dynamic> toJson() => {};
}
