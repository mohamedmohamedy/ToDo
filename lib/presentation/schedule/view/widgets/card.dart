import 'package:flutter/material.dart';

import '../../../public_widgets/extensions.dart';
import '../../../managers/values.dart';

class CardHelper extends StatelessWidget {
  const CardHelper({
    Key? key,
    required this.tasks,
    required this.index,
  }) : super(key: key);

  final List<Map> tasks;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: "${tasks[index]['color']}".toColor(),
      child: Padding(
        padding: const EdgeInsets.all(DoubleManager.value20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tasks[index]['startTime'],
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: DoubleManager.value12,
                ),
                Text(
                  tasks[index]['title'],
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            getIconShape(),
          ],
        ),
      ),
    );
  }

//___________________________________Helper functions__________________________
  Icon getIconShape() {
    return Icon(
      tasks[index]['completed'] == 'false'
          ? (Icons.check_circle_outline_sharp)
          : (Icons.check_circle),
      color: Colors.white,
    );
  }
}
