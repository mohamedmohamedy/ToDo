import 'package:flutter/material.dart';

import '../managers/values.dart';

class PublicDivider extends StatelessWidget {
  const PublicDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(height: DoubleManager.value30, thickness: DoubleManager.value_7);
  }
}