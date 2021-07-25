class Task {
  String title;
  String? description;
  bool notifyMe;
  bool isCompleted;
  String from;
  Task({
    required this.title,
    this.description,
    required this.notifyMe,
    required this.isCompleted,
    required this.from,
  });
}
