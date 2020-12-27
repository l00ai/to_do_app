import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_model.dart';
import 'task_provider.dart';

class TaskWidget extends StatelessWidget{
  Task task;
  TaskWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
        builder: (context, value, child) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context){
                          return SearchFilter(task);
                        }
                    );
                  }, child: Icon(Icons.delete)),
                  Text(task.taskName),
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (valuec) {
                        task.isCompleted = valuec;
                        value.updateTask(Task(taskName: task.taskName,isCompleted: valuec));
                    },)
                ],
              ),
            ),
          );
        },
    );
  }

}

class SearchFilter extends StatelessWidget {
Task _task ;
SearchFilter(this._task);
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        return AlertDialog(
          title: Text("Delete",),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('OK',style: TextStyle(color: Colors.red),),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textColor: Theme.of(context).accentColor,
              onPressed: ()  {
                value.deleteTask(this._task);
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: Text("Are You Sure To Delete This Task ?")
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
