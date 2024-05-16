import 'package:codehero/utils/functions/generate_hash.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio api = Dio()..interceptors.add(AuthInterceptor());

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = DateTime.now().toIso8601String();
    final publicKey = dotenv.env['PUBLIC_KEY'];
    final privateKey = dotenv.env['PRIVATE_KEY'];

    final hash = generateHash(timestamp + privateKey! + publicKey!);

    options.baseUrl = "http://gateway.marvel.com/v1/public";
    options.connectTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 10);
    options.queryParameters.addAll({
      "apikey": publicKey,
      "hash": hash,
      "ts": timestamp,
    });

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    handler.next(
      err.copyWith(
        message: err.response?.data['message'] ??
            'Something went wrong, try again later',
      ),
    );
  }
}
