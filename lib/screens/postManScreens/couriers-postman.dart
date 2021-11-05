import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:easy_mail_app_frontend/model/courierModel.dart';
import 'package:easy_mail_app_frontend/model/moneyOrderModel.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/customerDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/searchBox.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:easy_mail_app_frontend/controller/appBinding.dart';
import 'package:easy_mail_app_frontend/model/mailModel.Dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostManCourierPage extends StatefulWidget {
  PostManCourierPage({Key? key}) : super(key: key);
  static const String route = '/postman/couriers';

  @override
  _PostManCourierPageState createState() => _PostManCourierPageState();
}

class _PostManCourierPageState extends State<PostManCourierPage> {
  //var _searchController = FloatingSearchBarController();
  var postManController = new PostManController();
  RefreshController _refreshController = RefreshController();
  PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);
  //var searchResult = '';
  bool isLoading = false;
  bool isSearched = false;
  bool isTouched = false;

  var selectedCourier = <Courier>[].obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //List mails = ["mail1", "mail2", "mail3"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: postmanAppBar(context),
        drawer: postManDrawer(context, "Couriers"),
        body: bottomNavBar(),
      ),
    );
  }

  Widget bottomNavBar() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [assignedCouriers(), deliveredCouriers(), cancelledCouriers()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.gift_fill),
        title: ("Assigned"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(0),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.smiley),
        title: ("Delivered"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(1),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.gift),
        title: ("Cancelled"),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(1),
      ),
    ];
  }

  Widget assignedCouriers() {
    getCouriers(0);
    return Expanded(
        child: Container(
      child: Column(children: [
        Text("Couriers Assigned to you"),
        tableHeading(),
        assignedTileList(),
      ]),
    ));
  }

  Widget deliveredCouriers() {
    getCouriers(1);
    return Expanded(
        child: Container(
      child: Column(children: [
        Text("Couriers Delivered by you"),
        tableHeading(),
        receivedTileList(),
      ]),
    ));
  }

  Widget cancelledCouriers() {
    getCouriers(2);
    return Expanded(
        child: Container(
      child: Column(children: [
        Text("Couriers caneclled by you"),
        tableHeading(),
        cancelledTileList(),
      ]),
    ));
  }

  Widget assignedTileList() {
    return Expanded(
      child: isLoading
          ? Center(
              child: Column(
                children: [
                  Text("Loading data.."),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Obx(() {
              if (isLoading) {
                return Text('Loading');
              } else if (postManController.assignedCouriers.isEmpty) {
                return Text('No Assigned Couriers Yet',
                    style: GoogleFonts.laila(fontSize: 12));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: postManController.assignedCouriers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: assignedTagCard(
                          context,
                          postManController.assignedCouriers.value[index],
                          index),
                    );
                  },
                );
              }
            }),
    );
  }

  Widget receivedTileList() {
    return Expanded(
      child: isLoading
          ? Center(
              child: Column(
                children: [
                  Text("Loading data.."),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Obx(() {
              if (isLoading) {
                return Text('Loading');
              } else if (postManController.deliveredCouriers.isEmpty) {
                return Text('Empty List');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: postManController.deliveredCouriers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(
                          context,
                          postManController.deliveredCouriers.value[index],
                          index),
                    );
                  },
                );
              }
            }),
    );
  }

  Widget cancelledTileList() {
    return Expanded(
      child: isLoading
          ? Center(
              child: Column(
                children: [
                  Text("Loading data.."),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Obx(() {
              if (isLoading) {
                return Text('Loading');
              } else if (postManController.cancelledCouriers.isEmpty) {
                return Text('No Couriers Yet',
                    style: GoogleFonts.laila(fontSize: 12));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: postManController.cancelledCouriers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(
                          context,
                          postManController.cancelledCouriers.value[index],
                          index),
                    );
                  },
                );
              }
            }),
    );
  }

  Widget tableHeading() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Address ID",
                      style: GoogleFonts.laila(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )))),
        ),
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("receiver ID",
                      style: GoogleFonts.laila(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )))),
        ),
        // Expanded(
        //   child: Container(
        //       height: 40,
        //       color: Colors.lightGreen,
        //       child: Padding(
        //           padding: EdgeInsets.all(5.0), child: Text("Special Code"))),
        // ),
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Delivery status",
                      style: GoogleFonts.laila(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )))),
        ),
        Container(height: 40, width: 50, color: Colors.lightGreen),
        // Expanded(
        //   child: Text("Address Description"),
        // ),
        // Expanded(child: Text("Mail Id"),),
      ],
    );
  }

  Widget tagCard(BuildContext context, Courier courier, int index) {
    return Container(
      height: 40,
      color: Colors.greenAccent,
      child: Row(
        children: [
          Container(width: 100, child: Text(courier.id)),
          //Container(width: 100, child: Text(mail.isDelivered.toString())),
          Container(width: 100, child: Text(courier.receiverId.toString())),
          Container(width: 100, child: Text(courier.isDelivered.toString())),
          // // Container(width: 100, child: Text(tag.subscriber.toString())),
          // SizedBox(),
          IconButton(
              tooltip: "view",
              icon: Icon(CupertinoIcons.gift_fill),
              color: Colors.black,
              hoverColor: Colors.white,
              onPressed: () {
                isTouched = true;
                selectedCourier.clear();
                selectedCourier.add(courier);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Courier Details',
                        style: GoogleFonts.laila(fontSize: 12)),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 300,
                              child: Text("Receiver ID : " +
                                  selectedCourier[0].receiverId.toString())),
                          Container(
                              width: 300,
                              child: Text("Weight : " +
                                  selectedCourier[0].weight.toString())),
                          Container(
                              width: 300,
                              child: Text("Delivery Status: " +
                                  selectedCourier[0].isDelivered.toString())),
                          Container(
                              width: 300,
                              child: Text("Address: " +
                                  selectedCourier[0].addressId.toString())),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      // TextButton(
                      //   onPressed: () => Navigator.pop(context, 'Cancel'),
                      //   child: const Text('Cancel'),
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          // _refreshController.requestRefresh();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget assignedTagCard(BuildContext context, Courier courier, int index) {
    return Container(
      height: 40,
      color: Colors.greenAccent,
      child: Row(
        children: [
          Container(width: 100, child: Text(courier.addressId)),
          //Container(width: 100, child: Text(mail.isDelivered.toString())),
          Container(width: 100, child: Text(courier.receiverId.toString())),
          Container(width: 100, child: Text(courier.isDelivered.toString())),
          // // Container(width: 100, child: Text(tag.subscriber.toString())),
          // SizedBox(),
          IconButton(
              tooltip: "view",
              icon: Icon(CupertinoIcons.gift_fill),
              color: Colors.black,
              hoverColor: Colors.white,
              onPressed: () {
                isTouched = true;
                selectedCourier.clear();
                selectedCourier.add(courier);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Courier Details',
                        style: GoogleFonts.laila(fontSize: 12)),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 300,
                              child: Text("Receiver ID : " +
                                  selectedCourier[0].receiverId.toString())),
                          Container(
                              width: 300,
                              child: Text("Weight : " +
                                  selectedCourier[0].weight.toString())),
                          Container(
                              width: 300,
                              child: Text("Delivery Status: " +
                                  selectedCourier[0].isDelivered.toString())),
                          Container(
                              width: 300,
                              child: Text("Address: " +
                                  selectedCourier[0].addressId.toString())),
                          Row(
                            children: [
                              IconButton(
                                  tooltip: "Deliver",
                                  icon: Icon(Icons.check),
                                  color: Colors.black,
                                  hoverColor: Colors.white,
                                  onPressed: () {
                                    deliverCourier(courier.id);
                                  }),
                              IconButton(
                                  tooltip: "Cancel",
                                  icon: Icon(Icons.block),
                                  color: Colors.black,
                                  hoverColor: Colors.white,
                                  onPressed: () {
                                    cancelDelivery(courier.id);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      // TextButton(
                      //   onPressed: () => Navigator.pop(context, 'Cancel'),
                      //   child: const Text('Cancel'),
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          // _refreshController.requestRefresh();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  //methods
  getCouriers(int num) {
    if (num == 0) {
      getAssignedCouriersList();
    } else if (num == 1) {
      getDeliveredCouriersList();
    } else {
      getCancelledCouriersList();
    }
  }

  Future getAssignedCouriersList() async {
    var msg = await postManController.getAssignedCouriers();

    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    _refreshController.loadComplete();
  }

  Future getDeliveredCouriersList() async {
    var msg = await postManController.getDeliveredCouriers();

    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    _refreshController.loadComplete();
  }

  Future getCancelledCouriersList() async {
    var msg = await postManController.getCancelledCouriers();

    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    _refreshController.loadComplete();
  }

  Future deliverCourier(id) async {
    var msg = await postManController.confirmCourierDelivery(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PostManCourierPage()));
  }

  Future cancelDelivery(id) async {
    var msg = await postManController.cancelCourierDelivery(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PostManCourierPage()));
  }

  // Future deliverMail(String mailID) async {
  //   var result = await postManController.confirmDelivery(mailID);
  //   if (result.err == 0) {
  //     var msg = result.msg;
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('$msg')));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Something went Wrong ')));
  //   }
  // }

  // Future cancelDelivery(String mailID) async {
  //   var result = await postManController.cancelDelivery(mailID);
  //   if (result.err == 0) {
  //     var msg = result.msg;
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('$msg')));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Something went Wrong ')));
  //   }
  // }
}
