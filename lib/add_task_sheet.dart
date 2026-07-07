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


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
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
          children: [

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
          ],
        ),
      )
    );
  }
}


