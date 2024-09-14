class Task {
  String? title;
  String? description;
  bool? isDone;
  String? priority;

  Task({this.title, this.description, this.isDone, this.priority});

  Map tojson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'priority': priority
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'];
    priority = json['priority'];
  }
}