import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:notification_demo/main.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("Notification created currently");
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("Notification displayed");
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("working here ");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      print("platform is android");
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      print('Running on ${androidInfo.model}');
      print('Running on ${androidInfo.serialNumber}');
      print('Running on ${androidInfo.device}');
      print('Running on ${androidInfo.manufacturer}');
      print('Running on ${androidInfo.id}');
    }
    print("Notification dismissed");
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("Notification is tapped");
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    if (receivedAction.buttonKeyPressed == "markAsRead") {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/', (route) => (route.settings.name != '/') || route.isFirst,
          arguments: receivedAction);
    } else {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/notification-page',
          (route) =>
              (route.settings.name != '/notification-page') || route.isFirst,
          arguments: receivedAction);
    }
  }
}
