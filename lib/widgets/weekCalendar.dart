import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendar_day_capsule.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key});

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {

  late DateTime _selectedDate;
  late List<DateTime> _weekDays;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    generateCurrentWeek();
  }


  void generateCurrentWeek(){
    final DateTime today = DateTime.now();

    int daysToSubtract = today.weekday % 7;
    DateTime sunday = today.subtract(Duration(days: daysToSubtract));
    _weekDays = List.generate(7,
        (index) => sunday.add(Duration(days: index))
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Colors.white,
      child: Row(
        children: _weekDays.map((dateTime)
          {
            final bool isSelected = dateTime.year == _selectedDate.year &&
                                    dateTime.month == _selectedDate.month &&
                                    dateTime.day == _selectedDate.day;

            return Expanded(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedDate = dateTime;
                  });
                },
                child: CalendarDayCapsule(
                  dayLabel: DateFormat("E").format(dateTime).toUpperCase(),
                  dateLabel: dateTime.day.toString(),
                  isSelected: isSelected,
                ),
              ),
            );
          }
        ).toList(),
      ),
    );
  }
}









