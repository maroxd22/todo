class TaskModel {
  int? id;
  final String date;
  final String title;
  final String subTitle;
  bool isChecked;
  TaskModel({
    required this.date,
    required this.title,
    required this.subTitle,
    this.isChecked = false,
    this.id,
  });
}
