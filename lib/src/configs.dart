import 'dart:io';
import 'package:yaml/yaml.dart';

/// Class for handling configuration operations such as:
/// - searching for config files
/// - providing default configs when files do not exist
class CCConfigs {
  CCConfigs._();

  // default config used when user doesn't provide `clean_code.yaml` file
  static const Map<String, dynamic> _defaultConfig = {
    'repository': {
      'enabled': true,
      'path': 'lib/domain/repositories',
      'create_implementation': true,
      'implementation_path': 'lib/data/repositories',
      'argument_key': '--repository',
      'short_argument_key': '-r'
    },
    'entity': {
      'enabled': true,
      'path': 'lib/domain/entities',
      'argument_key': '--entity',
      'short_argument_key': '-e'
    },
    'usecase': {
      'enabled': false,
      'path': 'lib/domain/usecases',
      'arguemnt_key': '--usecase',
      'short_argument_key': '-u'
    },
    'model': {
      'enabled': true,
      'path': 'lib/domain/models',
      'argument_key': '--model',
      'short_argument_key': '-m'
    },
    'di': {
      'enabled': true,
      'path': 'lib/injection_container.dart',
    }
  };

  // returns `null` if path does not contain config files
  // else returns config file
  static Future<File?> _findConfigFiles() async {
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

  /// returns `defaultConfigs` when user doesn't specify configs
  /// but returns an overwrite for keys provided when user provides
  /// config `clean_code.yml` file.
  ///
  static Future<Map<String, dynamic>> getConfigs() async {
    final file = await _findConfigFiles();
    if (file == null) {
      return _defaultConfig;
    } else {
      final _userConfigs = loadYaml(await file.readAsString())['clean_code']
          as Map<String, dynamic>;

      // load default keys and values and replace where necessary
      // with user settings
      var _newConfigs = Map<String, dynamic>.from(_defaultConfig);
      for (var item in _userConfigs.entries) {
        if (_newConfigs.containsKey(item.key)) {
          _newConfigs[item.key].addAll(item.value);
        } else {
          _newConfigs[item.key] = item.value;
        }
      }
      return _newConfigs;
    }
  }
}
