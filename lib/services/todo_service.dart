import 'package:gdc_todolist/services/db_serivice.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';

class TodoService {
  late Database db;
  final tableName = 'todos';

  Future<Todo?> insertTodo(Todo todo) async {
    db = (await DBService().database)!;

    todo.id = await db.insert(tableName, todo.toMap());
    return todo;
  }

  Future<Todo> updateTodo(Todo todo) async {
    db = (await DBService().database)!;

    todo.id = await db
        .update(tableName, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
    return todo;
  }

  Future<List<Todo>>? getTodos() async {
    db = (await DBService().database)!;

    List<Todo>? todos = <Todo>[];

    final List<Map<String, dynamic>> todoData =
        await db.query(tableName, orderBy: 'updated_at DESC');

    if (todoData.isNotEmpty) {
      todos = List<Todo>.from(todoData.map((i) => Todo.fromDB(i)));
    }

    return todos;
  }

  Future<List<Todo>>? getTodosByStatus(TodoStatus status) async {
    db = (await DBService().database)!;

    List<Todo>? todos = <Todo>[];

    final List<Map<String, dynamic>> todoData = await db.query(tableName,
        orderBy: 'updated_at DESC',
        where: 'status = ?',
        whereArgs: [status.index]);

    if (todoData.isNotEmpty) {
      todos = List<Todo>.from(todoData.map((i) => Todo.fromDB(i)));
    }

    return todos;
  }

  Future<Todo?> getTodo(int id) async {
    db = (await DBService().database)!;

    final List<Map<String, Object?>> todoData =
        await db.query(tableName, where: '$id = ?', whereArgs: [id]);
    if (todoData.isNotEmpty) {
      return Todo.fromDB(todoData.first);
    }
    return null;
  }

  Future<int?> delete(int id) async {
    db = (await DBService().database)!;

    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
