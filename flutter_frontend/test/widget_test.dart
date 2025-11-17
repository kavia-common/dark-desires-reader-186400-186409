import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_frontend/main.dart';
import 'package:flutter_frontend/data/dummy_stories.dart';

void main() {
  testWidgets('App builds with FeedScreen as home, shows title and FAB',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const AppRoot());
    // Let provider async init and AnimatedSwitcher settle
    await tester.pumpAndSettle();

    // Title from FeedScreen app bar area
    expect(find.text('Discover Stories'), findsOneWidget);

    // FloatingActionButton should be present
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('At least one StoryCard renders from dummy data',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());
    await tester.pumpAndSettle();

    // The feed shuffles dummyStories; assert presence by checking that at least
    // one of the known story contents is found in the widget tree.
    // We'll try several early items to reduce flakiness due to shuffle.
    final sampleContents = dummyStories.take(5).map((s) => s.content).toList();

    // true if any sample content is found
    final bool anyFound = sampleContents
        .any((content) => find.textContaining(content, findRichText: true).evaluate().isNotEmpty);

    expect(anyFound, isTrue,
        reason:
            'Expected at least one StoryCard with text from dummyStories to be present.');
  });

  testWidgets('Tapping FAB opens PostStoryDialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());
    await tester.pumpAndSettle();

    // Tap FAB to open the post dialog
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Dialog title should be visible
    expect(find.text('Post a story'), findsOneWidget);

    // Close dialog to avoid bleed into other tests
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });
}
