import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';

// 画像のパスを取得（ファイル名を保持するため）
Future<List<String>> pickImagePaths() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true, // 複数選択を許可
  );

  if (result == null) return [];

  return result.files.map((file) => file.path!).toList();
}

// 画像ファイルを Uint8List に変換
Future<Uint8List> loadImageAsBytes(String imagePath) async {
  File file = File(imagePath);
  return await file.readAsBytes();
}
