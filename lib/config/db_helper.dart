// ignore_for_file: constant_identifier_names

import 'package:codehero/app/profile/domain/models/profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pathProvider;
import 'dart:io' as io;

final dbHelper = DbHelper();

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = pathProvider.join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID TEXT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");
  }

  Future<Profile> saveData(Profile user) async {
    try {
      var dbClient = await db;
      await dbClient.insert(Table_User, user.toMap());
      return user;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Profile?> getLoginUser(String email, String password) async {
    try {
      var dbClient = await db;
      var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
          "$C_Email = '$email' AND "
          "$C_Password = '$password'");

      if (res.isNotEmpty) {
        return Profile.fromMap(res.first);
      }

      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
