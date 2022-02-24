import 'package:flutter/material.dart';
import 'package:notes_sqflite/database/notes_database.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    NotesDatabase.instance.test = "1";
    print(NotesDatabase.instance.test);
    NotesDatabase.instance.test = "2";
    print(NotesDatabase.instance.test);

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
