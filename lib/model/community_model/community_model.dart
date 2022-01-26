import 'package:flutter/cupertino.dart';

class CommunityModel {
  // ignore: prefer_typing_uninitialized_variables
  var communityLogo, communityName;
  VoidCallback? onTap;

  CommunityModel({
    this.communityLogo,
    this.communityName,
    this.onTap,
  });
}

class MessagesModel {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  bool? add;

  MessagesModel({
    this.name,
    this.add = false,
  });
}
