import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/services/local_storage_service.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/login_view.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const String id = 'home_view';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Container(
        color: Colors.white,
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () {
            locator<LocalStorageService>().isLoggedIn = false;
            Get.offAllNamed(LoginView.id);
          },
        ),
      ),
    );
  }
}
