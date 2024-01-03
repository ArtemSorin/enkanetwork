import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDatabase {
  static final FavoriteDatabase instance = FavoriteDatabase._init();

  static Database? _database;

  FavoriteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Favorites(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        server TEXT,
        timestamp TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await instance.database;
    return await db.query('Favorites');
  }

  Future<int> addNewFavorite({
    required String title,
    required String server,
    required String timestamp,
  }) async {
    final db = await instance.database;
    return await db.insert('Favorites', {
      'title': title,
      'server': server,
      'timestamp': timestamp,
    });
  }

  Future<int> updateFavorite({
    required int id,
    required String title,
    required String server,
    required String timestamp,
  }) async {
    final db = await instance.database;
    return await db.update(
        'Favorites',
        {
          'title': title,
          'server': server,
          'timestamp': timestamp,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<int> deleteFavorite({
    required int id,
  }) async {
    final db = await instance.database;
    return await db.delete('Favorites', where: 'id = ?', whereArgs: [id]);
  }
}
