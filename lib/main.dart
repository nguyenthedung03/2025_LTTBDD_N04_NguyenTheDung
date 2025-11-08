import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/state_provider.dart';
import 'pages/home_page.dart';
import 'pages/car_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/favorites_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentCar',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/car': (context) => CarDetailPage(),
        '/car_corvette': (context) =>
            CarDetailCorvettePage(),
        '/car_lambo': (context) =>
            CarDetailLamboPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/favorites': (context) =>
            FavoritesPage(),
      },
    );
  }
}
