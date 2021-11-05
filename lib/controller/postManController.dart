import 'package:easy_mail_app_frontend/model/addressesModel.dart';
import 'package:easy_mail_app_frontend/model/courierModel.dart';
import 'package:easy_mail_app_frontend/model/postManModel.dart';
import 'package:easy_mail_app_frontend/model/tokenModel.dart';
import 'package:easy_mail_app_frontend/model/updatingMsgModel.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/mailModel.Dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PostManController extends GetxController {
  var mails = <MailModel>[].obs;
  var addresses = <Address>[].obs;
  var selectedAddress = <Address>[].obs;
  static PostManModel postMan = new PostManModel();
  var assignedCouriers = <Courier>[].obs;
  var deliveredCouriers = <Courier>[].obs;
  var cancelledCouriers = <Courier>[].obs;
  var loggedin = <String>[].obs;
  static String? token;
  static String? userName;

  Future login(String username, String password) async {
    print(username);
    try {
      var response = await http.post(
        Uri.parse("https://easy-mail-test.herokuapp.com/api/postman/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
            <String, String>{'username': "$username", "password": "$password"}),
      );

      var result = TokenRes.fromRawJson(response.body);
      token = result.token;
      userName = username;
      loggedin.clear();
      loggedin.add(username);
      //print(token);
      return result.err;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future getLocations() async {
    addresses.clear();
    print("getting all locations");
    try {
      var response = await http.get(
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/address/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });

      var result = AddressList.fromRawJson(response.body);
      print(result.addresses);

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
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/posts/confirm/$mailID"),
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
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/posts/cancel/$mailID"),
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
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/posts/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
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
              "https://easy-mail-test.herokuapp.com/api/postman/delivered-posts/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
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
              "https://easy-mail-test.herokuapp.com/api/postman/cancelled-posts/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
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

  Future getAssignedCouriers() async {
    assignedCouriers.clear();
    //print(userName);
    try {
      var response = await http.get(
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/couriers/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = CourierDetails.fromRawJson(response.body);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      assignedCouriers.addAll(result.couriers);
      print(assignedCouriers.length.toString() + " results found");
      return (result.msg);
    } on Exception catch (e) {
      print(e);
    }

    return;
  }

  Future getDeliveredCouriers() async {
    deliveredCouriers.clear();
    //print(userName);
    try {
      var response = await http.get(
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/delivered-couriers/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = CourierDetails.fromRawJson(response.body);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      deliveredCouriers.addAll(result.couriers);
      print(deliveredCouriers.length.toString() + " results found");
      return (result.msg);
    } on Exception catch (e) {
      print(e);
    }

    return;
  }

  Future getCancelledCouriers() async {
    cancelledCouriers.clear();
    //print(userName);
    try {
      var response = await http.get(
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/cancelled-couriers/$userName"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });
      // print(response);
      // List data = json.decode(response.body);
      // print(data);
      var result = CourierDetails.fromRawJson(response.body);
      //print(result);
      //print("${result.mailModel[0].mailId}jfdsdfsdfdf ");
      cancelledCouriers.addAll(result.couriers);
      print(cancelledCouriers.length.toString() + " results found");
      return (result.msg);
    } on Exception catch (e) {
      print(e);
    }

    return;
  }

  Future confirmCourierDelivery(String courierID) async {
    try {
      var response = await http.put(
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/couriers/confirm/$courierID"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });

      var result = MsgRes.fromRawJson(response.body);

      return (result.msg);
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future cancelCourierDelivery(String courierID) async {
    try {
      var response = await http.put(
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/couriers/cancel/$courierID"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": "$token"
          });

      var result = MsgRes.fromRawJson(response.body);

      return (result.msg);
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future addLocation(Address address) async {
    print("adding a new location");
    try {
      // var lat = newPosition.latitude;
      // var lng = newPosition.longitude;
      var response = await http.post(
        Uri.parse(
            "https://easy-mail-test.herokuapp.com/api/postman/address/add"),
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
          Uri.parse(
              "https://easy-mail-test.herokuapp.com/api/postman/address/$addressID"),
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

  Future removeLocation(String addressID) async {
    try {
      var response = await http.delete(
        Uri.parse(
            "https://easy-mail-test.herokuapp.com/api/postman/address/$addressID"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": "$token"
        },
      );

      var result = MsgRes.fromRawJson(response.body);

      return (result.msg);
    } on Exception catch (e) {
      print(e);
      return (1);
    }
  }

  Future editAddress(String addressID, Address address) async {
    //print("$newPosition");
    try {
      var response = await http.put(
        Uri.parse(
            "https://easy-mail-test.herokuapp.com/api/postman/address/update/$addressID"),
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
}
