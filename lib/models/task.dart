class TaskModel {
  final String title;
  final String startTime;
  final String endTime;
  final String date;
  final String reminder;
  final String repeat;
  final String color;
  String? favorite = 'false';
  String? completed = 'false';

  TaskModel({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.reminder,
    required this.repeat,
    required this.color,
    this.favorite,
    this.completed,
  });
}
