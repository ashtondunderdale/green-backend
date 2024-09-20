import 'package:flutter/material.dart';
import 'package:twofile/home/home_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView()
      // Did you know that OneFile has been released for 8 years? Way too many.
    );
  }
}
