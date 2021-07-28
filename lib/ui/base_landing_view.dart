import 'package:get/get.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/enums/nav_bar_items.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/ui/settings_view.dart';
import 'package:task_dot_do/viewmodels/base_landing_viewmodel.dart';
import 'package:flutter/material.dart';

class BaseLandingView extends StatefulWidget {
  static const String id = 'base_landing_view';

  @override
  _BaseLandingViewState createState() => _BaseLandingViewState();
}

class _BaseLandingViewState extends State<BaseLandingView> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 360;

    VoidCallback _fabOnPressed(dynamic model) {
      var function;
      switch (model.activeTab) {
        case 0:
        case 1:
          function = () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: model.fabBody,
                );
              },
            );
          };
          break;
        case 2:
          function = () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return model.fabBody;
              },
            );
          };
          break;
        case 3:
          function = () => Get.toNamed(SettingView.id);
      }
      return function;
    }

    List<Widget> _buildBottomNav(var model) {
      var activeTab = model.activeTab;
      var result = [
        IconButton(
          onPressed: () => model.setState(NavBarItem.HOME),
          icon: Icon(
            Icons.home,
            color: activeTab == 0 ? Colors.white : Colors.black,
          ),
        ),
        IconButton(
          onPressed: () => model.setState(NavBarItem.CALENDER),
          icon: Icon(
            Icons.calendar_today,
            color: activeTab == 1 ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          width: h * 30,
        ),
        IconButton(
          onPressed: () => model.setState(NavBarItem.GROUPS),
          icon: Icon(
            Icons.people,
            color: activeTab == 2 ? Colors.white : Colors.black,
          ),
        ),
        IconButton(
          onPressed: () => model.setState(NavBarItem.PROFILE),
          icon: Icon(
            Icons.person,
            color: activeTab == 3 ? Colors.white : Colors.black,
          ),
        ),
      ];
      return result;
    }

    Widget getIcon(int tab) {
      if (tab == 3) return Icon(Icons.settings);
      return Icon(Icons.add);
    }

    return BaseView<BaseLandingViewmodel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: model.body,
          floatingActionButton: model.isVisible
              ? FloatingActionButton(
                  backgroundColor: AppTheme.primary,
                  onPressed: _fabOnPressed(model),
                  child: getIcon(model.activeTab),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: model.isVisible ? 30 * h : 0,
            child: model.isVisible
                ? BottomAppBar(
                    color: Colors.blue[100],
                    notchMargin: 6,
                    shape: CircularNotchedRectangle(),
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildBottomNav(model),
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                  ),
          ),
        ),
      ),
    );
  }
}
