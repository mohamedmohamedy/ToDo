import 'package:flutter/material.dart';

import '../managers/strings.dart';

class NoTasksImage extends StatelessWidget {
  const NoTasksImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(StringsManager.noTasks),
      );
  }
}