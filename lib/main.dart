import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/theme/theme_cubit.dart';
import 'package:news_app/core/theme/theme_states.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/data/auth_data_source.dart';
import 'package:news_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:news_app/features/favorite/data/favorite_data_source.dart';
import 'package:news_app/features/home/cubit/news_cubit.dart';
import 'package:news_app/features/home/data/news_data_source.dart';
import 'package:news_app/features/splash/views/splash_screen.dart';
import 'package:news_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register Hive Adapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ArticleModelAdapter());
  }

  // Open Hive Boxes
  await Hive.openBox<ArticleModel>('newsBox');
  await Hive.openBox('settings');

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsCubit(NewsDataSource(Dio()))),
        BlocProvider(create: (_) => AuthCubit(AuthDataSource())),
        BlocProvider(create: (_) => FavoriteCubit(FavoriteDataSource())),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemeCubit>().themeData,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
