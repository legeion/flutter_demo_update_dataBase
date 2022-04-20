import 'package:sqflite/sqflite.dart';

class HistoryDB {
  ///Courses table V1
  /// Exploité dans la version db:
  Future<void> _tableCoursesV1(Database db) async {
    await db.execute(
        'create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), hours integer)');
  }

  /// Update Courses table V1 to V2
  /// Exploité dans la version db:
  Future<void> _updateTableCoursesV1toV2(Database db) async {
    await db.execute("alter table courses add column level varchar(50) ");
  }

  /// Create Classe table V1
  /// Exploité dans la version db:
  Future<void> _createTableClasseV2(Database db) async {
    await db.execute('''create table classe(
      id integer primary key autoincrement,
      name varchar(50),
      average integer)''');
  }

  /// Update Courses table V2 to V3
  /// Exploité dans la version db:
  Future<void> _updateTableCoursesV2toV3(Database db) async {
    await db.execute("alter table courses add column level integer ");
  }

  /**
   * Les constructeurs de la base de donnée en fonction de l'évolution de l'application
   */

  ///Cette fonction est exploité lors de la mise en place du premier versionnage de la base de donnée
  ///version db:
  Future<int> contructorDataBaseV1(Database db) async {
    int response = 0;
    await _tableCoursesV1(db);
    response = 1;
    return response;
  }

  ///Cette fonction est exploité lors de la mise en place du deuxième versionnage de la base de donnée
  ///version db:
  Future<int> contructorDataBaseV2(Database db) async {
    int response = 0;
    await _updateTableCoursesV1toV2(db);
    response = 2;
    return response;
  }

  ///Cette fonction est exploité lors de la mise en place du troixième versionnage de la base de donnée
  ///version db:
  Future<int> contructorDataBaseV3(Database db) async {
    int response = 0;
    await _updateTableCoursesV2toV3(db);
    await _createTableClasseV2(db);
    response = 3;
    return response;
  }

  ///Cette fonction permet de faire la migration d'une version vieu de la base de donnée vers la version récente
  Future<int> constructorMigrationProgressive(
      int versionDBClient, Database db) async {
    int response = 0;
    switch (versionDBClient) {
      case 2:
        response = await contructorDataBaseV2(db);
        break;
      case 3:
        response = await contructorDataBaseV3(db);
        break;
      default:
        response = 0;
    }
    return response;
  }
}
