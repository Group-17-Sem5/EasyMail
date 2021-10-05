import 'package:easy_mail_app_frontend/model/addressesModel.dart';
import 'package:easy_mail_app_frontend/model/postManModel.dart';
import 'package:easy_mail_app_frontend/model/tokenModel.dart';
import 'package:easy_mail_app_frontend/model/updatingMsgModel.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/mailModel.Dart';
import '../model/addressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostManController extends GetxController {
  var mails = <MailModel>[].obs;
  var addresses = <Address>[].obs;
  var selectedAddress = <Address>[].obs;
  static PostManModel postMan = new PostManModel();
  static String? token;
  static String? userName;

  Future login(String username, String password) async {
    print(username);
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/postman/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
            <String, String>{'username': "$username", "password": "$password"}),
      );

      var result = TokenRes.fromRawJson(response.body);
      token = result.token;
      userName = username;
      print(token);
      return result.err;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future getLocations() async {
    print("getting all locations");
    try {
      var response = await http.get(
          Uri.parse("http://10.0.2.2:5000/api/postman/address/"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });

      var result = AddressList.fromRawJson(response.body);
      print(result.addresses);
      addresses.clear();
      addresses.addAll(result.addresses);
      print(addresses.length.toString() + "results found");
      return (result);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future confirmDelivery(String mailID) async {
    try {
      var response = await http.put(
          Uri.parse("http://10.0.2.2:5000/api/postman/posts/confirm/$mailID"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });

      var result = MsgRes.fromRawJson(response.body);

      return (result);
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future cancelDelivery(String mailID) async {
    try {
      var response = await http.put(
          Uri.parse("http://10.0.2.2:5000/api/postman/posts/cancel/$mailID"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = MsgRes.fromRawJson(response.body);
      //print("Result status " + result.err.toString());
      return (result);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      // mails.addAll(result.mailModel);
      // print(mails.length.toString() + "results found");
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future getMails() async {
    mails.clear();
    try {
      var response = await http.get(
          Uri.parse("http://10.0.2.2:5000/api/postman/posts/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "mailID": "mail002",
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = Result.fromRawJson(response.body);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      mails.addAll(result.mailModel);
      print(mails.length.toString() + "results found");
    } on Exception catch (e) {
      print(e);
    }

    return;
  }

  Future getDeliveredMails() async {
    //print(userName);
    mails.clear();
    try {
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:5000/api/postman/delivered-posts/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "mailID": "mail002",
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = Result.fromRawJson(response.body);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      mails.addAll(result.mailModel);
      print(mails.length.toString() + "results found");
    } on Exception catch (e) {
      print(e);
    }

    return;
  }

  Future getCancelledMails() async {
    mails.clear();
    //print(userName);
    try {
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:5000/api/postman/cancelled-posts/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "mailID": "mail002",
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = Result.fromRawJson(response.body);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      mails.addAll(result.mailModel);
      print(mails.length.toString() + "results found");
    } on Exception catch (e) {
      print(e);
    }

    return;
  }

  Future addLocation(Address address) async {
    print("adding a new location");
    try {
      // var lat = newPosition.latitude;
      // var lng = newPosition.longitude;
      var response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/postman/address/add"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": "$token"
        },
        body: address.toRawJson(),
      );

      var result = MsgRes.fromRawJson(response.body);

      return (result.msg);
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future editLocation(String addressID, LatLng newPosition) async {
    //print("$newPosition");
    try {
      var lat = newPosition.latitude;
      var lng = newPosition.longitude;
      var response = await http.put(
          Uri.parse("http://10.0.2.2:5000/api/postman/address/$addressID"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          },
          body: json.encode(
            <String, String>{
              'addressID': "$addressID",
              "lat": "$lat",
              "lng": "$lng"
            },
          ));

      var result = MsgRes.fromRawJson(response.body);

      return (result.msg);
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future removeLocation(String locationID) async {
    return;
  }
}
