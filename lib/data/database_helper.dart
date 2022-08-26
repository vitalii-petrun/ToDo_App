import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task.dart';

///Work with SQLite database.
///
///Creating DB and needed tables.
class DatabaseHelper {
  ///Global instance of this class.
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  ///Connection with our database.
  Future<Database> get database async {
    if (_database != null) return _database as Database;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'eee.db');

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database as Database;
  }

  ///Private constructor.
  DatabaseHelper._init();

  Future _createDB(Database db, int _) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNull = 'TEXT';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute(
      '''
CREATE TABLE $taskTableName ( 
  ${TaskFields.id} $idType, 
  ${TaskFields.title} $textType,
  ${TaskFields.description} $textTypeNull,
  ${TaskFields.isDone} $boolType,
  ${TaskFields.taskGroup} $textTypeNull
)''',
    );
    await db.execute(
      '''
            CREATE TABLE $groupTableName (
              ${GroupFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${GroupFields.title} TEXT
            )
          ''',
    );
    //Default group "My tasks".
    await db.insert(groupTableName, Group(id: 0, title: "My Tasks").toMap());
  }

  ///Method which closes DB.
  Future close() async {
    final db = await instance.database;

    await db.close();
  }
}
