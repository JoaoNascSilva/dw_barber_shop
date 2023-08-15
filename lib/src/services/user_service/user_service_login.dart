import 'package:dw_barber_shop/src/core/exceptions/service_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';

import '../../core/fp/nil.dart';

abstract interface class UserServiceLogin {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
