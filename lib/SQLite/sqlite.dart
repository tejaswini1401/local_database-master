import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:local_database/JsonModels/users.dart';

class DatabaseHelper {
  final databaseName = "mannnu.db";

  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(users);
    });
  }

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    // print(user.usrId);

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    print(user.usrName);
    print(user.usrPassword);
    return db.insert('users', user.toMap());
  }
}
