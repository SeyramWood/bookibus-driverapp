 import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<List<File>> selectFiles() async {
  List<File> files =[];
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
       files = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();
      return files;
    }
    return [];
  }