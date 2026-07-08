
//the task class and logic

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


}