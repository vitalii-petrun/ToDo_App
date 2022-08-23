///Group description.
class Group {
  ///Group's id.
  int? id;

  ///Group's title.
  String title = "no_title";

  ///Group constructor.
  Group({
    this.id,
    required this.title,
  });

  ///Constructor receives data from DB and creates instance of this class.
  Group.fromMap(Map<String, Object?> map) {
    id = map["id"] as int;
    title = map["title"] as String;
  }

  ///Creating map to transfer to DB.
  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      "id": id,
      "title": title,
    };

    return map;
  }

  ///Method whis is used to update Group's id after inserting to DB.
  Group copy({
    int? id,
    String? title,
  }) =>
      Group(
        id: id ?? this.id,
        title: title ?? this.title,
      );
}

///Fields of Group Model which represent table's columns in DB.
class GroupFields {
  ///List of fields which represent columns in DB.
  static final List<String> values = [
    id,
    title,
  ];

  ///ID column.
  static const String id = 'id';

  ///Title column.
  static const String title = 'title';
}
///Name of table for groups.
const String groupTableName = "groups";
