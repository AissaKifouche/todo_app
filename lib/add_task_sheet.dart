import 'dart:math';

import 'package:flutter/material.dart';


class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  DateTime maxDateToChoose(){
    var d = DateTime.now().weekday % 7;
    return DateTime.now().add(Duration(days: 7 - 1 - d));
  }

  Future<void> _selectDate (BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context:  context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: maxDateToChoose(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF004481),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      }
    );

    if (picked != null){
      _dateController.text = "${picked.year} - ${picked.month.toString().padLeft(2, '0')} - ${picked.day}";
    }
  }

  //a function to choose time
  Future<void> _selectTime (BuildContext context) async{
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black
            ),
          ),
          child: child!,
        );
      }
    );

    if(picked != null) {
      var hour = picked.hour.toString().padLeft(2, '0');
      var minute = picked.minute.toString().padLeft(2, '0');
      _timeController.text = "$hour:$minute";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        bottom: 16,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "Add a Task",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black
              ),
            ),

            SizedBox(height: 16,),

            //title input field
            TextField(
              controller: _titleController,
              showCursor: true,
              decoration: InputDecoration(
                label: Text(
                  "Title",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                )
              )
            ),

            SizedBox(height: 16,),

            //description input field
            TextField(
              controller: _descriptionController,
              showCursor: true,
              maxLength: 150,
              decoration: InputDecoration(
                label: Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                )
              ),
            ),

            SizedBox(height: 16,),

            //to pick the date of the task
            TextField(
              readOnly: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16
              ),
              controller: _dateController,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                label: Text(
                  "Date",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                prefixIcon: Icon(Icons.calendar_month_rounded, color: Colors.white,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                )
              ),
            ),

            SizedBox(height: 16,),

            //to pick the time
            TextField(
              readOnly: true,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
              controller: _timeController,
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                  label: Text(
                    "Date",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: Icon(Icons.access_time_rounded, color: Colors.white,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white),
                  )
              ),
            ),

            SizedBox(height: 16,),

            //a cancel button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  "cancel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
            ),

            //add task button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  )
              ),
              onPressed: (){
                if(! (_titleController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty || _dateController.text.trim().isEmpty) ){
                  Navigator.pop(context);
                }
                else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                      title: Text(
                        "Missing Fields",
                      ),
                      content: Text(
                        "You should fill all the fields"
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "OK",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Center(
                child: Text(
                  "add task",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}


