import 'package:flutter/material.dart';

class DefaultSpacer extends StatelessWidget {
  const DefaultSpacer({
    Key? key,
    this.multiplier = 1,
  }) : super(key: key);

  final double multiplier;
  final double defaultSpace = 16;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultSpace * multiplier,
      width: defaultSpace * multiplier,
    );
  }
}
