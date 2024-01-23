// Mocks generated by Mockito 5.4.4 from annotations
// in gdc_todolist/test/database_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:gdc_todolist/model/todo.dart' as _i3;
import 'package:gdc_todolist/services/todo_service.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;
import 'package:sqflite/sqflite.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTodo_1 extends _i1.SmartFake implements _i3.Todo {
  _FakeTodo_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TodoService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoService extends _i1.Mock implements _i4.TodoService {
  MockTodoService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Database get db => (super.noSuchMethod(
        Invocation.getter(#db),
        returnValue: _FakeDatabase_0(
          this,
          Invocation.getter(#db),
        ),
      ) as _i2.Database);

  @override
  set db(_i2.Database? _db) => super.noSuchMethod(
        Invocation.setter(
          #db,
          _db,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get tableName => (super.noSuchMethod(
        Invocation.getter(#tableName),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.getter(#tableName),
        ),
      ) as String);

  @override
  _i6.Future<_i3.Todo?> insertTodo(_i3.Todo? todo) => (super.noSuchMethod(
        Invocation.method(
          #insertTodo,
          [todo],
        ),
        returnValue: _i6.Future<_i3.Todo?>.value(),
      ) as _i6.Future<_i3.Todo?>);

  @override
  _i6.Future<_i3.Todo> updateTodo(_i3.Todo? todo) => (super.noSuchMethod(
        Invocation.method(
          #updateTodo,
          [todo],
        ),
        returnValue: _i6.Future<_i3.Todo>.value(_FakeTodo_1(
          this,
          Invocation.method(
            #updateTodo,
            [todo],
          ),
        )),
      ) as _i6.Future<_i3.Todo>);

  @override
  _i6.Future<_i3.Todo?> getTodo(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTodo,
          [id],
        ),
        returnValue: _i6.Future<_i3.Todo?>.value(),
      ) as _i6.Future<_i3.Todo?>);

  @override
  _i6.Future<int?> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i6.Future<int?>.value(),
      ) as _i6.Future<int?>);
}