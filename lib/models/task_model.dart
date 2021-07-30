class Task {
  String id;
  String title;
  String? description;
  bool notifyMe;
  bool isCompleted;
  String from;
  Task({
    required this.id,
    required this.title,
    this.description,
    required this.notifyMe,
    required this.isCompleted,
    required this.from,
  });

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        notifyMe = json['notifyMe'],
        isCompleted = json['isCompleted'],
        from = json['from'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'notifyMe': notifyMe,
        'isCompleted': isCompleted,
        'from': from,
      };
}
