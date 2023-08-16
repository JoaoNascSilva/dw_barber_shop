import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw_barber_shop/src/core/rest_client/interceptors/auth_interceptors.dart';
import 'package:dw_barber_shop/src/core/ui/constants.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: 'http://192.168.1.202:8080',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        AuthInterceptors(),
      ],
    );
  }

  RestClient get auth {
    options.extra[DescriptionKeysConstants.dioAuthKey] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra[DescriptionKeysConstants.dioAuthKey] = false;
    return this;
  }
}
