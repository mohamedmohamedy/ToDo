import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = ln.FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  static Future _notificationDetails() async {
    return const ln.NotificationDetails(
      android: ln.AndroidNotificationDetails(
        'channel id',
        'channel name',
        icon: "@mipmap/ic_launcher",
        enableVibration: true,
        channelDescription: 'channel description',
        importance: ln.Importance.max,
        priority: ln.Priority.max,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = ln.AndroidInitializationSettings("@mipmap/ic_launcher");
    final settings = ln.InitializationSettings(android: android);
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            ln.UILocalNotificationDateInterpretation.absoluteTime,
      );
}
