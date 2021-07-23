import 'package:flutter/cupertino.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      builder: (context, model, child) => Container(
        child: Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
