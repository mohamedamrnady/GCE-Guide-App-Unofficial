import 'package:flutter/material.dart';
import 'package:gce_guide/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GCE Guide',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: const MainPage(
        url: 'https://papers.gceguide.com/',
        title: 'GCE Guide',
      ),
    );
  }
}
