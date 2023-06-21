import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post_model.dart';

class PostService {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts');


  Future<void> deletePost(String documentId) async {
    try {
      await postsCollection.doc(documentId).delete();
    } catch (e) {
      print('Paylaşım silinirken hata oluştu: $e');
      throw Exception('Paylaşım silinirken hata oluştu');
    }
  }


  Future<List<Post>> getAllPosts() async {
    final querySnapshot = await postsCollection.get();
    final List<Post> posts = [];
    querySnapshot.docs.forEach((document) {
      final post = Post.fromDocument(document);
      posts.add(post);
    });
    return posts;
  }
  Future<void> createPost(Post post) async {
    await postsCollection.add({
      'userId': post.userId,
      'username': post.username,
      'profilePicture': post.profilePicture,
      'text': post.text,
      'photoUrl': post.photoUrl,
      'timestamp': post.timestamp,
      'Id' : postsCollection.doc().id,
    });

  }


  Future<List<Post>> getUserPosts(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .get();

    List<Post> userPosts = [];

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;
        Post post = Post(
          userId: data['userId'] as String,
          username: data['username'] as String,
          profilePicture: data['profilePicture'] as String,
          text: data['text'] as String,
          photoUrl: data['photoUrl'] as String,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
            Id: data['Id']
        );
        userPosts.add(post);
      });
    }

    return userPosts;
  }

}
