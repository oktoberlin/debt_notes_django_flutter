// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NoteFormWidget extends StatefulWidget {
  final int id;
  final String? theBorrower;
  final String? borrowerType;
  final int? nominal;
  final String? description;
  late String? dateBorrowed;
  final String? timeBorrowed;
  final ValueChanged<String> onChangedTheBorrower;
  final ValueChanged<String> onChangedBorrowerType;
  late final ValueChanged<int> onChangedNominal;
  final ValueChanged<String> onChangedDescription;
  late ValueChanged<String> onChangedDateBorrowed;
  final ValueChanged<String> onChangedTimeBorrowed;

  NoteFormWidget(
      {Key? key,
      required this.id,
      this.theBorrower = '',
      this.borrowerType = '',
      this.nominal = 0,
      this.description = '',
      this.dateBorrowed = '',
      this.timeBorrowed = '',
      required this.onChangedTheBorrower,
      required this.onChangedBorrowerType,
      required this.onChangedNominal,
      required this.onChangedDescription,
      required this.onChangedDateBorrowed,
      required this.onChangedTimeBorrowed})
      : super(key: key);

  @override
  State<NoteFormWidget> createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
/*
  @override
  State<NoteFormWidget> createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  /*
  TextEditingController onChangedTheBorrower = TextEditingController();
  late String onChangedBorrowerType = 'Karyawan';
  TextEditingController onChangedNominal = TextEditingController();
  TextEditingController onChangedDescription = TextEditingController();
  TextEditingController onChangedDateBorrowed = TextEditingController();
  TextEditingController onChangedTimeBorrowed = TextEditingController();
  */
  @override
  void initState() {
    /*
    onChangedTheBorrower = TextEditingController(text: widget.theBorrower);
    onChangedBorrowerType = widget.borrowerType!;
    print(onChangedBorrowerType);
    onChangedNominal = TextEditingController(text: widget.nominal.toString());
    onChangedDescription = TextEditingController(text: widget.description);
    onChangedDateBorrowed = TextEditingController(text: widget.dateBorrowed);
    onChangedTimeBorrowed = TextEditingController(text: widget.timeBorrowed);
    */
    super.initState();
  }
*/
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: widget.theBorrower,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.how_to_reg_rounded,
                      color: Colors.blue,
                    ),
                    labelText: "Enter Name"),
                onChanged: widget.onChangedTheBorrower,
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(
                  left: 40,
                ),
                child: DropdownButton(
                  value: widget.borrowerType,
                  items: <String>[
                    'Karyawan',
                    'Non-Karyawan',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    widget.onChangedBorrowerType(value as String);
                  },
                  hint: const Text("Select item"),
                  disabledHint: const Text("Disabled"),
                  elevation: 20,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  iconDisabledColor: Colors.red,
                  iconEnabledColor: Colors.green,
                  isExpanded: true,
                ),
              ),
              TextFormField(
                initialValue: (widget.nominal).toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.pin_outlined,
                      color: Colors.blue,
                    ),
                    labelText: "Enter Nominal"),
                onChanged: (number) => widget.onChangedNominal(number as int),
                /*
                  setState(() {
                    widget.onChangedNominal = newValue! as ValueChanged<int?>;
                  });*/
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                initialValue: widget.description,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.text_fields_outlined,
                      color: Colors.blue,
                    ),
                    labelText: "Deskripsi"),
                onChanged: widget.onChangedDescription,
              ),
              TextFormField(
                initialValue: widget.dateBorrowed,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    labelText: "Enter Date"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    setState(() {
                      widget.dateBorrowed = formattedDate;
                    });
                  } else {
                    // ignore: avoid_print
                    print("Date is not selected");
                  }
                },
                onChanged: widget.onChangedDateBorrowed,
              ),
              TextFormField(
                initialValue: widget.timeBorrowed,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.timer,
                      color: Colors.blue,
                    ),
                    labelText: "Enter Time"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    /*
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());

                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    setState(() {
                      widget.onChangedTimeBorrowed =
                          formattedTime as ValueChanged<String>;
                    });*/
                  } else {
                    // ignore: avoid_print
                    print("Time is not selected");
                  }
                },
                onChanged: widget.onChangedTimeBorrowed,
              ),
            ],
          ),
        ),
      );
}
