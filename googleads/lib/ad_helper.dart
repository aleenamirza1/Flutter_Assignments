import 'dart:io';

class AdHelper {
  static String get bannerAdUmitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8310682396860346/5137666946";
    } else {
      throw UnsupportedError("Unknown Platform");
    }
  }
}
