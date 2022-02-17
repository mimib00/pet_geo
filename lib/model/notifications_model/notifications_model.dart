import 'package:flutter/material.dart';

class NotificationsModel {
  final String title;
  final String msg;
  final String time;
  VoidCallback? onTap;

  NotificationsModel({
    this.title = '',
    this.msg = '',
    this.time = '',
    this.onTap,
  });
}
