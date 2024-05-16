import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();

  factory LocalDatabaseHelper() {
    return _instance;
  }

  LocalDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init();
      return _database!;
    }
  }

  Future<Database> _init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'game_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS GameData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        moves INTEGER,
        timer INTEGER
      )
    ''');
  }

  Future<void> saveGameData(int moves, int timer) async {
    final Database db = await database;
    await db.transaction((txn) async {
      await txn.insert('GameData', {
        'moves': moves,
        'timer': timer,
      });
    });
  }
  Future<void> getRecord(int moves, ) async {
    final Database db = await database;
    await db.transaction((txn) async {
      await txn.insert('GameData', {
        'moves': moves,

      });
    });
  }

  Future<List<Map<String, dynamic>>> getAllGameData() async {
    final Database db = await database;
      String orderBy = "moves ASC";

    return await db.query('GameData',orderBy: orderBy );
  }

  Future<List<Map<String, dynamic>>> getGameDataWithMinMoves() async {
    final Database db = await database;
    String orderBy = "moves DESC";

    return await db.query('GameData', orderBy: orderBy, limit: 1);
  }
  Future<List<Map<String, dynamic>>> getGameDataWithMinTime() async {
    final Database db = await database;
    String orderBy = "timer DESC";

    return await db.query('GameData', orderBy: orderBy, limit: 1);
  }
//ASC
//DESC


}



class GameData {
  final int? id;
  final int moves;
  final int timer;


  GameData( {this.id, required this.moves, required this.timer, });

  factory GameData.fromMap(Map<String, dynamic> map) {
    return GameData(
      id: map['id'],
      moves: map['moves'],
      timer: map['timer'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moves': moves,
      'timer': timer,

    };
  }
}
