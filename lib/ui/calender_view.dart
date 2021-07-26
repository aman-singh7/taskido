import 'package:flutter/material.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/calender_viewmodel.dart';
import 'package:intl/intl.dart';

class CalenderView extends StatefulWidget {
  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    var _currentDate = DateTime.now();
    var _selectedDate = DateTime.now();
    var _currentMonth = DateFormat.yMMM().format(DateTime.now());
    return BaseView<CalenderViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 30,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text('$_currentMonth'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: CalendarCarousel(
                todayBorderColor: Colors.green,
                daysHaveCircularBorder: true,
                showOnlyCurrentMonthDate: false,
                height: 300,
                selectedDateTime: _currentDate,
                showHeader: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
