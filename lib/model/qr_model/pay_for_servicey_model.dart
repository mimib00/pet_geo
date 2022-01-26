import 'package:flutter/cupertino.dart';

class PayForServiceyModel {
  // ignore: prefer_typing_uninitialized_variables
  var petImg, title, subtitle;
  VoidCallback? onTap;

  PayForServiceyModel({
    this.petImg,
    this.title,
    this.subtitle,
    this.onTap,
  });
}
