import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read & Write Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String fileNameWithExt = 'text.txt';

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readTextFile();
  }

  Future<void> readTextFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileNameWithExt');

    if (!await file.exists()) return;

    textController.text = await file.readAsString();
  }

  Future<void> writeTextFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileNameWithExt');

    await file.writeAsString(textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Read & Write Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: const TextStyle(color: Colors.black54),
                controller: textController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 20.0),
              FilledButton(
                onPressed: writeTextFile,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
