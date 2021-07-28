import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_dot_do/app_theme.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/calender_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatefulWidget {
  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CalenderViewModel>(
      onModelReady: (model) => model.onModelReady(),
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Column(
        children: [
          TableCalendar(
            focusedDay: model.focussedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(3000),
            eventLoader: model.getTasksForDay,
            selectedDayPredicate: (day) => isSameDay(model.selectedDay, day),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
            headerStyle: HeaderStyle(
              titleTextFormatter: (date, locale) =>
                  DateFormat.y().add_MMM().format(date),
              titleTextStyle: AppTheme.headline3,
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
              headerPadding: EdgeInsets.fromLTRB(32, 16, 16, 16),
            ),
            calendarStyle: CalendarStyle(
              markersOffset: PositionedOffset(top: 4),
              markersAutoAligned: false,
              outsideDaysVisible: false,
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.red),
              markerSize: 5,
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              todayDecoration: BoxDecoration(shape: BoxShape.circle),
              selectedTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary,
              ),
            ),
            formatAnimationDuration: Duration(milliseconds: 200),
            onDaySelected: (selectedDay, focussedDay) {
              if (!isSameDay(selectedDay, model.selectedDay)) {
                model.selectedDay = selectedDay;
                model.focussedDay = focussedDay;
              }
            },
            calendarBuilders: CalendarBuilders(),
            calendarFormat: model.calendarFormat,
            onFormatChanged: (calendarFormat) {
              model.calendarFormat = calendarFormat;
            },
            onPageChanged: (focussedDay) {
              model.focussedDay = focussedDay;
            },
          ),
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      height: 3,
                      width: 40,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: model.scrollController,
                      itemCount: model.tasksOnSelectedDay.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            model
                                .getTasksForDay(model.selectedDay)[index]
                                .title,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
