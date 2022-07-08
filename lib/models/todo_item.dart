class TodoItem {
  int? id;
  String? name;
  bool? done;

  static final createTableQuery = '''
    CREATE TABLE IF NOT EXISTS TodoItem ( 
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      done BOOLEAN NOT NULL
    )
  ''';

  TodoItem({
    this.id,
    required this.name,
  }) : done = false;

  TodoItem.fromJson(Map json) {
    /* Alternative: named constructor */
    id = json['id'];
    name = json['name'];
    done = json['done'] == 0 ? false : true;
  }

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'name': name,
      'done': done,
    };
  }

  String toString() {
    return 'Todo name: $name done: $done';
  }
}
