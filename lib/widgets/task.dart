import 'package:flutter/material.dart';

class Task extends StatefulWidget {



  final String title;
  final String description;
  final String time;
  final bool isCompleted;

  const Task({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.isCompleted
});


  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool _isExpanded = false;


  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF003F83);
    var cardBorderColor = widget.isCompleted ? Colors.black.withValues(alpha: 0.4) : primaryBlue;
    var textColor = widget.isCompleted ? Colors.black.withValues(alpha:  0.4) : ( _isExpanded ? Colors.white : Colors.black ) ;



    return InkWell(

      onTap: (){
        setState(() {
          _isExpanded = ! _isExpanded;
        });
      }


    );
  }
}
