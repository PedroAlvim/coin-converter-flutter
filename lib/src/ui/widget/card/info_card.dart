import 'package:coin_converter/src/ui/widget/card/money_input.dart';
import 'package:coin_converter/src/ui/widget/shared/default_padding.dart';
import 'package:coin_converter/src/ui/widget/shared/default_spacer.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.mode,
    required this.amountController,
    required this.resultController,
    required this.onSwapPressed,
    required this.onButtonPressed,
    this.onClearAmount,
  }) : super(key: key);

  final VoidCallback onButtonPressed;
  final VoidCallback onSwapPressed;
  final Mode mode;
  final TextEditingController amountController;
  final TextEditingController resultController;
  final VoidCallback? onClearAmount;

  static const _angle90 = 90 * 3.141592653589793 / 180;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        child: DefaultPadding(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Conversor monetário",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium),
              const DefaultSpacer(),
              const DefaultSpacer(),
              MoneyInput(
                controller: amountController,
                prefix: mode == Mode.usdBrl ? "US\$" : "R\$",
                onClearInput: onClearAmount,
                isEditingInput: true,
              ),
              const DefaultSpacer(),
              IconButton(
                icon: Transform.rotate(
                  angle: _angle90,
                  child: const Icon(
                    Icons.sync_alt,
                    size: 40,
                  ),
                ),
                onPressed: onSwapPressed,
              ),
              const DefaultSpacer(),
              MoneyInput(
                controller: resultController,
                prefix: mode == Mode.usdBrl ? "R\$" : "US\$",
              ),
              const DefaultSpacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onButtonPressed,
                      child: const Text("Converter"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Mode {
  final String text;

  const Mode._(this.text);

  static const usdBrl = Mode._("USD-BRL");
  static const brlUsd = Mode._("BRL-USD");
}
