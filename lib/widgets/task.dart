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
        child: _isExpanded?
            _buildExpandLayout(cardBorderColor, textColor, widget.isCompleted)
            : _buildCompactLayout(cardBorderColor, textColor, widget.isCompleted),



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
                widget.title,
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
                widget.time,
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


  Widget _buildExpandLayout(Color cardBorderColor, Color textColor, bool isCompleted){
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],

      ),
    );
  }




}


