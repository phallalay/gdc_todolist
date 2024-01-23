import 'package:flutter/material.dart';
import 'package:gdc_todolist/common/app_colors.dart';
import 'package:intl/intl.dart';

import '../model/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  final Function(Todo todo) onClickEdit;

  const TodoCard({super.key, required this.todo, required this.onClickEdit});

  @override
  Widget build(BuildContext context) {
    final shortDateFormat = DateFormat('MMM dd, yyyy HH:mm');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            //tileColor: Colors.blueAccent,
            leading: todo.status?.index == TodoStatus.DONE.index
                ? const Icon(Icons.check_box, color: Colors.green)
                : const Icon(
                    Icons.radio_button_off,
                    color: Colors.grey,
                  ),
            title: Text(
              todo.title.toString(),
              style: TextStyle(
                  color: appColors.primary(), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(todo.description.toString()),
            trailing: InkWell(
              onTap: () {
                onClickEdit(todo);
              },
              child: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: todo.createdAt != null
                      ? Text(
                          shortDateFormat.format(
                              DateTime.parse(todo.createdAt.toString())),
                          style: const TextStyle(fontSize: 12),
                        )
                      : SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
