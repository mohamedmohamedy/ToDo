import 'package:flutter/material.dart';

import '../../public_widgets/extensions.dart';
import '../../managers/values.dart';

class TasksListTexts extends StatelessWidget {
  const TasksListTexts({
    Key? key,
    required this.tasks,
    required this.index,
  }) : super(key: key);

  final List<Map> tasks;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DoubleManager.value17),
      child: Text(
        tasks[index]['title'],
        style: TextStyle(
          fontSize: DoubleManager.value20,
          color: "${tasks[index]['color']}".toColor(),
        ),
      ),
    );
  }
}
