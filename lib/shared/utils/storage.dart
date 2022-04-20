import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageUtil {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _htmlFile async {
    final path = await _localPath;
    return File('$path/index.html');
  }

  Future<String> readHtmlFile() async {
    try {
      final file = await _htmlFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return empty string
      return '';
    }
  }

  Future<File> writeHtml(String html) async {
    final file = await _htmlFile;

    // Write the file
    return file.writeAsString(html);
  }
}
