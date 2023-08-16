import 'package:dw_barber_shop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/model/barbershop_model.dart';

import '../../model/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarberShop(
    UserModel userModel,
  );
}
