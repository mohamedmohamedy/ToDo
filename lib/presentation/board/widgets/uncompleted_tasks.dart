import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubit/cubit.dart';
import '../../../data/cubit/states.dart';

import '../../managers/values.dart';
import '../../managers/strings.dart';

import '../widgets/text_style.dart';

class UnCompletedTasks extends StatelessWidget {
  const UnCompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tasks = TasksCubit.get(context).uncompletedTasks;

    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(DoubleManager.value15),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: tasks.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TasksListTexts(tasks: tasks, index: index),
              Text('${StringsManager.at} ${tasks[index]['startTime']}')
            ],
          ),
        ),
      ),
    );
  }
}
