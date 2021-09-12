import 'package:get/get.dart';
import '../model/mailModel.Dart';
import '../model/addressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostManController extends GetxController {
  var mails = <MailModel>[].obs;
  static var token;

  Future login(String username, String password) async {
    var token = "ddd";
    return token;
  }

  Future getMails(String userName) async {
    return;
  }

  Future confirmDelivery(String mailID) async {
    return;
  }

  Future cancelDelivery(String mailID) async {
    return;
  }

  Future getLocations() async {
    return;
  }

  Future addLocation(AddressModel address) async {
    return;
  }

  Future editLocation(String locationID, AddressModel address) async {
    print(address.addressID);
    return;
  }

  Future removeLocation(String locationID) async {
    return;
  }
}
