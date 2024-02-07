import 'package:coin_converter/src/repositories/coin_converter_repository.dart';
import 'package:coin_converter/src/ui/widget/card/info_card.dart';
import 'package:coin_converter/src/ui/widget/shared/default_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _coinConverterRepository = CoinConverterRepository();
  Color darkBlue = const Color(0xFF1A173A);

  Mode _buildMode = Mode.usdBrl;

  final MoneyMaskedTextController _amountController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
  );

  final MoneyMaskedTextController _resultController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      backgroundColor: darkBlue,
      body: Column(
        children: [
          Container(height: 8),
          Expanded(
            child: Center(
              child: DefaultPadding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultPadding(
                      child: InfoCard(
                        mode: _buildMode,
                        amountController: _amountController,
                        resultController: _resultController,
                        onSwapPressed: _snapMode,
                        onButtonPressed: _converterCoin,
                        onClearAmount: _clearInputs,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  void _snapMode() {
    setState(() {
      _coinConverterRepository.clearCache();

      _resultController.text = "0,00";
      if (_buildMode == Mode.usdBrl) {
        _buildMode = Mode.brlUsd;
      } else {
        _buildMode = Mode.usdBrl;
      }
    });
  }

  void _clearInputs() {
    setState(() {
      _resultController.text = "0,00";
      _amountController.text = "0,00";
    });
  }

  void _converterCoin() {
    double amount = parseFormattedStringToDouble(_amountController.text);

    _coinConverterRepository.getCoinValue(amount, _buildMode).then((result) {
      if (result.successful && result.data != null) {
        _resultController.text = result.data!;
      } else {
        _showGenericError();
      }
    }).catchError((error, stackTrace) {
      _showGenericError();
    });
  }

  void _showGenericError() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Erro ao converter moeda."),
    ));
  }
}

double parseFormattedStringToDouble(String value) {
  String cleanedValue = value.replaceAll('.', '');
  cleanedValue = cleanedValue.replaceAll(',', '.');

  return double.parse(cleanedValue);
}
