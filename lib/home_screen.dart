import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/task.dart';
import 'package:todo_app/widgets/taskCard.dart';
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
    Task(title: "task1", description: "some shi description", dateTime: DateTime(2026, 7, 4, 17, 20)),
    Task(title: "task2", description: "description 2 ", dateTime: DateTime(2026, 7, 1, 4, 50)),
    Task(title: "task 3 ", description: "blabla", dateTime: DateTime.now()),
    Task(title: 'task 4', description: "flflf", dateTime: DateTime(2026, 6, 30, 9, 00))
  ];


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
        
        //the filter button
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: SvgPicture.asset("assets/images/filter button.svg"),
          )
        ],
        
      ),
      body: Center(
        child: SafeArea(
            child: Center(
                child: Column(
                  children: [

                    WeekCalendar(),

                    SizedBox(height: 10,),
                    
                    
                  ],
                )
            ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        backgroundColor: Color(0xFFB8D0EF),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  

}
