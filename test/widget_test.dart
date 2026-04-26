import 'package:flutter_test/flutter_test.dart';

import 'package:untitled6/main.dart';

void main() {
  testWidgets('renders HTTP Cat Browser home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('HTTP Cat Browser'), findsOneWidget);
    expect(find.text('Load Cat'), findsOneWidget);
  });
}
