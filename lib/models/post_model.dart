import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userId;
  final String username;
  final String profilePicture;
  final String text;
  final String photoUrl;
  final DateTime timestamp;
  final String Id;

  Post({
    required this.userId,
    required this.username,
    required this.profilePicture,
    required this.text,
    required this.photoUrl,
    required this.timestamp,
    required this.Id,
  });

  factory Post.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return Post(
      userId: data['userId'],
      username: data['username'],
      profilePicture: data['profilePicture'],
      text: data['text'],
      photoUrl: data['photoUrl'],
      timestamp: data['timestamp'].toDate(),
      Id: data['Id'],
    );
  }
}