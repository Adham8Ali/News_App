import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/navigation/app_routes.dart';
import 'package:news_app/features/splash/views/splash_screen.dart';

void main() {
  testWidgets('Splash screen shows login and signup buttons and navigates correctly', (WidgetTester tester) async {
    String? navigatedRoute;

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) {
          if (settings.name != AppRoutes.splash) {
            navigatedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const Scaffold());
          }
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        },
      ),
    );

    expect(find.text('log in'), findsOneWidget);
    expect(find.text('sign up'), findsOneWidget);

    // Tap log in and verify route
    await tester.tap(find.text('log in'));
    await tester.pumpAndSettle();
    expect(navigatedRoute, AppRoutes.login);
  });
}
