import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../managers/strings.dart';
import '../../managers/values.dart';

class DateForm extends StatefulWidget {
  const DateForm(
      {required this.dateCallback,
      required this.notificationCallback,
      Key? key})
      : super(key: key);

  final Function dateCallback;

  //_____________________________________________________________________
  final Function notificationCallback;

  @override
  State<DateForm> createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {
  final TextEditingController _dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
              bottom: DoubleManager.value8, top: DoubleManager.value20),
          child: Text(
            StringsManager.date,
            style: TextStyle(fontSize: DoubleManager.value17),
          ),
        ),
        TextFormField(
          controller: _dateInput,
          readOnly: true,
          onTap: () => _pickDate(),
          onSaved: (value) => setState(() {
            widget.dateCallback(value);
          }),
          decoration: InputDecoration(
            hintText: StringsManager.dateHint,
            suffixIcon: IconButton(
              onPressed: () => _pickDate(),
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return StringsManager.dateValidator;
            }
            return null;
          },
        )
      ],
    );
  }

  //______________________Helper functions___________________________________

  // pick Date
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
    setState(() {
      widget.notificationCallback(pickedDate);
      _dateInput.text = formattedDate;
    });
  }
}
