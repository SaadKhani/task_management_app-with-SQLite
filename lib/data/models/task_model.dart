class Task {
  final int? id;
  final String title;
  final bool isCompleted;
  final int userId;

  Task({
    this.id,
    required this.title,
    required this.isCompleted,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'isCompleted': isCompleted ? 1 : 0,
    'userId': userId,
  };

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
      userId: map['userId'],
    );
  }
}
