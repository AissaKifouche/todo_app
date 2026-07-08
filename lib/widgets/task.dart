
//the task class and logic

import 'dart:convert';

class Task {
  final String title;
  final String description;
  bool isCompleted ;
  final DateTime dateTime;


  Task({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
});

  Map<String, dynamic> toJson (){
    return{
      "title": title,
      "description": description,
      "dateTime": dateTime.toIso8601String(),
      "isCompleted": isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json["description"],
      dateTime: DateTime.parse(json["dateTime"]),
      isCompleted: json['isCompleted'],
    );
  }


}