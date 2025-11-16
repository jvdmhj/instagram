import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userName;
  final String uid;
  final String description;
  final dataPublished;
  final String postId;
  final String profileImage;
  final String postUrl;
  final likes;
  Post({
    required this.userName,
    required this.uid,
    required this.description,
    required this.dataPublished,
    required this.postId,
    required this.profileImage,
    required this.postUrl,
    required this.likes,
  });
  Map<String, dynamic> tojson() => {
    'username': userName,
    'uid': uid,
    'description': description,
    'dataPublished': dataPublished,
    'postId': postId,
    'profileImage': profileImage,
    'postUrl': postUrl,
    'likes': likes,
  };
  static Post fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      userName: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['decription'],
      dataPublished: snapshot['dataPublished'],
      postId: snapshot['postId'],
      profileImage: snapshot['profileImage'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
    );
  }
}
