//the task ui layout ( card )


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'task.dart';

class TaskCard extends StatefulWidget {

  final Task task;
  final VoidCallback onToggleComplete;

  TaskCard({
    super.key,
    required this.task,
    required this.onToggleComplete,
});


  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _isExpanded = false;


  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF003F83);
    var cardBorderColor = widget.task.isCompleted ? Colors.black.withValues(alpha: 0.4) : primaryBlue;
    var textColor = widget.task.isCompleted ? Colors.black.withValues(alpha:  0.4) : ( _isExpanded ? Colors.white : Colors.black ) ;



    return InkWell(

      onTap: (){
        setState(() {
          _isExpanded = ! _isExpanded;
        });
      },

      borderRadius: BorderRadius.circular(10),


      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isExpanded ?
              (widget.task.isCompleted? Colors.white : primaryBlue)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cardBorderColor,
          ),
        ),
        child: _isExpanded?
            _buildExpandLayout(cardBorderColor, textColor, widget.task.isCompleted)
            : _buildCompactLayout(cardBorderColor, textColor, widget.task.isCompleted),



      ),


    );
  }


  //the compact layout
  Widget _buildCompactLayout (Color cardBorderColor, Color textColor, bool isCompleted){
    return SizedBox(
      height:30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 22,),
              Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  decoration: isCompleted? TextDecoration.lineThrough : null
                ),
              ),
            ],
          ),
          Row(
            children: [
              VerticalDivider(
                //width: 10,
                thickness: 2,
                color: cardBorderColor,
              ),
              SizedBox(width: 25,),
              Text(
                DateFormat("HH:mm").format(widget.task.dateTime),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 26,
                  color: textColor,
                ),
              ),
              SizedBox(width: 25,)
            ],
          ),
        ],
      ),
    );
  }



  //the expanded view of a task
  Widget _buildExpandLayout(Color cardBorderColor, Color textColor, bool isCompleted){

    //IntrinsicHeight forces its child to be in the height of its highest component or child ..
    return IntrinsicHeight(

      //the complete row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //a column to contain the task title and its description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //title
              Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 26,
                  color: textColor,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              SizedBox(height: 10,),

              //description
              Text(
                widget.task.description,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              )
            ],
          ),

          //used another row to contain the divider and time and icons
          Row(
            children: [

              //the white divider
              VerticalDivider(
                width: 2,
                thickness: 2,
                color: textColor,
              ),

              SizedBox(width: 10,),

              //a column for the time and icons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //time
                  Text(
                    DateFormat("HH:mm").format(widget.task.dateTime),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 26,
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //the delete icon
                      IconButton(
                        onPressed: (){

                        },
                        icon: isCompleted?
                              SvgPicture.asset("assets/images/deleteIconCompleted.svg")
                            : SvgPicture.asset('assets/images/deleteIconNotCompleted.svg'),
                      ),

                      //the done button
                      IconButton(
                        onPressed: widget.onToggleComplete,
                        icon: isCompleted?
                              SvgPicture.asset("assets/images/doneButtonCompleted.svg")
                              : SvgPicture.asset("assets/images/doneButtonNotCompleted.svg"),
                      )
                    ],
                  )
                ],
              ),

              SizedBox(width: 10,),

            ],
          )
        ],
      ),
    );
  }




}


