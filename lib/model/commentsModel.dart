import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsModel {
  int? uid;
  String? name;
  String? imageUrl;
  String? comment;
  Timestamp? timestamp;

  CommentsModel(
      {this.uid, this.name, this.imageUrl, this.comment, this.timestamp});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    this.uid = json['uid'];
    this.name = json['name'];
    this.imageUrl = json['imageUrl'];
    this.comment = json['comment'];
    this.timestamp = json['createdAt'];
  }
}
