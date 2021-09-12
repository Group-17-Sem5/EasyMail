import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/searchBox.dart';
import "package:flutter/material.dart";
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MailListPage extends StatefulWidget {
  MailListPage({Key? key}) : super(key: key);
  static const String route = '/postMan/mailList';

  @override
  _MailListPageState createState() => _MailListPageState();
}

class _MailListPageState extends State<MailListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var _searchController = FloatingSearchBarController();
  var searchResult = '';
  bool isSearched = false;
  List mails = ["mail1", "mail2", "mail3"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: postmanAppBar(context),
        drawer: postManDrawer(context),
        body: Container(
          color: Color(0xFFE0FAEA),
          child: Column(
            children: <Widget>[
              Expanded(
                child: searchBox(context),
              ),
              Expanded(child: mailTable()),
            ],
          ),
        ),
      ),
    );
  }

  Widget mailTable() {
    setState(() {
      //String result = getResult();
      //print(result);
    });
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Age',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Role',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }

  Widget searchBox(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 200),
      controller: _searchController,
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 200),
      onQueryChanged: (query) {
        print(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: const Icon(Icons.mail),
            onPressed: () {
              setState(() {
                searchResult = _searchController.query.toString();
                isSearched = true;
                print(searchResult);
              });
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: mails.map((mails) {
                return Container(
                  height: 50,
                  child: ListTile(
                    title: Text(mails.toString()),
                    onTap: () {
                      tapped(
                        mails.toString(),
                      );
                      print(mails.toString());
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future tapped(String mailName) async {
    List data;
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/")
            //headers: {"accept": "applicati"}
            );

    data = json.decode(response.body);
    if (data[0]['error'] == 1) {
      print('Check again');
    } else {
      var token = data[0]['title'];
      print(token);
    }

    //print(data[1]["title"]);

    print(mailName);
  }
}
