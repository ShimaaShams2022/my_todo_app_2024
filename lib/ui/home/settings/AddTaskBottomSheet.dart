
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_c11/AppDateUtilitis.dart';

import 'package:to_do_app_c11/providers/TasksProvider.dart';
import 'package:to_do_app_c11/providers/appAuthProvider.dart';
import 'package:to_do_app_c11/ui/common/DateTimeField.dart';
import 'package:to_do_app_c11/ui/common/MaterialTextFormField.dart';
import 'package:to_do_app_c11/ui/register/Dialog_utilities.dart';

import '../../../database/models/Task.dart';

class AddTaskBottomSheet extends StatefulWidget {
   AddTaskBottomSheet({super.key});



  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {

  var title = TextEditingController();
  var description=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child:Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MaterialTextFormField( hint: 'Task Title',
            validator: (text){
              if(text==null || text.trim().isEmpty){
                return "please enter task title";
              }
              return null;
            },
              controller: title,
            ),
            MaterialTextFormField( hint: 'Task Description',lines: 3,
              validator: (text){
                if(text==null || text.trim().isEmpty){
                  return "please enter task description";
                }
                return null;
              },
              controller: description,
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                Expanded(child: DateTimeField( title: "Task Date",
                  hint:selectedDate==null?
                  "select date":
                  "${selectedDate?.formatDate()}",
                  onClick: () {
                    showDatePickerDialog();
                  },)),
                Expanded(child: DateTimeField( title: "Time",
                  hint:selectedTime==null?
                  'please select time':
                  "${selectedTime?.formatTime()}",
                  onClick: () {
                    showTimePickerDialog();
                  },)),

              ],
            ),
            ElevatedButton(onPressed: (){
              addTask();
            }, child:Text("Add Task"))
          ],
        ),
      ) ,
    );
  }

  DateTime? selectedDate;

  Future<void> showDatePickerDialog() async {
   var date = await showDatePicker(context: context,
          initialDate:selectedDate?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365))
      );
   if(date==null)return;
   setState(() {
     selectedDate=date;
   });

  }

  TimeOfDay? selectedTime;
  Future<void> showTimePickerDialog() async {
    var time= await showTimePicker(context: context,
        initialTime: selectedTime ?? TimeOfDay.now());
    if(time==null)return;
    setState(() {
      selectedTime=time;
    });

  }

  bool isValidTask(){
    bool isValid=true;
    if(formKey.currentState?.validate()==false){
      isValid=false;
     }

    if(selectedDate==null){
      showMessageDialog(context, message: "please select task date",postButtonTitle:"ok");
      isValid=false;
    }

    if(selectedTime==null){
      showMessageDialog(context, message: "please select task time",postButtonTitle:"ok");
     isValid=false;
    }
    return isValid;
  }

  Future<void> addTask() async {

    if(isValidTask()==false)return;

    var authProvider = Provider.of<appAuthProvider>(context,listen: false);

    var tasksProvider= Provider.of<TasksProvider>(context,listen: false);

    var task =Task(
        title:title.text,
      description:description.text,
      date:selectedDate?.dateOnly(), // ignore time
        time:selectedTime?.timeSinceEpoch(),
    );
    try {
      showLoadingDialog(context, message:"Adding task please wait");
      var result = await tasksProvider.addTask(authProvider.appUser?.authId ?? "", task);
      hideLoading(context);
      showMessageDialog(context, message:"Task added successfully",postButtonTitle: "ok",postButtonAction: (){
        Navigator.pop(context);
      });
    }catch(e){
      hideLoading(context);
      showMessageDialog(context, message: e.toString(),postButtonTitle: "ok");
    }

    ///////////////////////////////////////// we can do it by another way
    /*
    collection.createTask(authProvider.appUser?.authId ?? "", task).then((value){
      //success
    }).onError((error,stackTrace){
      //if future throw error
    });
   */
    //////////////////////////////////////////////////////////////////////////////////
  }

}
