import 'package:flutter/material.dart';
import 'task.dart';
import 'taskCard.dart';

class TimeLine extends StatefulWidget {

  final Task task;
  final VoidCallback onToggleComplete;
  final bool isFirst, isLast;


  const TimeLine({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.isFirst,
    required this.isLast,
  });

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {


    //color of the line
    const lineColor = Color(0xFF003F83);
    bool cardIsExpanded = false;

    return IntrinsicHeight(
      child: Stack(
        children: [

          //the line
          Positioned(
            left: 24,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              color: lineColor,
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 17,),
              //the circle on the line for each task
              Container(
                width: 19,
                height: 19,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: lineColor,
                    width: 3,
                  ),
                ),
              ),

              SizedBox(width: 12,),

              Expanded(
                child: TaskCard(
                  task: widget.task,
                  onToggleComplete: widget.onToggleComplete,
                  onToggleExpand: (e) {
                    setState(() {
                      cardIsExpanded = !cardIsExpanded;
                    });
                  },
                ),
              ),

              SizedBox(width: 14,),

            ],
          ),

        ],
      ),
    );
  }
}