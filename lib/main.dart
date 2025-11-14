import 'package:flutter/material.dart';
import 'package:isar_viewer/isar/isar_manager.dart';

void main() async {
  await IsarManager.init();
  runApp(const IsarViewerApp());
}

class IsarViewerApp extends StatelessWidget {
  const IsarViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IsarViewer',
      themeMode: Theme.of(context).brightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('IsarViewer'),
      ),
      body: Center(child: Text('Check the terminal to open isar inspector')),
    );
  }
}
