import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/add_task_sheet.dart';
import 'package:todo_app/widgets/task.dart';
import 'package:todo_app/widgets/time_line.dart';
import 'package:todo_app/widgets/weekCalendar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  DateTime _currentSelectedDate = DateTime.now();




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
    //save the modifications to disk
    _saveTasks();
  }


  //delete a task
  void _deleteTask(Task task){
    setState(() {
      _allTasks.remove(task);
    });

    //save modifications to disk
    _saveTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        content: Text(
          "${task.title} is deleted"
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white,
          onPressed: (){
            setState(() {
              _allTasks.add(task);
            });
            _saveTasks();
          },
        ),
      ),
    );
  }


  //a function to load tasks from disk
  Future<void> _loadTasks() async{
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString("saved_tasks");
    
    if(tasksString != null) {
      final List<dynamic> decodedList = jsonDecode(tasksString);
      setState(() {
        _allTasks.clear();
        _allTasks.addAll(
          decodedList.map( (item) => Task.fromJson(item)).toList(),
        );
      });
    }
  }

  //a function to save tasks into disk
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _allTasks.map((task) => task.toJson()).toList(),
    );
    await prefs.setString("saved_tasks", encodedData);
  }

  void _deleteOldTasks() {
    int d = DateTime.now().weekday % 7 + 1;
    setState(() {
      _allTasks.removeWhere((task) => task.dateTime.isBefore(DateTime.now().subtract(Duration(days: d))));
    });
    _saveTasks();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTasks();
    _deleteOldTasks();
  }


  bool isSameDay(DateTime a, DateTime b) => a.day == b.day && a.month == b.month && a.year == b.year;


  //the list of all tasks loaded from disk
  final List<Task> _allTasks = [];
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "there are no tasks for this date",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600]
                        ),
                      ),
                      Text(
                        "tap the add button in bottom right corner to add a task",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600]
                        ),
                      ),
                    ],
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
                      _saveTasks();
                    },
                    onDeleteTask: () => _deleteTask(taskItem),
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
