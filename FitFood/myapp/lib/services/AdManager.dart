import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8796150055601896~3450226083";
    }

    return null;
  }

  static String get adUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8796150055601896/4108441215";
      // return "ca-app-pub-3940256099942544/1033173712"; // test ad
    }

    return null;
  }
}
