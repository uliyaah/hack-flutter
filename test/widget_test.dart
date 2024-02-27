// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hackflutter/main.dart';

void main() {
  testWidgets('TaskListScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TaskListApp());

    // Verify that our task list screen has a title.
    expect(find.text('Task List'), findsOneWidget);

    // Verify that our task list screen starts with an empty list of tasks.
    expect(find.byType(ListTile), findsNothing);

    // Tap on the floating action button to add a new task.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify that the add task dialog is displayed.
    expect(find.byType(AddTaskDialog), findsOneWidget);

    // Enter task details into the add task dialog and tap "Add".
    await tester.enterText(find.byKey(Key('titleField')), 'New Task');
    await tester.enterText(find.byKey(Key('descriptionField')), 'New Task Description');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify that the new task is added to the task list.
    expect(find.text('New Task'), findsOneWidget);
    expect(find.text('New Task Description'), findsOneWidget);
  });
}
