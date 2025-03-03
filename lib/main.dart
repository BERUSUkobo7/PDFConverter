import 'package:flutter/material.dart';
import 'pdf_converter_screen.dart'; // 🔥 ここを確認

void main() {
  runApp(const MyApp()); // ← const を追加
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ← `super.key` を直接使う

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PDF Converter',
      home: PdfConverterScreen(), 
    );
  }
}
