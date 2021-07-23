import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/router.dart';
import 'package:task_dot_do/ui/base_landing_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task.do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: TaskdotdoRouter.generateRoute,
      home: BaseLandingView(),
    );
  }
}
