import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';

import '../../../data/cubit/cubit.dart';
import '../../../data/cubit/states.dart';

import '../../../models/task.dart';

import '../../../application/services/notification_api.dart';
import '../../schedule/view/schedule.dart';

import '../../public_widgets/back_button.dart';
import '../../public_widgets/bar_title.dart';

import '../widgets/title.dart';
import '../widgets/date.dart';
import '../widgets/reminder.dart';
import '../widgets/repeater.dart';
import '../widgets/indicator.dart';
import '../widgets/start_end_time.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class AddNewTaskScreen extends StatefulWidget {
  static const String routeName = RoutesName.addNewTaskView;
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // model
  var _newTask = TaskModel(
    title: '',
    startTime: '',
    endTime: '',
    date: '',
    reminder: '',
    repeat: '',
    color: '',
    favorite: 'false',
    completed: 'false',
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: _getAppBar,
        body: _getBody,
      ),
    );
  }
  //______________________________Structure____________________________________________________

// App bar
  AppBar get _getAppBar {
    return AppBar(
      leading: const BarBackButton(),
      toolbarHeight: DoubleManager.value100,
      title: const BarTitle(title: StringsManager.addTask),
    );
  }

// Body
  Widget get _getBody {
    return _isLoading ? _getLoadingIndicator : _getBodyBuilder;
  }

// loading indicator
  Widget get _getLoadingIndicator {
    return const LoadingIndicator();
  }

// body builder
  Widget get _getBodyBuilder {
    return Padding(
      padding: const EdgeInsets.all(DoubleManager.value25),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            _getTitleForm,
            _getDateForm,
            _getStartAndEndTimeForms,
            _getReminderForm,
            _getRepeaterForm,
            _getButton,
          ],
        ),
      ),
    );
  }

// title
  Widget get _getTitleForm {
    return TitleForm(
      titleCallback: (value) {
        setState(() {
          _newTask = TaskModel(
              title: value,
              startTime: _newTask.startTime,
              endTime: _newTask.endTime,
              date: _newTask.date,
              reminder: _newTask.reminder,
              repeat: _newTask.repeat,
              color: _newTask.color);
        });
      },
      colorCallback: (value) {
        setState(() {
          _newTask = TaskModel(
              title: _newTask.title,
              startTime: _newTask.startTime,
              endTime: _newTask.endTime,
              date: _newTask.date,
              reminder: _newTask.reminder,
              repeat: _newTask.repeat,
              color: value);
        });
      },
    );
  }

  // Date
  Widget get _getDateForm {
    return DateForm(

        //get DateTime for notification alarm
        notificationCallback: (value) {
      setState(() {
        addNotificationTime = value;
      });
    }, dateCallback: (value) {
      setState(() {
        _newTask = TaskModel(
            title: _newTask.title,
            startTime: _newTask.startTime,
            endTime: _newTask.endTime,
            date: value,
            reminder: _newTask.reminder,
            repeat: _newTask.repeat,
            color: _newTask.color);
      });
    });
  }

  // Start and End time
  Widget get _getStartAndEndTimeForms {
    return StartEndTimeForms(

      // listener for start time in TimeOfDay format to use with notification method.
      notificationTimeCallBack: (value) {
        setState(() {
          startTimeCall = value;
          addNotificationTime = DateTime(
              addNotificationTime!.year,
              addNotificationTime!.month,
              addNotificationTime!.day,
              startTimeCall!.hour,
              startTimeCall!.minute);
        });
      },
      startTimeCallBack: (value) {
        setState(() {
          _newTask = TaskModel(
              title: _newTask.title,
              startTime: value,
              endTime: _newTask.endTime,
              date: _newTask.date,
              reminder: _newTask.reminder,
              repeat: _newTask.repeat,
              color: _newTask.color);
        });
      },
      endTimeCallBack: (value) {
        setState(() {
          _newTask = TaskModel(
              title: _newTask.title,
              startTime: _newTask.startTime,
              endTime: value,
              date: _newTask.date,
              reminder: _newTask.reminder,
              repeat: _newTask.repeat,
              color: _newTask.color);
        });
      },
    );
  }

  // Reminder
  Widget get _getReminderForm {
    return ReminderForm(
      reminderCallback: (value) {
        setState(() {
          _newTask = TaskModel(
              title: _newTask.title,
              startTime: _newTask.startTime,
              endTime: _newTask.endTime,
              date: _newTask.date,
              reminder: value,
              repeat: _newTask.repeat,
              color: _newTask.color);
        });
      },
    );
  }

  // Repeater
  Widget get _getRepeaterForm {
    return RepeaterForm(
      repeaterCallback: (value) {
        setState(() {
          _newTask = TaskModel(
              title: _newTask.title,
              startTime: _newTask.startTime,
              endTime: _newTask.endTime,
              date: _newTask.date,
              reminder: _newTask.reminder,
              repeat: value,
              color: _newTask.color);
        });
      },
    );
  }

// Button
  Widget get _getButton {
    return Container(
      padding: const EdgeInsets.only(top: DoubleManager.value20),
      height: DoubleManager.value70,
      child: ElevatedButton(
        onPressed: () => _saveForm(),
        child: const Text(StringsManager.createTask),
      ),
    );
  }

  // save form
  Future<void> _saveForm() async {
    setState(() {
      _isLoading = true;
    });

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        _isLoading = false;
        return;
      });
    }

    formKey.currentState!.save();
    try {
      await TasksCubit.get(context).insertIntoDatabase(_newTask);
    } catch (error) {
      _getErrorDialogue;
    }

    // set notification alarm
    NotificationApi.showScheduledNotification(
      title: 'ToDo',
      body: _newTask.title,
      payload: _newTask.title,
      scheduleDate: notificationReminder,
    );

    setState(() {
      _isLoading = false;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  // error dialogue
  Future<void> _getErrorDialogue() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(StringsManager.errorOccurred),
        content: const Text(StringsManager.dialogueMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(StringsManager.okay))
        ],
      ),
    );
  }

  //_______________________building notification alarm_______________________________________________________

  void listenOnNotification() =>
      NotificationApi.onNotification.stream.listen((onClickNotification));

  void onClickNotification(String? payload) =>
      Navigator.of(context).pushNamed(ScheduleScreen.routeName);

  DateTime? addNotificationTime;
  TimeOfDay? startTimeCall;

  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
    NotificationApi.init(initScheduled: true);
    listenOnNotification();
  }

  DateTime get notificationReminder {
    if (_newTask.reminder == StringsManager.rem1day) {
      return addNotificationTime!
          .subtract(const Duration(hours: IntManager.value24));
    } else if (_newTask.reminder == StringsManager.rem1hr) {
      return addNotificationTime!
          .subtract(const Duration(hours: IntManager.value1));
    } else if (_newTask.reminder == StringsManager.rem30m) {
      return addNotificationTime!
          .subtract(const Duration(minutes: IntManager.value30));
    } else if (_newTask.reminder == StringsManager.rem10m) {
      return addNotificationTime!
          .subtract(const Duration(minutes: IntManager.value10));
    }
    return DateTime.now();
  }
}
