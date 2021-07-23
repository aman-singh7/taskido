import 'package:flutter/cupertino.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Container(
        child: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
