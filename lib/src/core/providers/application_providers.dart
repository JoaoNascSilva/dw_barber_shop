import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/model/barbershop_model.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';
import 'package:dw_barber_shop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dw_barber_shop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../services/user_service/user_service_login.dart';
import '../../services/user_service/user_service_login_impl.dart';
import '../rest_client/rest_client.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(
      restClient: ref.read(restClientProvider),
    );

@Riverpod(keepAlive: true)
UserServiceLogin userServiceLogin(UserServiceLoginRef ref) =>
    UserServiceLoginImpl(
      userRepository: ref.read(userRepositoryProvider),
    );

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarberShop(GetMyBarberShopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barberShopRepository = ref.watch(barbershopRepositoryProvider);

  final result = await barberShopRepository.getMyBarberShop(userModel);

  return switch (result) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception,
  };
}
