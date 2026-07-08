import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/add_task_sheet.dart';
import 'package:todo_app/widgets/task.dart';
import 'package:todo_app/widgets/taskCard.dart';
import 'package:todo_app/widgets/time_line.dart';
import 'package:todo_app/widgets/weekCalendar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  DateTime _currentSelectedDate = DateTime.now();


  //a list to make some tasks to test
  final List<Task> _allTasks = [
    Task(title: "task1\nhh", description: "some shi description", dateTime: DateTime(2026, 7, 5, 17, 20)),
    Task(title: "task2", description: "description 2 ", dateTime: DateTime(2026, 7, 6, 4, 50)),
    Task(title: "task 3 ", description: "blabla\nhvbjkj\njhvu\nhhkb\njjj", dateTime: DateTime.now()),
    Task(title: 'task 4', description: "flflf", dateTime: DateTime(2026, 7, 10, 9, 00))
  ];

  void _addNewTask(String title, String description, DateTime dateTime){
    setState(() {
      _allTasks.add(
        Task(
          title: title,
          description: description,
          dateTime: dateTime,
        )
      );
    });
  }


  bool isSameDay(DateTime a, DateTime b) => a.day == b.day && a.month == b.month && a.year == b.year;


  //the filtered list of the selected date's tasks
  List<Task> get filteredTasks => _allTasks.where((task) => isSameDay(task.dateTime, _currentSelectedDate)).toList();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF9FC2F0),
        
        //the today text
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Today",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Text(
              DateFormat("MMMM d, yyyy").format(DateTime.now()),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
             WeekCalendar(
               onDateSelected: (date) {
                 setState(() {
                   _currentSelectedDate = date;
                 });
               },
             ),

            SizedBox(height: 10,),

            Expanded(
              child: filteredTasks.isEmpty ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "there is no tasks for this date",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black
                    ),
                  ),
                ),
              )
              //if there are tasks :
              :ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index){
                  final taskItem = filteredTasks[index];
                  return TimeLine(
                    task: taskItem,
                    isFirst: index == 0,
                    isLast: index == filteredTasks.length - 1,
                    onToggleComplete: (){
                      setState(() {
                        taskItem.isCompleted = !taskItem.isCompleted;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            backgroundColor: Color(0xFF9FC2F0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(30))),
            builder: (context) => AddTaskSheet(onTaskAdded: _addNewTask,),
          );
        },
        backgroundColor: Color(0xFF9FC2F0),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
