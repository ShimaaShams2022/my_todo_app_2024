import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_c11/AppDateUtilitis.dart';
import 'package:to_do_app_c11/ui/register/Dialog_utilities.dart';
import 'package:to_do_app_c11/ui/utilities.dart';

import '../../../database/models/Task.dart';


typedef OnTaskDeleteClick =void Function(Task task);

class TaskItem extends StatelessWidget {
   TaskItem({required this.task,required this.onDeleteClick,super.key});

  Task task;
  OnTaskDeleteClick onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(onPressed: (buildContext){
              // delete
              showMessageDialog(context, message: "Are you sure to delete this task?",
              postButtonTitle: "confirm",
                postButtonAction:() {
                // delete task
                  onDeleteClick(task);
                },
                negativeButtonTitle: "cancel"
              );

            },
            icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'delete',
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)
              ),
            )
          ],
        ),
        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          color: Colors.white ,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor,
                  ),

                ),
                SizedBox(width: 12,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${task.title}",
                    style:Theme.of(context).textTheme.titleMedium ,
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.watch_later_outlined),
                        SizedBox(width: 8),
                        Text("${task.time?.formatTime()}",
                          style:Theme.of(context).textTheme.titleSmall ,
                        ),
                      ],
                    )
                  ],
            )
          ),
                SizedBox(width: 12,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
                    decoration:BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)
                    ),
                    child: ImageIcon(
                        AssetImage(getImagePath('icon_check.png')),
                      color: Colors.white,
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

