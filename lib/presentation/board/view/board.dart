import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubit/cubit.dart';
import '../../../data/cubit/states.dart';

import '../widgets/button.dart';
import '../widgets/appbar.dart';
import '../widgets/completed_tasks.dart';
import '../widgets/favorite_tasks.dart';
import '../widgets/uncompleted_tasks.dart';
import '../widgets/all_tasks.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class BoardScreen extends StatelessWidget {
  static const routeName = RoutesName.boardView;
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) => DefaultTabController(
        initialIndex: IntManager.value0,
        length: IntManager.value4,
        child: Scaffold(
          appBar: getAppBar(context),
          body: getBody,
        ),
      ),
    );
  }

  //____________________________Structure and Helper Functions__________________________________________

  // App bar
  PreferredSize getAppBar(BuildContext context) {
    return const PreferredSize(
        preferredSize: Size.fromHeight(DoubleManager.value180),
        child: BoardAppBar());
  }

  // body
  Widget get getBody {
    return Stack(
      children: [
        TabBarView(
          children: [
            AllTasks(),
            const CompletedTasks(),
            const UnCompletedTasks(),
            const FavoriteTasks(),
          ],
        ),
        const boardButton(),
      ],
    );
  }
}
