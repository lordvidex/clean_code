import 'dart:io';

void main(List<String> args) async {
  print('Generating yaml file ...');

  // default yaml contents
  String contents =
      '''# yaml-language-server: \$schema=https://flutter-clean-code.herokuapp.com/clean_code_schema.json

# THE COMMENT ABOVE IS REQUIRED FOR VALIDATION

clean_code:
  repositories: 
    enabled: true
    path: lib/domain/repositories
    create_implementation: true
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

  // write to file and print on either success case or failure case
  File('clean_code.yaml').writeAsString(contents).then((_) {
    print('File successfully generated');
  }).catchError((error) {
    print('An error occured with the following stacktrace: \n$error');
  });
}
