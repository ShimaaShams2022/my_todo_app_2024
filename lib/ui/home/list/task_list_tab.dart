import 'package:flutter/material.dart';
import 'package:to_do_app_c11/ui/home/list/TaskItem.dart';

class TaskListTab extends StatelessWidget {
  const TaskListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder:(context, index) {
      return TaskItem();
    }, separatorBuilder: (_,__)=>Container(height: 24,),
        itemCount:5);
  }
}