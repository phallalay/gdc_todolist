import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../services/todo_service.dart';
import 'app_colors.dart';

extension BuildContextExtension on BuildContext {
  Future<bool> editTodoDialog(Todo todo) async {
    TextEditingController todoTitleController = TextEditingController();
    TextEditingController toDescriptionController = TextEditingController();

    double width = MediaQuery.of(this).size.width;

    final dialogWidth = width > 340.0 ? 340.0 : width - 20;

    todoTitleController.text = todo.title.toString();
    toDescriptionController.text = todo.description.toString();

    AlertDialog dialog = AlertDialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        titlePadding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 30),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Todo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Container(
            width: dialogWidth,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Title'),
                  CupertinoTextField(
                    controller: todoTitleController,
                    placeholder: 'Todo...',
                  ),
                  const SizedBox(height: 10),
                  const Text('Description'),
                  CupertinoTextField(
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 4,
                    controller: toDescriptionController,
                    placeholder: '',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(this, false);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.white),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                appColors.primary())),
                        child: const Text('Update'),
                        onPressed: () async {
                          String timeStamp = DateTime.now().toIso8601String();
                          final updateToto = todo.copyWith(
                              title: todoTitleController.text,
                              description: toDescriptionController.text,
                              updatedAt: timeStamp);
                          final updatedTodo =
                              await TodoService().updateTodo(updateToto);

                          if (updatedTodo != null) {
                            const snackBar = SnackBar(
                              content: Text("Todo updated"),
                            );

                            ScaffoldMessenger.of(this).showSnackBar(snackBar);
                            Navigator.pop(this, true);
                          }
                        },
                      ),
                    ],
                  ),
                ])));
    return await showDialog(
      context: this,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
