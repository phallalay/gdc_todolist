enum TodoStatus { NEW, DOING, DONE }

class Todo {
  int? id;
  String? title;
  String? description;
  TodoStatus? status;
  String? createdAt;
  String? updatedAt;

  Todo(
      {this.id,
      required this.title,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status?.index,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  Todo.fromDB(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    description = data['description'];
    status = TodoStatus.values[data['status']];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }

  Todo copyWith(
      {int? id,
      String? title,
      String? description,
      TodoStatus? status,
      String? createdAt,
      String? updatedAt}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
