
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_c11/providers/appAuthProvider.dart';
import 'package:to_do_app_c11/ui/home/settings/SettingsTab.dart';
import 'package:to_do_app_c11/ui/login/LoginScreen.dart';

import 'list/task_list_tab.dart';

class HomeScreen extends StatefulWidget {

  static const String routeName="HomeScreen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;

  var tabs=[
    TaskListTab(),
    SettingsTab(),

  ];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<appAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${provider.appUser?.fullName}"),
        actions: [
          InkWell(
              onTap: (){
                provider.logout();
                Navigator.pushReplacementNamed(context,LoginScreen.routeName);
              },
              child: Icon(Icons.logout))
        ],
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.white,
              width: 4
            )
          ),
          onPressed: (){},
          child: Icon(Icons.add),
        ),

        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          child: BottomNavigationBar(
            currentIndex: selectedTabIndex,
            onTap: (newSelectedIndex){
              selectedTabIndex=newSelectedIndex;
              setState(() {

              });
            },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: '')
          ],
                ),
        ),
      body: tabs[selectedTabIndex],
    );
  }
}
