import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pasignasigna_navigation_app/demo_auth.dart';
import 'package:pasignasigna_navigation_app/main.dart';
import 'package:pasignasigna_navigation_app/login_screen.dart';
import 'package:pasignasigna_navigation_app/main_screen.dart';

Finder field(String key) => find.byKey(ValueKey(key));

Future<void> tap(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      80,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> login(
  WidgetTester tester, {
  String username = 'admin',
  String password = 'admin123',
}) async {
  await tester.enterText(field('username'), username);
  await tester.enterText(field('password'), password);
  await tap(tester, field('login'));
}

Future<void> register(
  WidgetTester tester,
  String username,
  String password,
) async {
  await tap(tester, field('open-register'));
  await tester.enterText(field('username'), username);
  await tester.enterText(field('password'), password);
  await tester.enterText(field('confirmation'), password);
  await tap(tester, field('register'));
}

Future<void> tab(WidgetTester tester, String label) =>
    tap(tester, find.widgetWithText(NavigationDestination, label));

void main() {
  WidgetController.hitTestWarningShouldBeFatal = true;
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
  });

  test(
    'Demo accounts replace previous registration and preserve exact passwords',
    () {
      expect(DemoAuth.login('admin', 'admin123'), isTrue);
      expect(DemoAuth.login('ADMIN', 'admin123'), isFalse);
      DemoAuth.register('jolex', ' pass123 ');
      expect(DemoAuth.login('jolex', 'pass123'), isFalse);
      expect(DemoAuth.login('jolex', ' pass123 '), isTrue);
      DemoAuth.register('newuser', 'secret');
      expect(DemoAuth.login('jolex', ' pass123 '), isFalse);
      expect(DemoAuth.login('newuser', 'secret'), isTrue);
      expect(DemoAuth.login('admin', 'admin123'), isTrue);
    },
  );

  testWidgets(
    'Login validates, toggles password, rejects invalid credentials and opens Home',
    (tester) async {
      await tester.pumpWidget(const StudentApp());
      expect(find.byType(LoginScreen), findsOneWidget);
      await tap(tester, field('login'));
      expect(find.text('Enter your username.'), findsOneWidget);
      expect(find.text('Enter your password.'), findsOneWidget);
      await tap(tester, find.byTooltip('Show password'));
      final passwordField = find.descendant(
        of: field('password'),
        matching: find.byType(TextField),
      );
      expect(tester.widget<TextField>(passwordField).obscureText, isFalse);
      await login(tester, password: 'wrong');
      expect(find.text('Invalid username or password.'), findsOneWidget);
      await login(tester, username: ' admin ');
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.text('Welcome, Student!'), findsOneWidget);
      expect(find.byType(NavigationDestination), findsNWidgets(4));
      expect(find.byType(LoginScreen), findsNothing);
    },
  );

  testWidgets(
    'Registration validates reserved names, length and confirmation',
    (tester) async {
      await tester.pumpWidget(const StudentApp());
      await tap(tester, field('open-register'));
      await tap(tester, field('register'));
      expect(find.text('Use at least 3 characters.'), findsOneWidget);
      expect(find.text('Enter a password.'), findsOneWidget);
      expect(find.text('Confirm your password.'), findsOneWidget);
      await tester.enterText(field('username'), ' AdMiN ');
      await tester.enterText(field('password'), '12345');
      await tester.enterText(field('confirmation'), 'other');
      await tap(tester, field('register'));
      expect(find.text('This username is reserved.'), findsOneWidget);
      expect(find.text('Use at least 6 characters.'), findsOneWidget);
      expect(find.text('Passwords do not match.'), findsOneWidget);
      await tester.enterText(field('password'), '      ');
      await tap(tester, field('register'));
      expect(find.text('Enter a password.'), findsOneWidget);
      await tester.enterText(field('username'), ' jolex ');
      await tester.enterText(field('password'), ' secret ');
      await tester.enterText(field('confirmation'), ' secret ');
      await tap(tester, find.byTooltip('Show password'));
      await tap(tester, find.byTooltip('Show confirmation password'));
      await tap(tester, field('register'));
      expect(
        find.text('Registration successful! You can now log in.'),
        findsOneWidget,
      );
      await login(tester, username: 'jolex', password: ' secret ');
      expect(find.text('Welcome, Student!'), findsOneWidget);
      await tap(tester, find.byTooltip('Log out'));
      expect(find.byType(LoginScreen), findsOneWidget);
      await register(tester, 'replacement', 'secret2');
      await login(tester, username: 'jolex', password: ' secret ');
      expect(find.text('Invalid username or password.'), findsOneWidget);
      await login(tester, username: 'replacement', password: 'secret2');
      expect(find.byType(MainScreen), findsOneWidget);
      await tap(tester, find.byTooltip('Log out'));
      await login(tester);
      expect(find.byType(MainScreen), findsOneWidget);
    },
  );

  testWidgets(
    'Calculator performs all operations and preserves state through every tab',
    (tester) async {
      await tester.pumpWidget(const StudentApp());
      await login(tester);
      await tab(tester, 'Calculator');
      await tester.enterText(field('first-number'), ' -7.5 ');
      await tester.enterText(field('second-number'), '2.5');
      for (final operation in [
        ('Add', '-7.5 + 2.5 = -5'),
        ('Subtract', '-7.5 − 2.5 = -10'),
        ('Multiply', '-7.5 × 2.5 = -18.75'),
        ('Divide', '-7.5 ÷ 2.5 = -3'),
      ]) {
        await tap(tester, field(operation.$1));
        expect(find.text(operation.$2), findsOneWidget);
      }
      await tab(tester, 'Profile');
      expect(find.text('557989'), findsOneWidget);
      expect(find.text('Jolex129@gmail.com'), findsOneWidget);
      expect(find.text('BSIT — 3rd Year'), findsOneWidget);
      await tab(tester, 'Social Media');
      for (final account in [
        ('Facebook', 'Facebook: student.sample'),
        ('Instagram', 'Instagram: @student.sample'),
        ('YouTube', 'YouTube: @StudentChannel'),
      ]) {
        await tap(tester, find.text(account.$1));
        expect(find.text('Selected account: ${account.$2}'), findsOneWidget);
      }
      await tab(tester, 'Home');
      await tab(tester, 'Calculator');
      expect(find.text('-7.5 ÷ 2.5 = -3'), findsOneWidget);
      expect(
        tester.widget<TextFormField>(field('first-number')).controller!.text,
        ' -7.5 ',
      );
      await tap(tester, find.text('Clear'));
      expect(
        tester.widget<TextFormField>(field('first-number')).controller!.text,
        isEmpty,
      );
      expect(
        tester.widget<TextFormField>(field('second-number')).controller!.text,
        isEmpty,
      );
      expect(
        find.text('Enter two numbers and choose an operation.'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Calculator rejects empty, invalid, nonfinite, zero division and overflow',
    (tester) async {
      await tester.pumpWidget(const StudentApp());
      await login(tester);
      await tab(tester, 'Calculator');
      await tap(tester, field('Add'));
      expect(find.text('Enter a number.'), findsNWidgets(2));
      for (final value in ['abc', 'NaN', 'Infinity', '1e999']) {
        await tester.enterText(field('first-number'), value);
        await tester.enterText(field('second-number'), '2');
        await tap(tester, field('Add'));
        expect(find.text('Enter a valid finite number.'), findsOneWidget);
      }
      await tester.enterText(field('first-number'), '10');
      await tester.enterText(field('second-number'), '0');
      await tap(tester, field('Divide'));
      expect(find.text('Cannot divide by zero.'), findsNWidgets(2));
      await tester.enterText(field('second-number'), '2');
      await tap(tester, field('Divide'));
      expect(find.text('10 ÷ 2 = 5'), findsOneWidget);
      await tester.enterText(field('first-number'), '1e308');
      await tester.enterText(field('second-number'), '1e308');
      await tap(tester, field('Multiply'));
      expect(
        find.text('Result is too large. Try smaller numbers.'),
        findsOneWidget,
      );
      await tap(tester, find.text('Clear'));
      expect(find.text('Enter a valid finite number.'), findsNothing);
    },
  );

  testWidgets(
    'Small screen and keyboard allow registration, navigation and calculator',
    (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      tester.view.viewInsets = const FakeViewPadding(bottom: 240);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);
      await tester.pumpWidget(const StudentApp());
      await register(tester, 'jolex', 'secret');
      await login(tester, username: 'jolex', password: 'secret');
      await tab(tester, 'Calculator');
      await tester.enterText(field('first-number'), '5');
      await tester.enterText(field('second-number'), '2');
      await tap(tester, field('Add'));
      await tab(tester, 'Profile');
      await tab(tester, 'Social Media');
      await tab(tester, 'Calculator');
      expect(find.text('5 + 2 = 7'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
