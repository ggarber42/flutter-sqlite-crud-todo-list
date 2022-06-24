class TodoItem {
  int? id;
  String? name;
  bool done = false;

  TodoItem({
    this.id,
    required this.name,
  });

  TodoItem.fromJson(Map json){ /* Alternative: named constructor */
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

  String toString(){
    return 'Todo name: $name done: $done';
  }
}
