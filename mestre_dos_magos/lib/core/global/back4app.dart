import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4App {
  static Future<void> initParse() async {
    const applicationId = 'dnPHTs797cEO0WqrVUmFeiXUmobzq3XoqDXaveuj';
    const clientKey = 'UZh10s9ELqe6jrexHna0aw0S3Iuj7nr3vLO3oeFP';
    const parseServerURL = 'https://parseapi.back4app.com';

    await Parse().initialize(applicationId, parseServerURL, clientKey: clientKey, autoSendSessionId: true);

    // var attributes = ParseObject('Attributes')
    //   ..set('strength', 10)
    //   ..set('constitution', 14)
    //   ..set('dexterity', 12)
    //   ..set('intelligence', 17)
    //   ..set('wisdom', 16)
    //   ..set('charisma', 14);
    // await attributes.save();
  }
}