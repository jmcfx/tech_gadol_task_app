import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/error_state_widget.dart';

void main() {
  Widget createWidget({
    String message = 'Something failed',
    VoidCallback? onRetry,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ErrorStateWidget(message: message, onRetry: onRetry ?? () {}),
      ),
    );
  }

  group('ErrorStateWidget', () {
    testWidgets('renders error message', (tester) async {
      await tester.pumpWidget(createWidget(message: 'Network error'));
      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('renders "Something went wrong" title', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('renders retry button with "Try Again" text', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('calls onRetry when retry button is tapped', (tester) async {
      var retried = false;
      await tester.pumpWidget(createWidget(onRetry: () => retried = true));
      await tester.tap(find.text('Try Again'));
      expect(retried, isTrue);
    });

    testWidgets('displays error icon', (tester) async {
      await tester.pumpWidget(createWidget());
      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    });
  });
}
