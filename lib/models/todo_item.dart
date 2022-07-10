class TodoItem {
  int? id;
  late String name;
  late int done;

  static final createTableQuery = '''
    CREATE TABLE IF NOT EXISTS TodoItem ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      done BOOLEAN NOT NULL
    )
  ''';

  static final table = 'TodoItem';

  TodoItem({
    this.id,
    required this.name,
  }) : done = 0;

  TodoItem.fromDB({
    this.id,
    required this.name,
    required this.done
  });

  TodoItem.fromJson(Map json) {
    /* Alternative: named constructor */
    id = json['id'];
    name = json['name'];
    done = json['done'];
  }

    TodoItem copy({
    int? id,
    String? name,
    int? done,
  }) =>
      TodoItem.fromDB(
        id: id ?? this.id,
        name: name ?? this.name,
        done: done ?? this.done,
      );


    int get getId => id!;

    String get getName => name;

    int get getDone => done;

   set setDone(int value){
    done = value;
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'done': done,
    };
  }

  String toString() {
    return '_id $id Todo name: $name done: $done';
  }

}
