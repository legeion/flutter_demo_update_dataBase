import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/course.dart';
import 'HistoryDb.dart';

class DataBaseApp {
  static final DataBaseApp _instance = DataBaseApp.internal();
  factory DataBaseApp() => _instance;

  DataBaseApp.internal();
  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'school.db');
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      //create tables
      await HistoryDB().contructorDataBaseV1(db);
      print("TODORO: creation de la base de donnée");
    }, onUpgrade: (Database db, int oldV, int newV) async {
      print('Version en cour:$oldV');
      print('Nouvelle version:$newV');
      if (oldV < newV && oldV + 1 == newV) {
        /// Migration normal: la version de l'application trouver sur le device à un numéro (n-1) de l'application qui veut être installer
        print('Migration normal');
        await HistoryDB().contructorDataBaseV3(db);
      } else {
        /// Migration progressive: la version de l'application trouver sur le device à un numéro (n-n') de l'application qui veut être installer
        print('Migration progressive:${oldV + 1}');
        await HistoryDB().constructorMigrationProgressive(oldV + 1, db);
      }
    });
    return _db;
  }

  Future<int> createCourse(Course course) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db.insert('courses', course.toMap());
  }

  Future<List> allCourses() async {
    Database db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db.query('courses');
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> courseUpdate(Course course) async {
    Database db = await createDatabase();
    return await db.update('courses', course.toMap(),
        where: 'id = ?', whereArgs: [course.id]);
  }
}
