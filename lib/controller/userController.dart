import 'package:easy_mail_app_frontend/model/postManModel.dart';
import 'package:easy_mail_app_frontend/model/tokenModel.dart';
import 'package:easy_mail_app_frontend/model/userModel.dart';
import 'package:get/get.dart';
import '../model/mailModel.Dart';
import '../model/addressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  var mails = <MailModel>[].obs;
  UserModel postMan = new UserModel();
  static String? token;
  static String? userName;

  Future register(String details) async {
    return;
  }

  Future login(String username, String password) async {
    print(username);
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/user/login"),
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

  Future getSentMails() async {
    try {
      var response = await http.get(
          Uri.parse("http://10.0.2.2:5000/api/user/sent-mails/$userName"),
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

  Future getSentMoneyOrders(String mailID) async {
    return;
  }

  Future getReceivedMoneyOrders(String mailID) async {
    return;
  }

  Future getReceivedMails() async {
    try {
      var response = await http.get(
          Uri.parse("http://10.0.2.2:5000/api/user/mailbox/$userName"),
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

  Future changeMyAddressID(String addressID) async {
    return;
  }
}
