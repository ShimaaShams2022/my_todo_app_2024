
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_c11/database/collections/TasksCollection.dart';
import 'package:to_do_app_c11/database/models/Task.dart';

class TasksProvider extends ChangeNotifier{

  var tasksCollection= TasksCollection();

  Future<List<Task>> getAllTasks(String userId) async {
    var tasksList= await tasksCollection.getAllTasks(userId);
    return tasksList;
  }
  Future<void> removeTask(String userId,Task task) async {
    await tasksCollection.removeTask(userId, task);
    notifyListeners();
    return;
  }
  Future<void> addTask(String userId,Task task)async{
    await tasksCollection.createTask(userId, task);
    notifyListeners();
    return;
  }

  static TasksProvider getInstance(BuildContext context,{bool listen=true}){
    return Provider.of<TasksProvider>(context,listen: listen);
  }
}