import 'package:flutter/material.dart';
import 'package:isar_viewer/isar_manager.dart';
import 'package:isar_viewer/schema_type.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const prompt = 'Check the terminal to open isar inspector';

  @override
  Widget build(BuildContext context) {
    final buttonStyle = FilledButton.styleFrom(
      minimumSize: Size(double.infinity, 60),
      textStyle: Theme.of(context).textTheme.titleLarge,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text('Isar Viewer'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: buttonStyle,
                onPressed: () async {
                  await IsarManager.open(SchemaType.builder);
                  if (context.mounted) showPrompt(context);
                },
                child: Text('Builder Isar'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: buttonStyle,
                onPressed: () async {
                  await IsarManager.open(SchemaType.app);
                  if (context.mounted) showPrompt(context);
                },
                child: Text('App Isar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPrompt(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(prompt)));
  }
}
