import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lab5/main.dart' as app;
import 'package:lab5/home.dart';
import 'package:lab5/home.dart' as home;
import 'package:lab5/setting.dart';
import 'package:lab5/setting.dart'as setting;
import 'package:lab5/user.dart';
import 'package:lab5/user.dart' as user;
import 'package:lab5/new_user.dart';
import 'package:lab5/signin.dart';
import 'package:lab5/activate.dart';


void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Test', () {
    testWidgets("normal flow test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "124290341");
      await Future.delayed(const Duration(seconds: 3));
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(ActivationScreen), findsOneWidget);

      await Future.delayed(const Duration(seconds: 3));
      await tester.enterText(find.byType(TextField), "123456");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      final factory1Card = find.byWidgetPredicate((widget) =>
      widget is home.FactoryCard && widget.title == 'Factory 1');
      final factory2Card = find.byWidgetPredicate((widget) =>
      widget is home.FactoryCard && widget.title == 'Factory 2');

      expect(factory2Card, findsOneWidget);

      await Future.delayed(const Duration(seconds: 5));
      await tester.drag(find.byType(ListView), const Offset(-1000.0, 0.0));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.drag(find.byType(ListView), const Offset(1000.0, 0.0));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byType(home.FactoryCard).at(0));
      await tester.pumpAndSettle();

      expect(factory1Card, findsOneWidget);

      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byIcon(Icons.settings).last);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), "29");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(find.byType(TextField).at(1), "22");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(find.byType(TextField).at(2), "53");
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(find.byType(TextField).at(3), "48");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.create));
      await tester.pumpAndSettle();
      expect(find.text('29'), findsOneWidget);
      expect(find.text('22'), findsOneWidget);
      expect(find.text('53'), findsOneWidget);
      expect(find.text('48'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      expect(find.byType(UserPage), findsOneWidget);

      final factory1Contact = find.byWidgetPredicate((widget) =>
      widget is user.FactoryCard && widget.title == 'Factory 1');
      final factory2Contact  = find.byWidgetPredicate((widget) =>
      widget is user.FactoryCard && widget.title == 'Factory 2');

      expect(factory1Contact , findsOneWidget);

      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byType(user.FactoryCard).at(1));
      await tester.pumpAndSettle();

      expect(factory2Contact , findsOneWidget);

      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byType(user.FactoryCard).at(0));
      await tester.pumpAndSettle();

      expect(factory1Contact , findsOneWidget);

      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.byType(InvitationPage), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), "BJ Khoo");
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5));
      await tester.enterText(find.byType(TextField).at(1), "124290341");
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(UserPage), findsOneWidget);

      await tester.drag(find.byType(ListView).at(0), const Offset(0, -500));
      await Future.delayed(const Duration(seconds: 5));
    });
  });
}
