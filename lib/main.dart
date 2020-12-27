import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'task_provider.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskProvider>(
      create: (context) {
        return TaskProvider();
      },
      child: MaterialApp(
        home: Consumer<TaskProvider>(
         builder: (context, value, child) {
           if(value.isInit){
             return HomeScreen();
           }
           return Center(
             child: CircularProgressIndicator(),
           );
         },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );

  }

}
