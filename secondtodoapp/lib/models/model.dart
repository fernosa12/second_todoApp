class Todo {
  final String id;
  final String title;
  final String desc;
  final bool isCompleted;

  Todo(
      {required this.id,
      required this.title,
      required this.desc,
      this.isCompleted = false});
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'desc': desc, 'isCompleted': isCompleted};
  }

  factory Todo.fromMap(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        isCompleted: json['isCompleted']);
  }
}

List<Todo> dataTodo = [
  Todo(id: DateTime.now().toString(), title: '', desc: '')
];
