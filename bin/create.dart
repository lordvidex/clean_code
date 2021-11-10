import 'package:clean_code/clean_code.dart';

void main(List<String> args) async {
  //TODO: create endpoint
  // examples:
  // clean_code:create --all -r -d auth

  // read config files
  final configs = await CCConfigs.getConfigs();

  // parse args to readable format
  final parsedArgs = CCArgsParser(configs).parse(args);
  CCGenerator().generate();
}
