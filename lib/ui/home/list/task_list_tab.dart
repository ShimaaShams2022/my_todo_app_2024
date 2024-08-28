
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do_app_c11/providers/TasksProvider.dart';
import 'package:to_do_app_c11/providers/appAuthProvider.dart';
import 'package:to_do_app_c11/ui/home/list/TaskItem.dart';
import 'package:to_do_app_c11/ui/register/Dialog_utilities.dart';

import '../../../database/models/Task.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  List<Task>? tasksList;

  late appAuthProvider authProvider;
 late  TasksProvider tasksProvider;


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider = Provider.of<appAuthProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {

    tasksProvider= Provider.of<TasksProvider>(context,listen: true);
    return FutureBuilder<List<Task>>(
        future:tasksProvider.getAllTasks(authProvider.authUser?.uid??''),
        builder:(buildContext,snapshot){
         if(snapshot.hasError){
           // handle error
           return Center(child: Column(
             children: [
               const Text("Something went wrong"),
               ElevatedButton(onPressed: (){
                 setState(() {

                 });
               }, child:Text("Try again"))
             ],
           ));
         }
         if(snapshot.connectionState==ConnectionState.waiting){
           //waiting future data //like await in old code
           return Center(child: CircularProgressIndicator());
         }
         // you have data
          var tasksList=snapshot.data;
         return ListView.separated(
             itemBuilder: (context, index) {
               return TaskItem(task: tasksList![index],onDeleteClick: deleteTask,);
             },
             separatorBuilder: (_, __) => Container(
               height: 24,
             ),
             itemCount: tasksList?.length ?? 0);
        }
    );

  }

  void deleteTask(Task task)async{
   showLoadingDialog(context, message: "please wait...");
   try{
     await tasksProvider.removeTask(authProvider.authUser?.uid??'',task);
     hideLoading(context);
     setState(() {

     });
   }catch(e){
     showMessageDialog(context, message: "Something went wrong ${e.toString()}",
     postButtonTitle: "retry",postButtonAction: (){
       deleteTask(task);
         }
     );
   }

  }

}
