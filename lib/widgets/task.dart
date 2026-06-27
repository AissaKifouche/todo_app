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
      },

      borderRadius: BorderRadius.circular(10),


      child: AnimatedContainer(
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isExpanded ?
              (widget.isCompleted? Colors.white : primaryBlue)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: cardBorderColor,
          ),
        ),
        child: _buildCompactLayout(cardBorderColor, textColor),



      ),


    );
  }


  //the compact layout
Widget _buildCompactLayout (Color cardBorderColor, Color textColor){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        Container(
            width: 1,
            height: 24,
            color: cardBorderColor.withOpacity(0.3),
          ),
          const SizedBox(width: 16),
          Text(
            widget.time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
      ],
    );
}


}


