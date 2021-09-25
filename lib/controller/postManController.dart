import 'package:easy_mail_app_frontend/model/postManModel.dart';
import 'package:get/get.dart';
import '../model/mailModel.Dart';
import '../model/addressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostManController extends GetxController {
  var mails = <MailModel>[].obs;
  var addresses = <AddressModel>[].obs;
  PostManModel postMan = new PostManModel();
  static var token;

  Future login(String username, String password) async {
    var token = "ddd";
    return token;
  }

  Future getLocations() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"),
            //body:{"username":"kusd"},
            headers: {"id": "Kamal002", "mailID": "mail002"});

    List data = json.decode(response.body);

    for (var oneAddress in data) {
      AddressModel address = new AddressModel(
        addressID: oneAddress['id'].toString(), //oneMail['mailID'],
        description: oneAddress['id'].toString(), // oneMail['addressID'],
        branchID: oneAddress['id'].toString(), // oneMail['lastAppearedBranch'],
        lat: oneAddress['id'],
        lng: oneAddress['id'], // oneMail['postManID'],
        userIDList: oneAddress['id'], // oneMail['sourceBranchID'],
      );
      addresses.add(address);
    }
    return;
  }

  Future confirmDelivery(String mailID) async {
    return;
  }

  Future cancelDelivery(String mailID) async {
    return;
  }

  Future getMails(String userName) async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"),
            //body:{"username":"kusd"},
            headers: {"id": "Kamal002", "mailID": "mail002"});

    List data = json.decode(response.body);

    for (var oneMail in data) {
      MailModel mail = new MailModel(
        mailID: oneMail['id'].toString(), //oneMail['mailID'],
        addressID: oneMail['id'].toString(), // oneMail['addressID'],
        lastAppearedBranch:
            oneMail['id'].toString(), // oneMail['lastAppearedBranch'],
        postManID: oneMail['id'].toString(), // oneMail['postManID'],
        sourceBranchID: oneMail['id'].toString(), // oneMail['sourceBranchID'],
        receivingBranchID:
            oneMail['id'].toString(), //oneMail['receivingBranchID'],
        senderID: oneMail['id'].toString(), // oneMail['senderID'],
        receiverID: oneMail['id'].toString(), // oneMail['receiverID'],
        isAssigned: oneMail['id'].toString(), //oneMail['isAssigned'],
        isDelivered: oneMail['id'].toString(), // oneMail['isDelivered']
      );
      mails.add(mail);
    }
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
