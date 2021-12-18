import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'user.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'userfive.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE userfive(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('userfive', user.toMap());
    }
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('userfive');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
}
