///Simple task or todo element description.
class Task {
  ///Task's id.
  int id = 0;

  ///Task's title.
  String title = 'task title';

  ///Optional task's description.
  String? description;

  ///Task's status (done/undone).
  bool isDone = false;

  ///Creates task/todo instance with optional description field.
  Task({
    required this.id,
    required this.title,
    this.description,
    required this.isDone,
  });

}
