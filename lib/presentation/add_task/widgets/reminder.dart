import 'package:flutter/material.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class ReminderForm extends StatefulWidget {
  const ReminderForm({required this.reminderCallback, Key? key})
      : super(key: key);

  final Function reminderCallback;
  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  String? _reminderValue;

  final List<String> reminderList = [
    StringsManager.rem1day,
    StringsManager.rem1hr,
    StringsManager.rem30m,
    StringsManager.rem10m
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: DoubleManager.value20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: DoubleManager.value8),
            child: Text(
              StringsManager.reminder,
              style: TextStyle(fontSize: DoubleManager.value17),
            ),
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              hintText: StringsManager.reminderHint,
            ),
            validator: (value) {
              if (value == null) {
                return StringsManager.reminderValidator;
              }
              return null;
            },
            onSaved: (newValue) => setState(() {
              widget.reminderCallback(newValue.toString());
            }),
            value: _reminderValue,
            items: reminderList
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _reminderValue = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
