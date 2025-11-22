import 'package:flutter/material.dart';
import 'package:isar_viewer/home_page.dart';
import 'package:isar_viewer/isar_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}
