import 'package:flutter/material.dart';
import 'package:news_app/features/auth/views/login_screen.dart';
import 'package:news_app/features/auth/views/signup_screen.dart';
import 'package:news_app/features/category/views/category_view.dart';
import 'package:news_app/features/home/views/article_web_view.dart';
import 'package:news_app/features/home/views/navbar_screen.dart';
import 'package:news_app/features/splash/views/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String navBar = '/navbar';
  static const String articleWebView = '/article-webview';
  static const String categoryView = '/category-view';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
          settings: settings,
        );
      case navBar:
        return MaterialPageRoute(
          builder: (_) => const NavBar(),
          settings: settings,
        );
      case articleWebView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ArticleWebView(
            url: args['url'] as String,
            title: args['title'] as String,
          ),
          settings: settings,
        );
      case categoryView:
        final category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CategoryView(category: category),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
