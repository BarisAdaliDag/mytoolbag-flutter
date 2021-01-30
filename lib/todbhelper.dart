import 'package:mytoolbag/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internalize();
  String tbTodo = "todo";
  String colId = "id";
  String colSubject = "subject";
  String colBody = "body";

  String colDate = "date";

  DbHelper._internalize();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tbTodo($colId INTEGER PRIMARY KEY, $colSubject TEXT," +
            "$colBody TEXT,  $colDate TEXT" +
            ")");
  }

  Future<int> insertTodoList(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tbTodo, todo.toMap());
    return result;
  }

  Future<List> getTodoLists() async {
    List<Todo> todoList = [];
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tbTodo ");
    result.forEach((element) {
      todoList.add(Todo.fromObject(element));
    });
    return todoList;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tbTodo"));

    return result;
  }

  Future<int> updateTodoList(Todo todo) async {
    Database db = await this.db;
    var result = await db.update(tbTodo, todo.toMap(),
        where: "$colId = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodoList(int id) async {
    Database db = await this.db;
    var result = await db.delete(tbTodo, where: "$colId = ?", whereArgs: [id]);
    return result;
  }
}
