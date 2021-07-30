import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/startup_viewmodel.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  // @override
  // void initState() {
  //   super.initState();

  //   FirebaseMessaging.instance.getInitialMessage();

  //   //Foreground
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (message.notification != null) {
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //     }
  //   });

  //   //App is in background but opened
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     final routeFromMessage = message.data['routes'];
  //     print(routeFromMessage);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      builder: (context, model, child) => Container(),
      onModelReady: (model) => model.onModelReady(),
    );
  }
}
