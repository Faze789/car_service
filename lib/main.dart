import 'package:flutter/material.dart';
import 'package:cars_website/home.dart';
import 'package:go_router/go_router.dart';
import 'package:cars_website/AboutScreen.dart';
import 'package:cars_website/tour_screen.dart';
import 'package:cars_website/contact_screen.dart';
import 'package:cars_website/book_now_screen.dart';
import 'package:cars_website/TourDetailScreen.dart';



final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Home(),
      ),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const AboutScreen(),
      ),
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child:  ContactScreen(),
      ),
    ),
    GoRoute(
      path: '/tour',
      name: 'tour',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Home(),
      ),
    ),
    GoRoute(
      path: '/book_now',
      name: 'book_now',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const BookNowScreen(),
      ),
    ),
    GoRoute(
      path: '/tour/:id',
      builder: (context, state) {
        final tourId = state.pathParameters['id']!;
        return TourDetailScreen(tourId: tourId);
      },
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Desert Safari Adventures',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}