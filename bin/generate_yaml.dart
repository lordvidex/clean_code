import 'dart:io';

void main(List<String> args) async {
  String contents = '''
  # yaml-language-server: \$schema=https://github.com/lordvidex/clean_code/clean_code_schema.json

# THE COMMENT ABOVE IS REQUIRED FOR VALIDATION

clean_code:
  repositories: 
    enabled: true
    path: lib/domain/repositories
    create_implementation: false
    implementation_path: lib/data/repositories
  
  entities:
    enabled: true 
    path: lib/domain/entities

  usecases:
    enabled: false
    path: lib/domain/usecases

  models:
    enabled: true
    path: lib/domain/models

  di: 
    enabled: true
    path: lib/injection_container.dart
  ''';
  await File('clean_code.yaml').writeAsString(contents);
}