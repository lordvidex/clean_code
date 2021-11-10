import 'dart:io';

class CCArgsParser {
  /// the user configuration containing the feature and generation settings of
  /// a clean architecture feature
  final Map<String, dynamic> configs;

  /// long keys to configs map
  Map<String, Map<String, dynamic>> keysToConfig = {};

  /// short keys to long keys map
  Map<String, String> shortKeysToLongKeys = {};

  ///
  CCArgsParser(this.configs);

  List<Item> parse(List<String> args) {
    _mapKeysToConfig();
    Set<String> arguments = {};
    String? name;

    // add all the arguments that prefixes the file name
    void addArgument(String key) {
      // full name of key used
      if (!configs.containsKey(key.substring(2))) {
        print('Unmapped/invalid argument $key');
        exit(-1);
      } else {
        arguments.add(key.substring(2));
      }
    }

    for (String each in args) {
      if (each.startsWith('--')) {
        // special case
        addArgument(each);
      } else if (each.startsWith('-')) {
        // short name of key used
        // TODO: add possibility of joined keys -adsadf
        addArgument(_longForm(each));
      } else {
        name = each;
        // TODO: process items from args and name
      }
    }
    // TODO:
    return [];
  }

  String _longForm(String shortKey) {
    if (!shortKeysToLongKeys.containsKey(shortKey)) {
      print('Invalid key');
      print('Short key mapping does not exist for key $shortKey');
      exit(-1);
    } else {
      return shortKeysToLongKeys[shortKey]!;
    }
  }

  void _mapKeysToConfig() {
    for (final item in configs.entries) {
      final itemMap = item.value as Map<String, dynamic>;

      final argKey = itemMap['argument_key'] as String?;
      final shortArgKey = itemMap['short_argument_key'] as String?;

      if (argKey != null) {
        keysToConfig[argKey] =
            Map.fromEntries([MapEntry(item.key, item.value)]);
      }
      if (shortArgKey != null) {
        shortKeysToLongKeys[shortArgKey] = argKey!;
      }
    }
  }
}

class Item {
  final bool generateDirectories;
  final String path;
  final String? implementationPath;
  final String name;
  final bool createImpl;
  Item({
    required this.path,
    required this.name,
    this.generateDirectories = false,
    this.createImpl = false,
    this.implementationPath,
  });
}
