import 'package:either_dart/either.dart';
import 'package:wonk_app/domain/models/user_model.dart';

abstract class AuthService {
  Future<Either<Exception, UserModel>> getCurrentUser();

  Future<Either<Exception, UserModel>> login(String email, String password);

  Future<Either<Exception, UserModel>> loginWithGoogle();

  Future<void> logout();

  Future<Either<String, UserModel>> register(String email, String password);

  Future<void> recoverPassword(String email);
}
