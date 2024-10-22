import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:examen2p/main.dart';

void main() {
  testWidgets('Prueba de inicio de sesión', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(TextField), findsNWidgets(2)); 
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'pepe');
    await tester.enterText(find.byType(TextField).at(1), '1234');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); 

    expect(find.text('Detalles del usuario'), findsOneWidget);
  });
}
