
import 'package:flutter/cupertino.dart';

class NotificationsModel {
  NotificationsModel({
    this.name,
    this.notificationMsg,
    this.notificationThing,
    this.time,
    this.haveNewNotification = false,
    this.haveFriendRequest = false,
    this.onTap,
  });

  // ignore: prefer_typing_uninitialized_variables
  var name, notificationMsg, time, notificationThing;
  bool? haveNewNotification, haveFriendRequest;
  VoidCallback? onTap;
}
