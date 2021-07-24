import 'package:flutter/material.dart';
import 'package:task_dot_do/ui/home_view.dart';
import 'package:task_dot_do/ui/login_view.dart';

class TaskdotdoRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.id:
        return MaterialPageRoute(builder: (_) => HomeView());
      case LoginView.id:
        return MaterialPageRoute(builder: (_) => LoginView());
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
