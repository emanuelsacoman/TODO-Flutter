class Task{
  String? title;
  String? description;
  bool? isDone;

  Task({required this.title, required this.description, this.isDone});

  Map toJson(){
    return {
      'title': title,
      'description': description,
      'isDone': isDone
    };
  }
  Task.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'] ?? false;
  }

}