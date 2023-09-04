import 'package:testing_clinicalpathways/domain/entities/userEntity.dart';
import 'package:testing_clinicalpathways/domain/repositories/authRepositoryInterface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      var res = await _firestore
          .collection('users')
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();

      if (res.docs.length == 1) {
        return UserEntity.fromJson(res.docs[0].data());
      } else {
        return UserEntity();
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }


}
