// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';
import '../widget/note_card_widget.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;
  Client client = http.Client();
  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);

    final db = await NotesDatabase.instance.database;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var getData =
            await http.get(Uri.parse('http://192.168.0.194:8000/notes/'));
        var response = jsonDecode(getData.body);
        print('connected');
        List responseList = [];
        for (var i = 0; i < response.length; i++) {
          responseList.add(response[i]['id']);
        }
        final dbSelect = await db.rawQuery('''
        SELECT * FROM $tableNotes
        ''');
        final ok = dbSelect.toList();
        List listId = [];

        for (var i = 0; i < ok.length; i++) {
          String id = ok[i]['_id'].toString();
          String title = ok[i]['title'].toString();
          String isImportant = ok[i]['isImportant'].toString();
          String number = ok[i]['number'].toString();
          String description = ok[i]['description'].toString();
          String createdTime = ok[i]['time'].toString();
          if (responseList.contains(id)) {
            final body = {
              "title": title,
              "isImportant": isImportant,
              "number": number,
              "description": description,
            };
            updateUrl(ids) {
              return 'http://192.168.0.194:8000/notes/$ids/update/';
            }

            await http.put(Uri.parse(updateUrl(id)), body: body);

            listId.add(id);

            continue;
          }

          deleteUrl(String ids) {
            return 'http://192.168.0.194:8000/notes/$ids/delete/';
          }

          List notlistId = responseList
              .where((element) => !listId.contains(element))
              .toList();

          for (var element in notlistId) {
            await http.delete(Uri.parse(deleteUrl(element)));
          }

          final body = {
            "id": id,
            "title": title,
            "isImportant": isImportant,
            "number": number,
            "description": description,
            "createdTime": createdTime,
          };
          await http.post(Uri.parse('http://192.168.0.194:8000/notes/create/'),
              body: body);
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddEditNotePage(
                        client: client,
                      )),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
