import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/blog.dart';

class BlogDatabase {
  static final BlogDatabase instance = BlogDatabase._init();

  static Database? _database;

  BlogDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('blogs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBlogs ( 
  ${BlogFields.id} $idType, 
  ${BlogFields.title} $textType,
  ${BlogFields.description} $textType,
  ${BlogFields.time} $textType
  )
''');
  }

  Future<Blog> create(Blog blog) async {
    final db = await instance.database;

    final id = await db.insert(tableBlogs, blog.toJson());
    return blog.copy(id: id);
  }

  Future<Blog> readBlog(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBlogs,
      columns: BlogFields.values,
      where: '${BlogFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Blog.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Blog>> readAllBlogs() async {
    final db = await instance.database;

    const orderBy = '${BlogFields.time} ASC';

    final result = await db.query(tableBlogs, orderBy: orderBy);

    return result.map((json) => Blog.fromJson(json)).toList();
  }

  Future<int> update(Blog blog) async {
    final db = await instance.database;

    return db.update(
      tableBlogs,
      blog.toJson(),
      where: '${BlogFields.id} = ?',
      whereArgs: [blog.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBlogs,
      where: '${BlogFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
