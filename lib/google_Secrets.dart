import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID = "1063587378136-dlhh2v7459p5fbj3rbrpu18m7jjd8570.apps.googleusercontent.com";
  // static const IOS_CLIENT_ID = "<enter your iOS client secret>";
  static const WEB_CLIENT_ID = "1063587378136-vmrpij9g1jfbftqbns5ss75p78dau5ll.apps.googleusercontent.com";
  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : WEB_CLIENT_ID;
  //  Secret.IOS_CLIENT_ID;
}
