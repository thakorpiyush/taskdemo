class TaskModel {
  final int? id;
  final String? title;
  final String? description;
  final String? status;
  final String? createdAt;

  TaskModel(
      {this.id, this.title, this.description, this.status, this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        status: map['status'],
        createdAt: map['createdAt']);
  }
}

