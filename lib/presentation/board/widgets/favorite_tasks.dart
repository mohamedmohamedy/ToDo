import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubit/cubit.dart';
import '../../../data/cubit/states.dart';

import '../../managers/values.dart';
import '../widgets/text_style.dart';
import '../../public_widgets/extensions.dart';

class FavoriteTasks extends StatefulWidget {
  const FavoriteTasks({Key? key}) : super(key: key);

  @override
  State<FavoriteTasks> createState() => _FavoriteTasksState();
}

class _FavoriteTasksState extends State<FavoriteTasks> {
  @override
  Widget build(BuildContext context) {
    var tasks = TasksCubit.get(context).favoriteTasks;

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
              IconButton(
                onPressed: () => setState(() {
                  TasksCubit.get(context)
                      .removeFromFavorites(tasks[index]['id']);
                }),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: DoubleManager.value30,
                  color: "${tasks[index]['color']}".toColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
