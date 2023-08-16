import 'package:dio/dio.dart';
import 'package:dw_barber_shop/src/core/ui/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/local_storage_keys.dart';

class AuthInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {DescriptionKeysConstants.dioAuthKey: true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}'
      });
    }

    handler.next(options);
  }
}
