import 'dart:math';

import 'package:flutter/material.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class TitleForm extends StatefulWidget {
  const TitleForm(
      {required this.titleCallback, required this.colorCallback, Key? key})
      : super(key: key);

  final Function titleCallback;
  final Function colorCallback;

  @override
  State<TitleForm> createState() => _TitleFormState();
}

class _TitleFormState extends State<TitleForm> {
  final Color _randomColor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  String? _taskColor;

  void _convertColorToString() {
    _taskColor = _randomColor
        .toString()
        .replaceAll(RegExp('[MaterialColor(primary value: Color()]'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: DoubleManager.value12),
          child: Text(
            StringsManager.title,
            style: TextStyle(fontSize: DoubleManager.value17),
          ),
        ),
        TextFormField(
          onSaved: (newValue) => setState(() {
            widget.titleCallback(newValue);
            _convertColorToString();
            widget.colorCallback(_taskColor);
          }),
          decoration: const InputDecoration(
            hintText: StringsManager.titleHint,
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return StringsManager.titleValidator;
            }
            return null;
          },
        ),
      ],
    );
  }
}
