import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gdc_todolist/model/todo.dart';
import 'package:gdc_todolist/widget/slide_able_todo.dart';

void main() {
  group('Todo Card', () {
    testWidgets('New todo card', (widgetTester) async {
      String currentTime = DateTime.now().toIso8601String();
      final todo = Todo(
          title: "First Todo",
          status: TodoStatus.NEW,
          description: "Fist todo description",
          createdAt: currentTime,
          updatedAt: currentTime);

      await widgetTester.pumpWidget(
          WidgetTestingDirectory(todo: todo, onClickEdit: (todo) async {}));

      final title = find.text('First Todo');
      final description = find.text('Fist todo description');
      final statusIcon = find.byIcon(Icons.radio_button_off);

      expect(title, findsOneWidget);
      expect(description, findsOneWidget);
      expect(statusIcon, findsOneWidget);
    });

    testWidgets('Completed todo card', (widgetTester) async {
      String currentTime = DateTime.now().toIso8601String();
      final todo = Todo(
          title: "My Completed Todo",
          status: TodoStatus.DONE,
          description: "Fist todo description",
          createdAt: currentTime,
          updatedAt: currentTime);

      await widgetTester.pumpWidget(
          WidgetTestingDirectory(todo: todo, onClickEdit: (todo) async {}));

      expect(find.text('My Completed Todo'), findsOneWidget);
      expect(find.text('Fist todo description'), findsOneWidget);
      expect(find.byIcon(Icons.check_box), findsOneWidget);
    });
  });
}

class WidgetTestingDirectory extends StatelessWidget {
  final Todo todo;
  final Function(Todo todo) onClickEdit;

  const WidgetTestingDirectory(
      {super.key, required this.todo, required this.onClickEdit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Testing Wrapper'),
        ),
        body: Center(
          child: SlideAbleTodoCard(
            todo: todo,
            onClickEdit: (Todo todo) {
              onClickEdit(todo);
            },
          ),
        ),
      ),
    );
  }
}
