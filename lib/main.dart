import 'package:flutter/material.dart';
import 'package:news_app/Shared_component/Themes/mytheme.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.LightTheme,
      initialRoute: splashScreen.routeName,
      routes: {
        splashScreen.routeName: (context) => splashScreen(),
        homeScreen.routeName: (context) => homeScreen(),
      },
    );
  }
}
