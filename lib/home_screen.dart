import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_task.dart';
import 'task_model.dart';
import 'task_widget.dart';
import 'task_provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AddTask()));
        },
        child: Icon(Icons.add),),
        appBar: AppBar(
          title: Text('To Do List'),
          bottom: TabBar(
            tabs: [
            Tab(text: 'All Task',),
            Tab(text: 'Completed Task',),
            Tab(text: 'Incomplete Task',),
          ],
            isScrollable: true, controller: tabController,),
        ),
        body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children:[
                  AllTask(),
                  CompletedTask(),
                  InCompletedTask(),
                ],
                  controller: tabController,),
              ),
            ],),),
    );

  }
}

class AllTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.tasks.length,
          itemBuilder: (context, index) {
            return TaskWidget(value.tasks[index]);
          },
        );
      },
    );
  }
}

class CompletedTask extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        List<Task> tasks = value.tasks.where((element) => element.isCompleted == true).toList();
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {

            return TaskWidget(tasks[index]);
          },
        );
      },
    );
  }
}



class InCompletedTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        List<Task> tasks = value.tasks.where((element) =>
        element.isCompleted == false).toList();
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskWidget(tasks[index]);
          },
        );
      },
    );
  }

}
