import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend/main.dart';

void main() {
  testWidgets('Feed screen renders with title and FAB', (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());
    await tester.pumpAndSettle();

    expect(find.text('Discover Stories'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Shows snackbar on FAB tap (placeholder)', (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // start animation
    await tester.pump(const Duration(milliseconds: 300)); // show snackbar

    expect(find.text('Post story flow coming soon'), findsOneWidget);
  });
}
