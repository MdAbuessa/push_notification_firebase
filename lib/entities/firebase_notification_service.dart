import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseNotificationService._();

  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //forfground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //background message
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Essa ${message.notification?.title}');
      print(message.notification?.body);
      print(message.data);
    });
    //terminated state message
    FirebaseMessaging.onBackgroundMessage(doNothing);
    String? token = await getToken();
    print("Firebase Token: $token");
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  Future<void> onRefreshToken() async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      //call an api
      //send new token to your server
      print("New Token: $token");
    });
  }
}

Future<void> doNothing(RemoteMessage RemoteMessage) async {}
