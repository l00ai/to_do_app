import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_model.dart';
import 'task_provider.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String task;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    this.task = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Task Name ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Is Completed"),
                    Checkbox(
                      value: isCompleted,
                      onChanged: (value) {
                        this.isCompleted = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    value.insertNewTask(Task(taskName: this.task, isCompleted: this.isCompleted));
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
