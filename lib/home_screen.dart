import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/widgets/task.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
              "Wed 1, Jul",
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
            icon: SvgPicture.asset("assests/images/filter button.svg"),
          )
        ],
        
      ),
      body: Center(
        child: SafeArea(
            child: Center(
                child: Column(
                  children: [
                    Task(
                      title: 'task',
                      description: "just a task",
                      time: '9:00',
                      isCompleted: false,
                    ),
                    Text("gggg")
                  ],
                )
            ),
        ),
      ),
    );
  }

  

}
