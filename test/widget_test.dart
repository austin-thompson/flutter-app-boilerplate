import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/screens/login_screen.dart';

void main() {
  testWidgets('LoginScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Ensure widgets are present
    expect(find.byKey(Key('usernameField')), findsOneWidget);
    expect(find.byKey(Key('passwordField')), findsOneWidget);
    expect(find.byKey(Key('loginButton')), findsOneWidget);
  });

  testWidgets('Login button triggers login logic', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Enter username and password
    await tester.enterText(find.byKey(Key('usernameField')), 'test');
    await tester.enterText(find.byKey(Key('passwordField')), 'test');

    // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Check if navigation occurred
    expect(find.text('Home Page'),
        findsOneWidget); // Replace this with the appropriate assertion
  });

  testWidgets('Invalid login shows error message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Enter invalid username and password
    await tester.enterText(find.byKey(Key('usernameField')), 'wrong');
    await tester.enterText(find.byKey(Key('passwordField')), 'wrong');

    // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pump();

    // Check for error message
    expect(find.text('Invalid username or password.'), findsOneWidget);
  });
}
