import 'package:flutter/material.dart';
import 'package:gdc_todolist/common/extension.dart';

import '../common/app_colors.dart';
import '../event/events.dart';
import '../model/todo.dart';
import '../services/todo_service.dart';
import '../widget/slide_able_todo.dart';

class DoneListPage extends StatefulWidget {
  const DoneListPage({super.key});

  @override
  State<StatefulWidget> createState() => _DoneListPage();
}

class _DoneListPage extends State<DoneListPage> {
  List<Todo> todos = [];

  bool _loading = false;

  @override
  void initState() {
    Future.microtask(() => menuIndexNotifier.addListener(() {
          if (menuIndexNotifier.value != 2) return;
          fetchTodos();
        }));

    super.initState();
  }

  @override
  Future<void> fetchTodos() async {
    if (_loading) return;
    setState(() {
      _loading = true;
    });
    print('fetch completed task');
    var todoData = await TodoService().getTodosByStatus(TodoStatus.DONE);
    if (todoData!.isNotEmpty) {
      setState(() {
        todos = todoData;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColors.background(),
        body: Container(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todos[index];
                return SlideAbleTodoCard(
                    todo: todo,
                    onClickEdit: (todo) async {
                      print('editing${todo.title}');
                      final updated = await context.editTodoDialog(todo);
                      if (updated != null) {
                        fetchTodos();
                      }
                    },
                    onUpdated: () {
                      fetchTodos();
                    });
              },
            )));
  }
}

void doNothing(BuildContext context) {}
