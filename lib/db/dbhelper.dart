import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_demo_update_db/model/course.dart';
import 'package:flutter_demo_update_db/db/SchoolDbHistory.dart';

/// Classe singletone permettant d'ouvrir la connexion à la BDD et
/// de mettre à disposition une instance de la classe Database.
///
/// Cette classe expose par ailleurs des methodes de lecture/écriture
/// dans la BDD.
///
/// L'implémentation de cette classe est inspirée de billet :
/// [Migrating a mobile database in flutter (SQLite)](https://medium.com/flutter-community/migrating-a-mobile-database-in-flutter-sqlite-44ac618e4897)
class DataBaseApp {
  static Database _db;
  static final DataBaseApp _instance = DataBaseApp.internal();

  factory DataBaseApp() => _instance;

  DataBaseApp.internal();

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }

    // Definition du path (chemin) de la BDD
    String path = join(await getDatabasesPath(), SchoolDbHistory.dbName);

    // Création (Ouverture) de l'instance BDD
    _db = await openDatabase(path,
        version: SchoolDbHistory.migrationScripts.length,
        onCreate: (Database db, int version) async {
      if (SchoolDbHistory.migrationScripts.length == 1) {
        SchoolDbHistory.initScripts
            .forEach((script) async => await db.execute(script));
        print(
            "[DEBUG-TEST]: Creation/Initialisation de la BDD <${SchoolDbHistory.dbName}> !");
      } else {
        SchoolDbHistory.initScripts
            .forEach((script) async => await db.execute(script));
        print(
            "[DEBUG-TEST]: Creation/Initialisation de la BDD <${SchoolDbHistory.dbName}> !");
        for (var i = 0; i <= SchoolDbHistory.migrationScripts.length - 1; i++) {
          await db.execute(SchoolDbHistory.migrationScripts[i]);
        }
        print(
            "[DEBUG-TEST]: Creation/Migration de la BDD <${SchoolDbHistory.dbName}> !");
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      print(
          "[DEBUG-TEST]: Mise à jour de la BDD de la v$oldVersion vers la v$newVersion !");
      for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
        await db.execute(SchoolDbHistory.migrationScripts[i]);
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
    db.rawQuery('select * from courses');
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
