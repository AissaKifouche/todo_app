import 'package:flutter/material.dart';
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
      body: Center(
        child: SafeArea(
            child: Center(
                child: Column(
                  children: [
                    Task(
                      title: 'task',
                      description: 'just a task',
                      time: '9:00',
                      isCompleted: false,
                    ),
                    Text("gggg")
                  ],
                )
            )
        ),
      ),
    );
  }

  

}
