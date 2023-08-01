import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class UserDataHelper{

  /// database name and version
  static const _databaseName = "userData.db";
  static const _databaseVersion = 1;

  /// model class variables
  static const listTable = "userDataListTable";
  static const colId = "colId";
  static const colUsername = "colUsername";
  static const colUserEmail = "colUserEmail";
  static const colPassword = "colPassword";

  /// database constructor
  UserDataHelper._privateConstructor();
  static final UserDataHelper instance = UserDataHelper._privateConstructor();
  static Database? _database;

  ///checking and creating database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeUserData();
    return _database!;
  }

  /// initialize database
  Future<Database> initializeUserData() async{
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _createDb);
  }

  /// close database
  Future close() async{
    final db = await database;
    _database = null;
    return db.close();
  }

  /// create database
  void _createDb(Database db, int newVersion) async{
    await db.execute(
        '''CREATE TABLE $listTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colUsername TEXT,
        $colUserEmail TEXT,
        $colPassword TEXT)''');
  }

  /// ******************************* [ QUERIES TO PERFORM ] ****************************

  // insert data
  Future<int> insertUserData(Map<String, dynamic> row) async{
    Database db = await instance.database;
    var result = await db.insert(listTable, row);
    return result;
  }

  // retrieve all data
  Future<List<Map<String, dynamic>>> queryAllUserData() async{
    Database db = await instance.database;
    return await db.query(listTable);
  }

  // query only 1 data by their id
  Future<List<Map<String, dynamic>>> queryOneUserData(int id) async{
    Database db = await instance.database;
    return await db.query(listTable, where: "$colId = ?", whereArgs: [id]);
  }

  // update data by their id
  Future<int> updateUserData(Map<String, dynamic> row, int id) async{
    Database db = await instance.database;
    return await db.update(listTable, row, where: "$colId = ?", whereArgs: [id]);
  }

}