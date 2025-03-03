import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img; // 画像サイズ取得用

Future<Uint8List> generatePdfFromBytes(Uint8List imageBytes) async {
  final pdf = pw.Document();

  // 画像のサイズを取得
  final image = img.decodeImage(imageBytes);
  if (image == null) throw Exception("画像のデコードに失敗しました");

  final width = image.width.toDouble();
  final height = image.height.toDouble();

  // 画像と同じサイズのPDFページを作成
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat(width, height),
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(pw.MemoryImage(imageBytes)),
        );
      },
    ),
  );

  return await pdf.save();
}
