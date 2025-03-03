import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';

Future<void> saveAndOpenPdf(Uint8List pdfData, String fileName) async {
  try {
    String path = await FileSaver.instance.saveFile(
      name: fileName,
      bytes: pdfData,
      ext: "pdf",
      mimeType: MimeType.pdf,
    );

    debugPrint("✅ PDF saved at: $path");
  } catch (e) {
    debugPrint("❌ Error saving PDF: $e");
  }
}
