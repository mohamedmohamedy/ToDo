import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './data/cubit/cubit.dart';

import './application/themes/app_theme.dart';

import './presentation/board/view/board.dart';
import './presentation/schedule/view/schedule.dart';
import './presentation/add_task/view/add_new_task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit()..initialDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo',
        theme: getAppTheme(),
        initialRoute: BoardScreen.routeName,
        routes: {
          BoardScreen.routeName: (context) => const BoardScreen(),
          AddNewTaskScreen.routeName: (context) => const AddNewTaskScreen(),
          ScheduleScreen.routeName: (context) => const ScheduleScreen(),
        },
      ),
    );
  }
}
