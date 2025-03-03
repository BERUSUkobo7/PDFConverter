import 'package:flutter/material.dart';
import 'file_picker_util.dart';
import 'pdf_converter.dart'; // 🔥 ここで正しくインポート
import 'pdf_viewer.dart';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

class PdfConverterScreen extends StatefulWidget {
  const PdfConverterScreen({super.key}); // ← 修正

  @override
  PdfConverterScreenState createState() => PdfConverterScreenState();
}

class PdfConverterScreenState extends State<PdfConverterScreen> {
  bool isProcessing = false;

void convertImagesToPdf() async {
  setState(() => isProcessing = true);
  debugPrint("✅ PDF変換開始");

  try {
    // 画像ファイルのパスを取得
    List<String> imagePaths = await pickImagePaths();
    if (imagePaths.isEmpty) {
      debugPrint("⚠️ 画像が選択されませんでした");
      setState(() => isProcessing = false);
      return;
    }

    debugPrint("✅ 画像選択完了: ${imagePaths.length}枚");

    for (String imagePath in imagePaths) {
      Uint8List imageBytes = await loadImageAsBytes(imagePath);
      Uint8List pdfData = await generatePdfFromBytes(imageBytes);

      // 画像のファイル名を取得（拡張子を除去）
      String fileName = path.basenameWithoutExtension(imagePath); // ✅ フルパスではなくファイル名のみ取得
      String pdfFileName = "$fileName.pdf";

      debugPrint("✅ PDF生成完了: $pdfFileName");

      await saveAndOpenPdf(pdfData, fileName);
      debugPrint("✅ PDF保存完了: $pdfFileName");
    }
  } catch (e) {
    debugPrint("❌ エラー発生: $e");
  }

  setState(() => isProcessing = false);
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("画像をPDFに変換")),
      body: Center(
        child: isProcessing
            ? const CircularProgressIndicator() // ← const を追加
            : ElevatedButton(
                onPressed: convertImagesToPdf,
                child: const Text("画像を選択してPDFを作成"),
              ),
      ),
    );
  }
}
