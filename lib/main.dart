import 'package:engine/core/engine.dart';
import 'package:engine/views/engine_view.dart';
import 'package:engine/controllers/ascii_grid_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AsciiEngine()),
        ChangeNotifierProvider(create: (context) => AsciiGridController())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EngineView()
      ),
    );
  }
}
