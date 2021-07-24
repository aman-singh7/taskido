import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/locator.dart';
import 'package:task_dot_do/router.dart';
import 'package:task_dot_do/ui/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task.do',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: MaterialColor(
          0xFF1681FF,
          {
            50: AppTheme.primary.withOpacity(0.1),
            100: AppTheme.primary.withOpacity(0.2),
            200: AppTheme.primary.withOpacity(0.3),
            300: AppTheme.primary.withOpacity(0.4),
            400: AppTheme.primary.withOpacity(0.5),
            500: AppTheme.primary.withOpacity(0.6),
            600: AppTheme.primary.withOpacity(0.7),
            700: AppTheme.primary.withOpacity(0.8),
            800: AppTheme.primary.withOpacity(0.9),
            900: AppTheme.primary.withOpacity(1.0),
          },
        ),
        textTheme: TextTheme(
          headline1: AppTheme.headline1,
          headline2: AppTheme.headline2,
          headline3: AppTheme.headline3,
          headline4: AppTheme.headline4,
          bodyText1: AppTheme.bodyText1,
          bodyText2: AppTheme.bodyText2,
          button: AppTheme.button,
        ),
      ),
      onGenerateRoute: TaskdotdoRouter.generateRoute,
      home: StartUpView(),
    );
  }
}
