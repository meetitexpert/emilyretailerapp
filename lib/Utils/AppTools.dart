import 'package:package_info_plus/package_info_plus.dart';

class AppTools {
    static late String accessToken;
    static late String clientClass;
    static late String appVersion;

    static Future<void> init() async
    {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        appVersion = packageInfo.version;

        accessToken = "09b16acba64e1929875605b3c657404e";
    }
}