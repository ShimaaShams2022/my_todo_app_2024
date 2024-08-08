
import 'package:flutter/material.dart';
import 'package:to_do_app_c11/ui/home/settings/SettingsTab.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do App"),
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
