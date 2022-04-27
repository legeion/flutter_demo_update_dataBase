class HistoryDB {
  /* ///Courses table V1
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
  } */

  /**
   * Les constructeurs de la base de donnée en fonction de l'évolution de l'application
   */

  /// YZE
  static const initScripts1 = [
    // Table 1
    '''
          create table courses(
            id integer primary key autoincrement,
            name varchar(50), 
            content varchar(255),
            hours integer
            )
      ''',
    // Table 1
    '''
          create table student(
            id integer primary key autoincrement,
            name varchar(50)
            )
      '''
  ];

  ///version db: exploité lors de la tout premiere création de l'application
  List<String> contructorDataBaseInit() {
    const initScript = [
      '''
          create table courses(
            id integer primary key autoincrement,
            name varchar(50), 
            content varchar(255),
            hours integer
            )
      ''',
      '''
          create table student(
            id integer primary key autoincrement,
            name varchar(50)
            )
      '''
    ];
    return initScript;
  }

  ///Cette fonction est exploité lors de la mise en place du premier versionnage de la base de donnée
  List<String> contructorDataBaseUpdate() {
    const migrationScripts = [
      '''
        alter table courses add column level varchar(50)
      ''',
      '''
          create table classe(
            id integer primary key autoincrement,
            name varchar(50),
            average integer
            )
      ''',
      '''
          create table note(
            id integer primary key autoincrement,
            note integer
            )
      ''',
    ];
    return migrationScripts;
  }
}
