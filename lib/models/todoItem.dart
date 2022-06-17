class TodoItem {
  final int? id;
  final String name;
  final bool done = false;

  const TodoItem({
    this.id,
    required this.name,
  });

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'name': name,
      'done': done,
    };
  }

}
