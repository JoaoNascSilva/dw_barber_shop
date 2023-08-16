import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barber_shop/src/core/exceptions/service_exception.dart';
import 'package:dw_barber_shop/src/core/providers/application_providers.dart';
import 'package:dw_barber_shop/src/features/auth/login/login_state.dart';
import 'package:dw_barber_shop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fp/either.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userServiceLoginProvider);
    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():

        //! Invalidando os Caches para evitar o Login com o usuário Errado.
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarberShopProvider);

        //Buscar dados do Usuário Logado
        final userModel = await ref.read(getMeProvider.future);

        //Fazer análise para qual tipo de Login
        switch (userModel) {
          case UserModelAdm():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }

        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
        break;
    }

    loaderHandler.close();
  }
}
