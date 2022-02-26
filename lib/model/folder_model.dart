import 'package:cloud_firestore/cloud_firestore.dart';

class Folder {
  final String id;
  final String name;
  final List<DocumentReference<Map<String, dynamic>>> posts;

  Folder({
    this.id = '',
    this.name = '',
    this.posts = const [],
  });
}
