import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubit/cubit.dart';
import '../../../data/cubit/states.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';
import '../../public_widgets/extensions.dart';
import '../../public_widgets/image.dart';

class AllTasks extends StatelessWidget {
  AllTasks({Key? key}) : super(key: key);

  final List popupMenu = <String>[
    StringsManager.markAsCompleted,
    StringsManager.deleteTask,
    StringsManager.addToFavorites,
  ];

  @override
  Widget build(BuildContext context) {
    var tasks = TasksCubit.get(context).tasksData;

    return BlocConsumer<TasksCubit, TasksStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            tasks.isEmpty ? getNoTasksImage : getBodyBuilder(tasks));
  }

  //____________________________Structure and Helper Functions__________________________________________

// body builder
  Widget getBodyBuilder(List<Map> tasks) {
    return Padding(
      padding: const EdgeInsets.all(DoubleManager.value15),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => Row(
          children: [
            IconButton(
              onPressed: () => pressIcon(tasks, index, context),
              icon: iconGetter(tasks, index),
            ),
            const SizedBox(width: DoubleManager.value15),
            Text(
              tasks[index]['title'],
              style: const TextStyle(fontSize: DoubleManager.value20),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                onSelected: (item) =>
                    onSelectPopupMenu(item, index, context, tasks),
                itemBuilder: (context) {
                  return popupMenu.map((choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// no tasks image
  Widget get getNoTasksImage {
    return const NoTasksImage();
  }

  // function for pressing
  void pressIcon(List<Map> tasks, int index, BuildContext context) {
    {
      if (tasks[index]['completed'] == 'false') {
        TasksCubit.get(context).markAsCompleted(tasks[index]['id']);
      } else {
        TasksCubit.get(context).markAsUnCompleted(tasks[index]['id']);
      }
    }
  }

  // icon shape function
  Icon iconGetter(List<Map> tasks, int index) {
    return tasks[index]['completed'] == 'false'
        ? Icon(
            Icons.check_box_outline_blank_rounded,
            color: "${tasks[index]['color']}".toColor(),
            size: DoubleManager.value30,
          )
        : Icon(
            Icons.check_box_rounded,
            color: "${tasks[index]['color']}".toColor(),
            size: DoubleManager.value30,
          );
  }

  // menu list for popup
  void onSelectPopupMenu(item, index, BuildContext context, List<Map> tasks) {
    switch (item) {
      case StringsManager.markAsCompleted:
        TasksCubit.get(context).markAsCompleted(tasks[index]['id']);
        break;
      case StringsManager.deleteTask:
        TasksCubit.get(context).deleteTask(tasks[index]['id']);
        break;
      case StringsManager.addToFavorites:
        TasksCubit.get(context).markAsFavorite(tasks[index]['id']);
        break;
    }
  }
}
