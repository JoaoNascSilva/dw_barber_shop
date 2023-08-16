import 'package:dw_barber_shop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> auth(String email, password);

  Future<Either<RepositoryException, UserModel>> me();
}
