import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

class EnvData {
  EnvData._();

  static final instance = EnvData._();

  late String baseUrl;

  getEnvData() async {
    await dotenv.load(fileName: ".env");
    baseUrl = dotenv.get('BASE_URL');
  }
}
