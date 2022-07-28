import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubit/cubit.dart';
import '../../../data/cubit/states.dart';

import '../../managers/values.dart';

import '../widgets/text_style.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tasks = TasksCubit.get(context).completedTasks;

    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(DoubleManager.value15),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: tasks.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) =>
              TasksListTexts(tasks: tasks, index: index),
        ),
      ),
    );
  }
}
