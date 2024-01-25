import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gdc_todolist/main.dart';
import 'package:gdc_todolist/pages/home.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End to end test', () {
    testWidgets('Create Todo Success', (widgetTester) async {
      //to_do_app.main();
      await widgetTester.pumpWidget(const MyApp());
      await widgetTester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byKey(const Key('create_todo')));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byKey(const Key('todo_title')), "My todo title");
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byKey(const Key('todo_description')), "Todo description");
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byType(ElevatedButton));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.text('My todo title'), findsOneWidget);
    });

    testWidgets('Create Todo Failed', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await widgetTester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byKey(const Key('create_todo')));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byKey(const Key('todo_description')), "Todo description");
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byType(ElevatedButton));
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.text("Todo title is required"), findsOneWidget);
    });

    testWidgets('Update First Todo Success', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await widgetTester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byKey(const Key('create_todo')));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byKey(const Key('todo_title')), "My todo title");
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byKey(const Key('todo_description')), "Todo description");
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byType(ElevatedButton));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byType(InkWell).at(1));
      await Future.delayed(const Duration(seconds: 2));

      await widgetTester.enterText(
          find.byKey(const Key('update_todo_title')), "My updated title");
      await Future.delayed(const Duration(seconds: 5));
      await widgetTester.enterText(
          find.byKey(const Key('update_todo_description')),
          "My updated description");
      await Future.delayed(const Duration(seconds: 5));
      await widgetTester.tap(find.byType(ElevatedButton));
      await Future.delayed(const Duration(seconds: 5));
      await widgetTester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.text("Todo updated"), findsOneWidget);
    });
  });
}
