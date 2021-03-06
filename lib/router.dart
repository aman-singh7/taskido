import 'package:flutter/material.dart';
import 'package:task_dot_do/ui/base_landing_view.dart';
import 'package:task_dot_do/ui/login_view.dart';
import 'package:task_dot_do/ui/particular_group_view.dart';
import 'package:task_dot_do/ui/routine_view.dart';
import 'package:task_dot_do/ui/settings_view.dart';
import 'package:task_dot_do/ui/register_view.dart';

class TaskdotdoRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case BaseLandingView.id:
        return MaterialPageRoute(builder: (_) => BaseLandingView());
      case LoginView.id:
        return MaterialPageRoute(builder: (_) => LoginView());
      case SettingView.id:
        return MaterialPageRoute(builder: (_) => SettingView());
      case RegisterView.id:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case ParticularGroupView.id:
        return MaterialPageRoute(builder: (_) => ParticularGroupView());
      case RoutineView.id:
        return MaterialPageRoute(builder: (_) => RoutineView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No view defined for this route'),
            ),
          ),
        );
    }
  }
}
