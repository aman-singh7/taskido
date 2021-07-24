import 'package:task_dot_do/enums/nav_bar_items.dart';
import 'package:task_dot_do/ui/base_view.dart';
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

    return BaseView<BaseLandingViewmodel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: model.body,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  child: Center(
                    child: Text('Bottom Sheet to add Task'),
                  ),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.blue[100],
            notchMargin: 6,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 30 * h,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildBottomNav(model),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
