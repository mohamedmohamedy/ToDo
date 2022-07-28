import 'package:flutter/material.dart';

import '../managers/values.dart';

class BarBackButton extends StatelessWidget {
  const BarBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: DoubleManager.value20),
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new, size: DoubleManager.value17),
      ),
    );
  }
}
