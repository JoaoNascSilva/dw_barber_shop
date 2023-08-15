import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barber_shop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barber_shop/src/core/fp/either.dart';
import 'package:dw_barber_shop/src/core/rest_client/rest_client.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> auth(String email, password) async {
    try {
      final Response(:data) = await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          return Failure(AuthUnauthorizedException());
        }
      }

      log('Erro ao realizar login.', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login.'));
    }
  }
}
