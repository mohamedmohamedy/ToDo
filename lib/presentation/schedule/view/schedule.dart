import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';

import '.././../../data/cubit/cubit.dart';
import '.././../../data/cubit/states.dart';

import '../../public_widgets/bar_bottom.dart';
import '../../public_widgets/bar_title.dart';
import '../../public_widgets/back_button.dart';

import './widgets/card.dart';
import '../../public_widgets/image.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';
import '../../managers/colors.dart';

class ScheduleScreen extends StatefulWidget {
  static const String routeName = RoutesName.scheduleView;
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleScreen> {
  DateTime? _selectedDate;
  String _formattedDate = DateFormat('d MMM, y').format(DateTime.now());
  String _formattedDay = DateFormat('EEEE').format(DateTime.now());
  String _comparingDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final tasks = TasksCubit.get(context).dataTasks(_comparingDate);

    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: _getAppBar,
        body: _getBody(tasks),
      ),
    );
  }

  //____________________________Structure and Helper Functions__________________________________________

  // App Bar
  AppBar get _getAppBar {
    return AppBar(
      leading: const BarBackButton(),
      title: const BarTitle(title: StringsManager.schedule),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(DoubleManager.value80),
        child: BarBottomHelper(
          child: _datePicker,
        ),
      ),
    );
  }

  // body
  Widget _getBody(List<Map> tasks) {
    return tasks.isEmpty ? getNoTasksImage : getBodyBuilder(tasks);
  }

// no tasks image
  Widget get getNoTasksImage {
    return const NoTasksImage();
  }

// body builder

  Widget getBodyBuilder(List<Map> tasks) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: DoubleManager.value30, vertical: DoubleManager.value12),
      child: Column(
        children: [
          _headline,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) => CardHelper(
                tasks: tasks,
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Date picker
  Widget get _datePicker {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DoubleManager.value30),
      child: DatePicker(
        DateTime.now(),
        height: DoubleManager.value75,
        width: DoubleManager.value50,
        dateTextStyle: const TextStyle(fontSize: DoubleManager.value15),
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorsManager.buttonColor,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
            _formattedDate = DateFormat('d MMM, y').format(_selectedDate!);
            _formattedDay = DateFormat('EEEE').format(_selectedDate!);
            _comparingDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
          });
        },
      ),
    );
  }

  // Day name and day date
  Widget get _headline {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formattedDay,
          style: const TextStyle(
              fontSize: DoubleManager.value18, fontWeight: FontWeight.w500),
        ),
        Text(
          _formattedDate,
          style: const TextStyle(fontSize: DoubleManager.value15),
        ),
      ],
    );
  }
}
