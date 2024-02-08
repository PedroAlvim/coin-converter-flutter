import 'package:coin_converter/src/network/settings/network_settings.dart';
import 'package:coin_converter/src/repositories/coin_converter_repository.dart';
import 'package:coin_converter/src/ui/widget/card/info_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'coin_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('getCoinValue', () {
    test('returns correct value when cachedConverter is not null', () async {
      const double amount = 100;
      const double cachedConverter = 5.0;
      const Mode mode = Mode.usdBrl;

      final CoinConverterRepository repository = CoinConverterRepository();
      CoinConverterRepository.cachedConverter = cachedConverter;

      final result = await repository.getCoinValue(amount, mode);

      expect(result.successful, true);
      expect(result.data, '500.00');
    });

    test('fetches conversion value and returns correct result', () async {
      const double amount = 100;
      const double expectedConvertedValue = 500.0;
      const Mode mode = Mode.usdBrl;

      final MockDio mockDio = MockDio();

      var url = NetworkSettings.getCoinConverter(mode.text);

      when(mockDio.get(url)).thenAnswer((_) async => Response(
            statusCode: 200,
            data: {
              "USDBRL": {"high": "5.0"},
              "BRLUSD": {"high": "0.2"}
            },
            requestOptions: RequestOptions(),
          ));

      final coinConverterRepository = CoinConverterRepository(dio: mockDio);

      final result =
          await coinConverterRepository.getCoinValue(amount, Mode.usdBrl);

      expect(result.successful, true);
      expect(result.data, expectedConvertedValue.toStringAsFixed(2));
    });

    test('returns failure if request fails', () async {
      const double amount = 100;

      final MockDio mockDio = MockDio();

      when(mockDio.get(any)).thenThrow(Exception('Failed to fetch'));

      final coinConverterRepository = CoinConverterRepository(dio: mockDio);

      coinConverterRepository.clearCache();

      final result =
          await coinConverterRepository.getCoinValue(amount, Mode.usdBrl);

      expect(result.successful, false);
    });
  });
}
