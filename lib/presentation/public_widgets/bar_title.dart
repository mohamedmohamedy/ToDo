import 'package:flutter/material.dart';

import '../managers/strings.dart';
import '../managers/values.dart';

class BarTitle extends StatelessWidget {
  final String title;
  const BarTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: DoubleManager.value20),
      child: Text(
       title,
        style: const TextStyle(
            fontSize: DoubleManager.value25, fontWeight: FontWeight.w500, color: Colors.black,),
      ),
    );
  }
}
