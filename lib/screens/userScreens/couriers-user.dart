import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/customerDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_mail_app_frontend/model/courierModel.dart';

class CouriersUser extends StatefulWidget {
  const CouriersUser({Key? key}) : super(key: key);
  static const String route = '/user/courier';

  @override
  _CouriersUserState createState() => _CouriersUserState();
}

class _CouriersUserState extends State<CouriersUser> {
  var userController = new UserController();
  RefreshController _sentrefreshController = RefreshController();
  RefreshController _receivedrefreshController = RefreshController();
  //var searchResult = '';
  bool isLoading = false;
  bool isSearched = false;
  bool isTouched = false;
  var selectedCourier = <Courier>[].obs;
  //var selectedCourier = <Courier>[].obs;
  PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);
  void initState() {
    // TODO: implement initState

    //_getCouriersList(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: postmanAppBar(context),
      drawer: userDrawer(context),
      //extendBody: true,
      body: bottomNavBar(),

      //bottomNavigationBar: bottomNavBar(),
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
    return [deliveredCourierScreen(), sentCourierScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.gift),
        title: ("Received"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(0),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.arrow_up_circle_fill),
        title: ("Sent"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(1),
      ),
    ];
  }

  Widget sentCourierScreen() {
    getCouriersList(1);
    return Expanded(
        child: Container(
      child: Column(children: [
        Text("Couriers sent by You", style: GoogleFonts.laila(fontSize: 20)),
        tableHeading(),
        sentTileList(),
      ]),
    ));
  }

  Widget deliveredCourierScreen() {
    getCouriersList(0);
    return Expanded(
        child: Container(
      child: Column(
        children: [
          Text("Couriers received to you",
              style: GoogleFonts.laila(fontSize: 20)),
          tableHeading(),
          receivedTileList(),
        ],
      ),
    ));
  }

  Widget sentTileList() {
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
              } else if (userController.sentCouriers.isEmpty) {
                return Text('No Sent Couriers Yet',
                    style: GoogleFonts.laila(fontSize: 12));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userController.sentCouriers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(context,
                          userController.sentCouriers.value[index], index),
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
              } else if (userController.receivedCouriers.isEmpty) {
                return Text('No Received Couriers Yet',
                    style: GoogleFonts.laila(fontSize: 12));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userController.receivedCouriers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(context,
                          userController.receivedCouriers.value[index], index),
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
                  padding: EdgeInsets.all(5.0), child: Text("Sender ID"))),
        ),
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0), child: Text("receiver ID"))),
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
                  child: Text("Delivery status"))),
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
          Container(width: 100, child: Text(courier.senderId)),
          //Container(width: 100, child: Text(mail.isDelivered.toString())),
          Container(width: 100, child: Text(courier.receiverId.toString())),
          Container(width: 100, child: Text(courier.isDelivered.toString())),
          // // Container(width: 100, child: Text(tag.subscriber.toString())),
          // SizedBox(),
          IconButton(
              tooltip: "view",
              icon: Icon(Icons.mail),
              color: Colors.black,
              hoverColor: Colors.white,
              onPressed: () {
                isTouched = true;
                selectedCourier.clear();
                selectedCourier.add(courier);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Courier Details',
                      style: GoogleFonts.laila(fontSize: 18),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 300,
                              child: Text("postMan ID : " +
                                  selectedCourier[0].postManId.toString())),
                          Container(
                              width: 300,
                              child: Text("Address ID : " +
                                  selectedCourier[0].addressId.toString())),
                          Container(
                              width: 300,
                              child: Text("Delivery Status: " +
                                  selectedCourier[0].isDelivered.toString())),
                          Container(
                              width: 300,
                              child: Text("Last Appeared Branch: " +
                                  selectedCourier[0]
                                      .lastAppearedBranchId
                                      .toString())),
                          Container(
                              width: 300,
                              child: Text("Weight: " +
                                  selectedCourier[0].weight.toString())),
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
                          // _sentrefreshController.requestRefresh();
                          // _receivedrefreshController.requestRefresh();
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

  getCouriersList(int num) {
    //print("Getting couriers");
    if (num == 0) {
      print("getting received couriers");
      getSentCouriers();
    } else if (num == 1) {
      print("getting sent couriers");
      getReceivedCouriers();
    } else {
      print("getting all couriers");
      getSentCouriers();
      getReceivedCouriers();
    }
  }

  void getSentCouriers() async {
    var msg = userController.getSentCouriers();
    _sentrefreshController.loadComplete();
    _receivedrefreshController.loadComplete();
    print(msg);
  }

  void getReceivedCouriers() async {
    var msg = userController.getReceivedCouriers();
    _sentrefreshController.loadComplete();
    _receivedrefreshController.loadComplete();
    print(msg);
  }
}
