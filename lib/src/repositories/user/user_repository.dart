import 'package:dw_barber_shop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> auth(String email, password);
}
