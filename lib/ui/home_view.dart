import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewmodel>(
      builder: (context, model, child) => Container(),
    );
  }
}
