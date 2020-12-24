import 'dart:io';

import 'package:fl_tvshow/Hwpage.dart';
import 'package:fl_tvshow/Zjpage.dart';
import 'package:fl_tvshow/Tvpage.dart';
import 'package:fl_tvshow/Szpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> _controllerList;
  DateTime lastPopTime;
  static int index = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerList = [
      new Zjpage(),
      new Hwpage(),
      new Tvpage(),
      new Szpage()
    ];
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: IndexedStack(
          index: this._currentIndex,
          children: this._controllerList,
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: _currentIndex,
            // Use this to update the Bar giving a position
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _MyHomePageState.index = index;
              });
            },
            items: [
              TitledNavigationBarItem(title:Text('追剧'), icon: Icons.home),
              TitledNavigationBarItem(title: Text('海外'), icon: Icons.blur_on),
              TitledNavigationBarItem(title: Text('TV'), icon: Icons.add_to_queue),
              TitledNavigationBarItem(title: Text('设置'), icon: Icons.account_circle),
            ]),
        // ignore: missing_return
      ),
      onWillPop: () {
        // 点击返回键的操作
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(
              msg: "再按一次退出",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Theme.of(context).accentColor,
              textColor: Colors.black,
              fontSize: 16.0);
        } else {
          lastPopTime = DateTime.now();
//          DownloadManagement.removeBind();
          // 退出app
          exit(0);
        }
      },
    );
  }
}
