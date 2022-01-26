import 'package:flutter/cupertino.dart';

class StoriesModel {
  // ignore: prefer_typing_uninitialized_variables
  var storyContent;
  bool? haveNewStory;
  VoidCallback? onTap;

  StoriesModel({
    this.storyContent,
    this.haveNewStory = false,
    this.onTap,
  });
}
