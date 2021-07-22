import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/router.dart';
import 'package:task_dot_do/ui/home_view.dart';

void main() async {
  await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task.do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: TaskdotdoRouter.generateRoute,
      home: HomeView(),
    );
  }
}
