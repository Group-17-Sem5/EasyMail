// To parse this JSON data, do
//
//     final tokenRes = tokenResFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TokenRes {
  TokenRes({
    required this.err,
    required this.token,
    required this.msg,
  });

  int err;
  String token;
  String msg;

  factory TokenRes.fromRawJson(String str) =>
      TokenRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenRes.fromJson(Map<String, dynamic> json) => TokenRes(
        err: json["err"],
        token: json["token"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "token": token,
        "msg": msg,
      };
}
