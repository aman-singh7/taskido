import 'package:flutter/material.dart';

class TaskdotdoRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
