import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lab5/main.dart' as app;
import 'package:lab5/home.dart';
import 'package:lab5/setting.dart';
import 'package:lab5/user.dart';
import 'package:lab5/new_user.dart';
import 'package:lab5/signin.dart';
import 'package:lab5/activate.dart';


void main(){
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("full app test", (tester) async {
      app.main();
      await tester.pumpAndSettle();




    });
  });
}
