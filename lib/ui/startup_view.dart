import 'package:flutter/material.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: Center(child: Image.asset('assets/images/spash_screen.png')),
        ),
      ),
      onModelReady: (model) => model.onModelReady(),
    );
  }
}
