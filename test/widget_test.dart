import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zimlaw_ai/main.dart';

void main() {
  testWidgets('App boots and shows ZimLaw AI title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ZimLawApp(),
      ),
    );

    expect(find.text('ZimLaw AI'), findsOneWidget);
  });
}