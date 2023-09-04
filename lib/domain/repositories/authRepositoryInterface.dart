

import 'package:testing_clinicalpathways/domain/entities/userEntity.dart';

abstract class AuthenticationRepositoryInterface {

  Future<UserEntity> login(String email, String password);

}
