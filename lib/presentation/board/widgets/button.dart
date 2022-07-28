import 'package:flutter/material.dart';

import '../../add_task/view/add_new_task.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';


class boardButton extends StatelessWidget {
  const boardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(DoubleManager.value20),
        height: DoubleManager.value50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () => Navigator.of(context)
              .pushNamed(AddNewTaskScreen.routeName),
          child: const Text(StringsManager.addTask),
        ),
      ),
    );
  }
}