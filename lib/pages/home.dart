import 'package:flutter/material.dart';
import 'package:gdc_todolist/common/app_colors.dart';
import 'package:gdc_todolist/common/extension.dart';
import 'package:gdc_todolist/widget/slide_able_todo.dart';

import '../event/events.dart';
import '../model/todo.dart';
import '../services/todo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Todo> todos = [];

  bool _loading = false;

  @override
  void initState() {
    Future.microtask(() => menuIndexNotifier.addListener(() {
          if (menuIndexNotifier.value != 0 || _loading == true) return;
          fetchTodos();
        }));

    Future.microtask(() => menuIndexNotifier.addListener(() {
          if (!updateItemsNotifier.value || _loading == true) return;
          print('notify update');
          fetchTodos();
          updateItemsNotifier.value = false;
        }));

    Future.delayed(Duration.zero, () async {
      fetchTodos();
    });
  }

  Future<void> fetchTodos() async {
    if (_loading == true) return;
    _loading = true;
    var todoData = await TodoService().getTodosByStatus(TodoStatus.NEW);
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
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todos[index];
                return Container(
                    margin: EdgeInsets.only(
                        bottom: index == (todos.length - 1) ? 40 : 5,
                        top: index == 0 ? 10 : 0),
                    child: SlideAbleTodoCard(
                      todo: todo,
                      onClickEdit: (todo) async {
                        final updated = await context.editTodoDialog(todo);
                        if (updated) {
                          fetchTodos();
                        }
                      },
                      onUpdated: () {
                        fetchTodos();
                      },
                    ));
              },
            )));
  }
}
