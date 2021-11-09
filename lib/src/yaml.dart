import 'dart:io' if (library.js) 'dart:html';

import 'package:yaml/yaml.dart';

class YamlHandler {
  Future<File?> findConfigFiles() async {
    String? filename;

    List<String> extensions = ['yml', 'yaml'];

    for (final ext in extensions) {
      final _check = 'clean_code.$ext';
      if (await File(_check).exists()) {
        filename = _check;
        break;
      }
    }
    return filename == null ? null : File(filename);
  }

  void printYaml() async {
    final file = await findConfigFiles();
    if (file == null) {
      print('clean_code config file not found. '
          ' Please create `clean_code.yml` at the root of your flutter application and try again');
    } else {
      final result = loadYaml(await file.readAsString());
      print(result);
    }
  }
}
