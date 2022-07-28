import 'package:flutter/material.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class RepeaterForm extends StatefulWidget {
  const RepeaterForm({required this.repeaterCallback, Key? key})
      : super(key: key);

  final Function repeaterCallback;
  @override
  State<RepeaterForm> createState() => _RepeaterFormState();
}

class _RepeaterFormState extends State<RepeaterForm> {
  String? _repeaterValue;

  final List<String> repeaterList = [
    StringsManager.never,
    StringsManager.repMonthly,
    StringsManager.repWeekly,
    StringsManager.repDaily,
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
              StringsManager.repeater,
              style: TextStyle(fontSize: DoubleManager.value17),
            ),
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              hintText: StringsManager.repeater,
            ),
            validator: (value) {
              if (value == null) {
                return StringsManager.repeaterValidator;
              }
              return null;
            },
            onSaved: (newValue) => setState(() {
              widget.repeaterCallback(newValue.toString());
            }),
            value: _repeaterValue,
            items: repeaterList
                .map((label) => DropdownMenuItem(
                      value: label,
                      child: Text(label),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _repeaterValue = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
