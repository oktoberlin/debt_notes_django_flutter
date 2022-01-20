// ignore_for_file: avoid_print

//import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import '../widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Client client;
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
    required this.client,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late int id;
  late String theBorrower;
  late String borrowerType;
  late int nominal;
  late String description;
  late String dateBorrowed;
  late String timeBorrowed;
  final bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    id = widget.note?.id ?? 0;
    theBorrower = widget.note?.theBorrower ?? '';
    borrowerType = widget.note?.borrowerType ?? 'Karyawan';
    nominal = widget.note?.nominal ?? 0;
    description = widget.note?.description ?? '';
    dateBorrowed = widget.note?.dateBorrowed ?? '';
    timeBorrowed = widget.note?.timeBorrowed ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Create Note'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              key: _formKey,
              children: [
                NoteFormWidget(
                  id: id,
                  theBorrower: theBorrower,
                  borrowerType: borrowerType,
                  nominal: nominal,
                  description: description,
                  dateBorrowed: dateBorrowed,
                  timeBorrowed: timeBorrowed,
                  onChangedTheBorrower: (theBorrower) =>
                      setState(() => this.theBorrower = theBorrower),
                  onChangedBorrowerType: (borrowerType) =>
                      setState(() => this.borrowerType = borrowerType),
                  onChangedNominal: (nominal) =>
                      setState(() => this.nominal = nominal),
                  onChangedDescription: (description) =>
                      setState(() => this.description = description),
                  onChangedDateBorrowed: (dateBorrowed) =>
                      setState(() => this.dateBorrowed = dateBorrowed),
                  onChangedTimeBorrowed: (timeBorrowed) =>
                      setState(() => this.timeBorrowed = timeBorrowed),
                ),
                const SizedBox(height: 15.0),
                ElevatedButton.icon(
                  icon: _isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.post_add),
                  label: Text(
                    _isLoading ? '' : 'Create',
                    style: const TextStyle(fontSize: 15),
                  ),
                  onPressed: addOrUpdateNote,
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                )
              ],
            ),
          ),
        ),
      );

/*
  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }
*/
  void addOrUpdateNote() async {
    final isUpdating = widget.note != null;

    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
    }

    Navigator.of(context, rootNavigator: true).pop();
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      theBorrower: theBorrower,
      borrowerType: borrowerType,
      nominal: nominal,
      description: description,
      dateBorrowed: dateBorrowed,
      timeBorrowed: timeBorrowed,
    );

    await NotesDatabase.instance.update(note);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final body = {
          "theBorrower": note.theBorrower,
          "borrowerType": note.borrowerType,
          "nominal": "${note.nominal}",
          "description": note.description,
          "date_borrowed": note.dateBorrowed,
          "time_borrowed": note.timeBorrowed,
        };

        updateUrl(int ids) {
          return 'http://192.168.0.194:8000/notes/$ids/update/';
        }

        await http.put(Uri.parse(updateUrl(id)), body: body);
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future addNote() async {
    DateTime now = DateTime.now();

    String date = DateFormat('yyyy-MM-dd').format(now);

    String time = DateFormat('HH:mm:ss').format(now);

    final note = Note(
      theBorrower: theBorrower,
      borrowerType: borrowerType,
      nominal: nominal,
      description: description,
      dateBorrowed: date.toString(),
      timeBorrowed: time.toString(),
    );
    print(note.theBorrower);

    await NotesDatabase.instance.create(note);
  }
}
