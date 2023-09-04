import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

UserEntity userFromJson(String str) => UserEntity.fromJson(json.decode(str));

String userToJson(UserEntity data) => json.encode(data.toJson());

List<UserEntity> userListFromJson(str) => List<UserEntity>.from(
    (str).map((x) => UserEntity.fromJson(x.data())));

String userListToJson(List<UserEntity> users) {
  final List<Map<String, dynamic>> jsonData =
      users.map((user) => user.toJson()).toList();
  return json.encode(jsonData);
}

class UserEntity {

  DocumentReference<Object?>? reference;
  late String? name;
  late String? email;
  late String? password;
  late String? role;
  late String? token;
  late String? status;

  UserEntity({
    this.name,
    this.email,
    this.password,
    this.role,
    this.token,
    this.status,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        token: json['token'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        'token': token,
        'status': status,
      };

  UserEntity.fromMap(map, {this.reference}) {
    name = map['name'];
    email = map['email'];
    password = map['password'];
    role = map['role'];
    token = map['token'];
    status = map['status'];
  }

  UserEntity.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
