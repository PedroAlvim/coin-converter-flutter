import 'package:coin_converter/src/ui/widget/shared/default_padding.dart';
import 'package:coin_converter/src/ui/widget/shared/rounded_clickable.dart';
import 'package:flutter/material.dart';

class MoneyInput extends StatelessWidget {
  const MoneyInput({
    Key? key,
    required this.controller,
    required this.prefix,
    this.onClearInput,
    this.isEditingInput = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String prefix;
  final VoidCallback? onClearInput;
  final bool isEditingInput;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color darkBlue = const Color(0xFF1A173A);

    return TextField(
      controller: controller,
      readOnly: !isEditingInput,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surface,
        prefixIcon: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          child: Center(
            child: Text(
              prefix,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        suffixIcon: isEditingInput
            ? RoundedClickable(
          onTap: onClearInput,
          child: const DefaultPadding(
            child: Icon(Icons.close),
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
