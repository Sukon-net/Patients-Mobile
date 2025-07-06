import 'package:clients/core/networking/api_constants.dart';
import 'package:clients/core/networking/failures.dart';
import 'package:clients/core/utils/try_api_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PaymentRepo {
  Future<Either<BackendFailure, String>> getPaymentIframeUrl(double amount);
  Future<Either<BackendFailure, double>> getWalletBalance();
}

class PaymentRepoImpl implements PaymentRepo {
  final Dio _dio;

  PaymentRepoImpl(this._dio);

  @override
  Future<Either<BackendFailure, String>> getPaymentIframeUrl(
      double amount) async {
    return tryApiRequest(() async {
      final response = await _dio.post(
        ApiConstants.rechargeWallet,
        data: {
          'amount': amount,
        },
      );
      return response.data['data']['iframe_url'];
    });
  }

  @override
  Future<Either<BackendFailure, double>> getWalletBalance() async {
    return tryApiRequest(() async {
      final response = await _dio.get(ApiConstants.getBalance);
      return double.parse(response.data['data']['balance']);
    });
  }
}
