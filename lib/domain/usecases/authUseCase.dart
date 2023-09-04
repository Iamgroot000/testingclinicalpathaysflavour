

import 'package:testing_clinicalpathways/domain/entities/userEntity.dart';
import 'package:testing_clinicalpathways/domain/repositories/authRepositoryInterface.dart';

class AuthUseCase {
  final AuthenticationRepositoryInterface authenticationRepositoryInterface;

  AuthUseCase(this.authenticationRepositoryInterface);

  Future<UserEntity> execute(String email, String password) async {
    return await authenticationRepositoryInterface.login(email, password);
  }

}
