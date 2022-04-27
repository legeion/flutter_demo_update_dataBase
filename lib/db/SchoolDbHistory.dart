/// dbHistory
/// Classe d'historisation du cycle de vie de la BDD `school.db`.
///
/// Cette classe va contenir les instructions Sql de création (init)
/// de la BDD ainsi que les instructions de mise à jour au fil des
/// versions
///
/// La notion de versionning des modification est portée par la
/// constante de classe `migrationScripts`.
class SchoolDbHistory {
  static final String dbName = "school.db";

  static const initScripts = [
    // Table courses
    '''
      create table courses(
      id integer primary key autoincrement,
      name varchar(50), 
      content varchar(255),
      hours integer
      )
    ''',
    // Table student
    '''
      create table student(
        id integer primary key autoincrement,
        name varchar(50)
        )
    '''
  ];

  static const migrationScripts = [
    // Modification x ...
    '''
      alter table courses add column level varchar(50)
    ''',

    // Modification liée au passage en version v1.0.1
    '''
      create table classe(
        id integer primary key autoincrement,
        name varchar(50),
        average integer
        )
    ''',

    // Modification z ...
    '''
      create table note(
        id integer primary key autoincrement,
        note integer
        )
    ''',
  ];
}
