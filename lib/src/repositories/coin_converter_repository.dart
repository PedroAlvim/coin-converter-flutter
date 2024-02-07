import 'package:coin_converter/src/network/request/request_result.dart';
import 'package:coin_converter/src/network/settings/network_settings.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CoinConverterRepository {
  final _dio = Dio();
  final _logger = Logger();

  static double? cachedConverter;

  Future<RequestResult<double>> getCoinValue(double amount) async {
    if (cachedConverter != null) {
      return RequestResult(
        successful: true,
        data: amount * cachedConverter!,
      );
    }

    try {
      final response = await _dio
          .get(NetworkSettings.getCoinConverter("USD-BRL"));

      var statusCode = response.statusCode;

      if (statusCode == 200) {
        final converterValue = double.parse(response.data["USDBRL"]["high"]);

        cachedConverter = converterValue;

       return RequestResult(
          successful: true,
          data: amount * converterValue,
        );
      }

      _logger.e("Failed to get conversion value. StatusCode: $statusCode",
          response.data);
    } catch (error) {
      _logger.e("request failed.", error);
    }

    return RequestResult(successful: false);
  }

 void clearCache() {
    cachedConverter = null;
  }
}