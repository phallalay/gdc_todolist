import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../common/app_colors.dart';
import '../model/todo.dart';
import '../services/todo_service.dart';

class SlideAbleTodoCard extends StatelessWidget {
  final Todo todo;

  final Function(Todo todo) onClickEdit;
  final Function()? onUpdated;

  const SlideAbleTodoCard(
      {super.key,
      required this.todo,
      required this.onClickEdit,
      this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final shortDateFormat = DateFormat('MMM dd, yyyy HH:mm');
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          const snackBar = SnackBar(
            content: Text("Task has been deleted!"),
          );
          TodoService().delete(int.parse(todo.id.toString()));
          onUpdated!();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () async {
          var snackBar = const SnackBar(
            content: Text("Task is completed"),
          );
          String timeStamp = DateTime.now().toIso8601String();
          var newStatus = TodoStatus.DONE;
          if (todo.status == TodoStatus.DONE) {
            newStatus = TodoStatus.NEW;
            snackBar =
                const SnackBar(content: Text("Task moved to un complete"));
          }
          todo.status = newStatus;
          final updateTodo =
              todo.copyWith(status: newStatus, updatedAt: timeStamp);
          final updated = await TodoService().updateTodo(updateTodo);
          if (updated != null) {
            onUpdated!();
          }
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }),
        children: [
          todo.status == TodoStatus.DONE
              ? const SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.check_box_outline_blank,
                  label: "Not Complete",
                )
              : const SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.check_box,
                  label: "Complete",
                ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                right: todo.status == TodoStatus.DONE
                    ? const BorderSide(width: 5, color: Colors.blueAccent)
                    : const BorderSide(width: 5, color: Colors.green),
                left: const BorderSide(width: 2, color: Colors.redAccent))),
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
                  color: Colors.blueAccent,
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
                        : const SizedBox()),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
