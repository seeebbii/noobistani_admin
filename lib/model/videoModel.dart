import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noobistani_admin/model/commentsModel.dart';

class VideoModel {
  String? uid;
  String? name;
  String? email;
  String? imageUrl;
  String videoUrl = "";
  Timestamp? timestamp;

  VideoModel(
      this.uid,
      this.name,
      this.email,
      this.imageUrl,
      this.videoUrl,
      this.timestamp);

  // List<CommentsModel>? commentsModel;

  VideoModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    this.uid = doc.data()!['uid'];
    this.name = doc.data()!['name'];
    this.email = doc.data()!['email'];
    this.imageUrl = doc.data()!['imageUrl'];
    this.videoUrl = doc.data()!['videoUrl'];
    this.timestamp = doc.data()!['createdAt'];
    // this.commentsModel = json['name'];
  }
}
