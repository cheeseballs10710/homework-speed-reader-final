import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework Speed Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeworkSpeedReader(),
    );
  }
}

class HomeworkSpeedReader extends StatefulWidget {
  const HomeworkSpeedReader({super.key});

  @override
  _HomeworkSpeedReaderState createState() => _HomeworkSpeedReaderState();
}

class _HomeworkSpeedReaderState extends State<HomeworkSpeedReader> {
  final TextEditingController _textController = TextEditingController();
  String _summary = "";

  // Method to summarize text (placeholder logic for now)
  void summarizeText() {
    final text = _textController.text;
    final sentences = text.split('. ');
    final summary = sentences.take(3).join('. ') ;
    setState(() {
      _summary = summary;
    });
  }

  // Method to pick a text file and display its content in the TextField
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileContent = await file.readAsString();

      setState(() {
        _textController.text = fileContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homework Speed Reader")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // File Upload Button
            ElevatedButton(
              onPressed: pickFile,
              child: const Text("Upload Text File"),
            ),
            const SizedBox(height: 10),
            // Text Input Field
            TextField(
              controller: _textController,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Paste or upload your homework text here",
              ),
            ),
            const SizedBox(height: 10),
            // Summarize Button
            ElevatedButton(
              onPressed: summarizeText,
              child: const Text("Summarize"),
            ),
            const SizedBox(height: 20),
            // Summary Display
            Text(
              _summary,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
