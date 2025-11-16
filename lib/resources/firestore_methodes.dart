import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/model/post.dart';
import 'package:instagram/resources/storage_methodes.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethodes {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String uid,
    Uint8List file,
    String description,
    String username,
    String profileImage,
  ) async {
    String res = 'some error occured';
    try {
      String photoUrl = await StorageMethodes().uploadImageToStorage(
        'post',
        file,
        true,
      );
      String postId = const Uuid().v1();
      Post post = Post(
        userName: username,
        uid: uid,
        description: description,
        dataPublished: DateTime.now(),
        postId: postId,
        profileImage: profileImage,
        postUrl: photoUrl,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(post.tojson());
      return res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
