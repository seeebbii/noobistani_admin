import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String? id;
  String? name;
  String? email;
  String? imageUrl;
  Timestamp? createdAt;
  String? bio;

  UserModel({this.id, this.name, this.email, this.imageUrl, this.createdAt, this.bio});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc){
    this.id = doc.data()?['uid'];
    this.name = doc.data()?['name'];
    this.email = doc.data()?['email'];
    this.imageUrl = doc.data()?['imageUrl'];
    this.createdAt = doc.data()?['createdAt'];
    this.bio = doc.data()?['bio'];
  }

}