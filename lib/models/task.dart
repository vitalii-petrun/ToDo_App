///Simple task or todo element description.
class Task {
  ///Task's id.
  int? id;

  ///Task's title.
  String title = "no_title";

  ///Optional task's description.
  String? description;

  ///Task's status (done/undone).
  bool isDone = false;

  ///Title of group where the task is сontained.
  String? group;

  ///Creates task/todo instance with optional description field.
  Task({
    this.id,
    required this.title,
    this.description,
    required this.isDone,
    this.group,
  });

  ///Constructor receives data from DB and creates instance of this class.
  Task.fromMap(Map<String, Object?> map) {
    id = map["id"] as int;
    title = map["title"] as String;
    description = map["description"] as String;
    isDone = map["isDone"] == 1; //TODO: try as bool
    group = map["group"] as String;
  }

  ///Creating map to transfer to DB.
  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone == true ? 1 : 0,
    };

    return map;
  }

  ///Method whis is used to update task's id after inserting to DB.
  Task copy({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    String? group,
  }) =>
      Task(
        id: id ?? this.id,
        isDone: isDone ?? this.isDone,
        title: title ?? this.title,
        description: description ?? this.description,
        group: group ?? this.group,
      );
}

///Fields of Task Model which represent table's columns in DB.
class TaskFields {
  ///List of fields which represent columns in DB.
  static final List<String> values = [id, title, description, isDone, group];

  ///ID column.
  static const String id = 'id';

  ///Title column.
  static const String title = 'title';

  ///Description column.
  static const String description = 'description';

  ///Task's status(one/undone) column.
  static const String isDone = 'isDone';

  ///Group in which task is saved.
  static const String group = 'group';
}
