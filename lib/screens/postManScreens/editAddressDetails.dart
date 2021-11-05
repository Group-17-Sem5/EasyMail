import 'package:easy_mail_app_frontend/model/addressesModel.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/marker.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:flutter/material.dart';
import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:get/get.dart';

class EditAddressDetails extends StatefulWidget {
  const EditAddressDetails({Key? key}) : super(key: key);
  static const String route = '/postMan/editAddressDetails';
  @override
  _EditAddressDetailsState createState() => _EditAddressDetailsState();
}

class _EditAddressDetailsState extends State<EditAddressDetails> {
  PostManController postManController = new PostManController();

  TextEditingController _addressIDController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _latController = new TextEditingController();
  TextEditingController _lngController = new TextEditingController();
  TextEditingController _branchIDController = new TextEditingController();
  TextEditingController _userIDListController = new TextEditingController();
  @override
  void initState() {
    _addressIDController.text = postManController.selectedAddress[0].addressId;
    _descriptionController.text =
        postManController.selectedAddress[0].description;
    _branchIDController.text = postManController.selectedAddress[0].branchId;
    _latController.text = postManController.selectedAddress[0].lat;
    _lngController.text = postManController.selectedAddress[0].lng;
    _userIDListController.text =
        postManController.selectedAddress[0].userIdList.toString();
    print(_userIDListController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: postmanAppBar(context),
      drawer: postManDrawer(context, "Edit Address"),
      body: Container(
        child: Column(
          children: [
            Text("Enter the new Details"),
            addressIDField(),
            descriptionField(),
            branchIDField(),
            userIDListField(),
            Row(children: [
              submitButton(),
              cancelButton(),
            ]),
          ],
        ),
      ),
    );
  }

  Widget addressIDField() {
    return (TextField(
      controller: _addressIDController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "addressID",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ));
  }

  Widget descriptionField() {
    return (TextField(
      controller: _descriptionController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Description",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ));
  }

  Widget branchIDField() {
    return (TextField(
      controller: _branchIDController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "BranchID",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ));
  }

  Widget userIDListField() {
    return (TextField(
      controller: _userIDListController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "UserIDList",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ));
  }

  Widget cancelButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF000000),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PlaceMarkerBody()));
        },
        child: Text("Back",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget submitButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF000000),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => EditAddressDetails()));
        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
