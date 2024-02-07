import 'package:coin_converter/src/network/request/request_result.dart';
import 'package:coin_converter/src/network/settings/network_settings.dart';
import 'package:coin_converter/src/ui/widget/card/info_card.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CoinConverterRepository {
  final _dio = Dio();
  final _logger = Logger();

  static double? cachedConverter;

  Future<RequestResult<String>> getCoinValue(double amount, Mode mode) async {
    if (cachedConverter != null) {
      double convertedValue = amount * cachedConverter!;

      return RequestResult(
        successful: true,
        data: convertedValue.toStringAsFixed(2),
      );
    }

    try {
      final response =
          await _dio.get(NetworkSettings.getCoinConverter(mode.text));

      var statusCode = response.statusCode;

      if (statusCode == 200) {
        String key = mode == Mode.usdBrl ? "USDBRL" : "BRLUSD";

        final converterValue = double.parse(response.data[key]["high"]);

        cachedConverter = converterValue;

        double convertedValue = amount * converterValue;

        return RequestResult(
          successful: true,
          data: convertedValue.toStringAsFixed(2)
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
