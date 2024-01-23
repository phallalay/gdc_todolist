import 'package:flutter_test/flutter_test.dart';
import 'package:gdc_todolist/constants/create_dotos_table.dart';
import 'package:gdc_todolist/model/todo.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_test.mocks.dart';

void main() {
  late Database database;
  late MockTodoService todoService;

  String currentTime = DateTime.now().toIso8601String();

  Todo todo = Todo(
      title: "First ",
      status: TodoStatus.NEW,
      description: "Fist todo",
      createdAt: currentTime,
      updatedAt: currentTime);
  List<Todo> todoList = List.generate(10, (index) => todo);
  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute(Constants.CREATE_TODOS_TABLE);
    todoService = MockTodoService();
    todoService.db = database;
    when(todoService.insertTodo(any)).thenAnswer((_) async => todo);
    when(todoService.updateTodo(any)).thenAnswer((_) async => todo);
    when(todoService.delete(any)).thenAnswer((_) async => 1);
    when(todoService.getTodo(any)).thenAnswer((_) async => todo);
    when(todoService.getTodos()).thenAnswer((_) async => todoList);
  });

  group('Todo Service', () {
    test('Add todo', () async {
      verifyNever(todoService.insertTodo(todo));
      expect(await todoService.insertTodo(todo), todo);
      verify(todoService.insertTodo(todo)).called(1);
    });
    test('Update todo', () async {
      verifyNever(todoService.updateTodo(todo));
      expect(await todoService.updateTodo(todo), todo);
      verify(todoService.updateTodo(todo)).called(1);
    });
    test('Delete todo', () async {
      verifyNever(todoService.delete(1));
      expect(await todoService.delete(1), 1);
      verify(todoService.delete(1)).called(1);
    });
    test('Get all todos', () async {
      verifyNever(todoService.getTodos());
      expect(await todoService.getTodos(), todoList);
      verify(todoService.getTodos()).called(1);
    });
  });
}
