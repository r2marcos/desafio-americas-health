import 'package:flutter/material.dart';

import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FrankFurter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}
