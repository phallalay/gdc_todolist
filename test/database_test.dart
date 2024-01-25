import 'package:flutter_test/flutter_test.dart';
import 'package:gdc_todolist/constants/create_dotos_table.dart';
import 'package:gdc_todolist/model/todo.dart';
import 'package:gdc_todolist/services/todo_service.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_test.mocks.dart';

@GenerateMocks([TodoService])
void main() {
  late Database database;
  late MockTodoService todoService;
  String currentTime = DateTime.now().toIso8601String();

  const todoTable = 'todos';

  Todo todo = Todo(
      title: "First ",
      status: TodoStatus.NEW,
      description: "Fist todo",
      createdAt: currentTime,
      updatedAt: currentTime);
  List<Todo> todoList = List.generate(3, (index) => todo);
  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute(Constants.CREATE_TODOS_TABLE);
  });

  group('Database Tests', () {
    test('sqflite version', () async {
      expect(await database.getVersion(), 0);
    });

    test('Insert Todo', () async {
      var firstTodo = await database.insert(
          todoTable,
          Todo(
                  title: 'Task 1',
                  description: 'Task Description',
                  status: TodoStatus.NEW,
                  createdAt: currentTime,
                  updatedAt: currentTime)
              .toMap());
      var resultTodo = await database.query('todos');
      print(resultTodo);
      expect(resultTodo.length, firstTodo);
    });
    test('Update First Todo', () async {
      database.update(
          todoTable,
          Todo(
                  id: 1,
                  title: 'Updated Task 1',
                  description: 'Task Description',
                  status: TodoStatus.NEW,
                  createdAt: currentTime,
                  updatedAt: currentTime)
              .toMap(),
          where: 'id = ?',
          whereArgs: [1]);

      var todos = await database.query(todoTable);
      expect(todos.first['title'], 'Updated Task 1');
    });
    test('Insert 3 more Todos', () async {
      await database.insert(
          todoTable,
          Todo(
                  title: 'Task 2',
                  description: 'Task 2 Description',
                  status: TodoStatus.NEW,
                  createdAt: currentTime,
                  updatedAt: currentTime)
              .toMap());
      await database.insert(
          todoTable,
          Todo(
                  title: 'Task 3',
                  description: 'Task 3 Description',
                  status: TodoStatus.NEW,
                  createdAt: currentTime,
                  updatedAt: currentTime)
              .toMap());
      await database.insert(
          todoTable,
          Todo(
                  title: 'Task 4',
                  description: 'Task 2 Description',
                  status: TodoStatus.NEW,
                  createdAt: currentTime,
                  updatedAt: currentTime)
              .toMap());
      var resultTodo = await database.query(todoTable);

      expect(resultTodo.length, 4);
    });
    test('Delete last todo', () async {
      database.delete(todoTable, where: 'id = ?', whereArgs: [4]);
      var todos = await database.query(todoTable);
      expect(todos.length, 3);
    });
    test('Close Database', () async {
      await database.close();
      expect(database.isOpen, false);
    });
  });
}
