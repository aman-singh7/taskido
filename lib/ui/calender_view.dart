import 'package:flutter/material.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/calender_viewmodel.dart';

class CalenderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CalenderViewModel>(
      builder: (context, model, child) => Container(
        child: Center(
          child: Text('Calender Page'),
        ),
      ),
    );
  }
}
