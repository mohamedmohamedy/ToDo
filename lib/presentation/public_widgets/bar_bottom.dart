import 'package:flutter/material.dart';

import 'divider.dart';


class BarBottomHelper extends StatelessWidget {
  final Widget child;
  const BarBottomHelper({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PublicDivider(),
        child,
        const PublicDivider(),
      ],
    );
  }
}
