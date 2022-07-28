import 'package:flutter/material.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class StartEndTimeForms extends StatefulWidget {
  const StartEndTimeForms({
    required this.startTimeCallBack,
    required this.endTimeCallBack,
    required this.notificationTimeCallBack,
    Key? key,
  }) : super(key: key);

  final Function startTimeCallBack;
  final Function endTimeCallBack;
  final Function notificationTimeCallBack;

  @override
  State<StartEndTimeForms> createState() => _StartEndTimeFormsState();
}

class _StartEndTimeFormsState extends State<StartEndTimeForms> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //__________________________Start_____________________________________

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    bottom: DoubleManager.value8, top: DoubleManager.value20),
                child: Text(
                  StringsManager.start,
                  style: TextStyle(fontSize: DoubleManager.value17),
                ),
              ),
              TextFormField(
                controller: _startTimeController,
                onTap: () async {
                  String? time = await _pickStartTime();

                  setState(() {
                    _startTimeController.text = time!;
                  });
                },
                readOnly: true,
                onSaved: (newValue) => setState(() {
                  widget.startTimeCallBack(newValue);
                }),
                decoration: InputDecoration(
                  hintText: StringsManager.startHint,
                  contentPadding:
                      const EdgeInsets.only(left: DoubleManager.value15),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      String? time = await _pickStartTime();

                      setState(() {
                        _startTimeController.text = time!;
                      });
                    },
                    icon: const Icon(Icons.alarm),
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return StringsManager.startTimeValidator;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        //________________________________Divider______________________________
        const SizedBox(
          width: DoubleManager.value20,
        ),
        //________________________________End___________________________________
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    bottom: DoubleManager.value8, top: DoubleManager.value20),
                child: Text(
                  StringsManager.end,
                  style: TextStyle(fontSize: DoubleManager.value17),
                ),
              ),
              TextFormField(
                controller: _endTimeController,
                onTap: () async {
                  String? time = await _pickEndTime();

                  setState(() {
                    _endTimeController.text = time!;
                  });
                },
                readOnly: true,
                onSaved: (newValue) => setState(() {
                  widget.endTimeCallBack(newValue);
                }),
                decoration: InputDecoration(
                  hintText: StringsManager.endHint,
                  contentPadding:
                      const EdgeInsets.only(left: DoubleManager.value15),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      String? time = await _pickEndTime();

                      setState(() {
                        _startTimeController.text = time!;
                      });
                    },
                    icon: const Icon(Icons.alarm),
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return StringsManager.endTimeValidator;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //____________________________________________
  // pick start time
  Future<String?> _pickStartTime() async {
    TimeOfDay? pickedTime;
    pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    // ignore: use_build_context_synchronously
    String time = pickedTime!.format(context);
    setState(() {
      widget.notificationTimeCallBack(pickedTime);
    });
    debugPrint(time);

    return time;
  }

  // pick end time
  Future<String?> _pickEndTime() async {
    TimeOfDay? pickedTime;
    pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    // ignore: use_build_context_synchronously
    String time = pickedTime!.format(context);
    debugPrint(time);

    return time;
  }
}
