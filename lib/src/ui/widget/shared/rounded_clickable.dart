import 'package:flutter/material.dart';

class RoundedClickable extends StatelessWidget {
  const RoundedClickable({
    Key? key,
    this.child,
    this.onTap,
  }) : super(key: key);

  final Widget? child;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black.withAlpha(25),
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
