import 'package:notes_sqflite/models/note.dart';
import 'package:sqflite/sqflite.dart';

const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const String textType = 'TEXT NOT NULL';
const String boolType = 'BOOLEAN NOT NULL';
const String integerType = 'INTEGER NOT NULL';

class NotesDatabase {

  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  String test = "";

  Future<Database?> get database async {

    if(_database != null) return _database!;

    _database = await _initDB('notes.db');

    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(
        filePath,
        version: 1,
        onCreate: _createDB
    );
  }

  Future<void> _createDB(Database db, int version) async {

    await db.execute(
        '''
        CREATE TABLE $tableNotes (
          ${NoteFields.id} $idType,
          ${NoteFields.isImportant} $boolType,
          ${NoteFields.number} $integerType,
          ${NoteFields.title} $textType,
          ${NoteFields.description} $textType,
          ${NoteFields.createdTime} $textType,
        )
        '''
    );

  }

  Future<Note> createNote(Note note) async {
    final db = await instance.database;
    final id = await db!.insert(tableNotes, note.toJson());
    return note.copyWith(id: id);
  }


  Future<Note> readNote(int id) async {

    final db = await instance.database;

    final maps = await db!.query(
        tableNotes,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){

      return Note.fromJson(maps.first);

    } else {
      throw Exception('id $id not found');
    }

  }

  Future<List<Note>> readAllNotes() async {

    final db = await instance.database;

    const String orderBy = '${NoteFields.createdTime} ASC';
    // final result =
    //  await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db!.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();

  }

  Future<int> updateNote(Note note) async {

    final db = await instance.database;

    return db!.update(
        tableNotes,
        note.toJson(),
        where: '${NoteFields.id} = ?',
       whereArgs: [note.id]
    );

  }

  Future<int> deleteNote(int id) async {

    final db = await instance.database;

    return await db!.delete(
      tableNotes,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]
    );

  }

  Future<void> close() async {
    final db = await instance.database;
    db!.close();
  }

}