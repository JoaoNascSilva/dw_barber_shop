import 'package:dio/dio.dart';

import 'package:dw_barber_shop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/rest_client/rest_client.dart';
import 'package:dw_barber_shop/src/model/barbershop_model.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarberShop(
    UserModel userModel,
  ) async {
    switch (userModel) {
      case UserModelAdm():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );
        return Success(
          BarbershopModel.fromMap(data),
        );
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barberShopId}',
        );
        return Success(
          BarbershopModel.fromMap(data),
        );
    }
  }
}
