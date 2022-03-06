import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final DocumentReference<Map<String, dynamic>> owner;
  final String id;
  final String photo;
  final Timestamp createdAt;

  Story(
    this.owner,
    this.id,
    this.photo,
    this.createdAt,
  );

  factory Story.fromMap(Map<String, dynamic> data, {String? uid}) => Story(
        data['owner'],
        uid ?? "",
        data["photo"],
        data["created_at"],
      );
}

class StoryCollenction {
  final List<Story> stories;

  StoryCollenction({
    this.stories = const [],
  });

  factory StoryCollenction.clear(List<Story> story) {
    final date2 = DateTime.now();
    story.removeWhere((element) => date2.difference(element.createdAt.toDate()).inHours >= 24);
    return StoryCollenction(stories: story);
  }
}
