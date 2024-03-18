import 'package:local_database/models/note_model.dart';
import 'package:local_database/screens/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:local_database/screens/user.dart';


class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "CompanyHiringDB.db";
   final Uri _url = Uri.parse("https://www.core2web.in");
  static int count = 0;

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Note (

            JobId TEXT PRIMARY KEY ,
            company TEXT,
            jobRole TEXT,
            jd TEXT,
            id INTEGER AUTOINCREMENT
          )
        ''');
      },
      version: _version,
    );
  }

  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    // Format the company value before inserting
    String companyEdit = "company : ${note.company}";
    String jobRoleEdit = "Job Role : ${note.jobRole}";
    String jobIdEdit = "Job Id : ${note.jobId}";
    String jdEdit = "Job Description : ${note.jdis}";

    // Create a new Note object with the formatted company value
    Note formattedNote = Note(
      id: note.id,

      company: companyEdit,
      jobRole: jobRoleEdit,
      jobId: jobIdEdit,
      jdis: jdEdit,
    );
    //print(note.id);
    print(note.company);
    print(note.jobRole);
    print(note.jobId);
    print(note.jdis);
    // Insert the formatted note into the database
    int id = await db.insert(
      "Note",
      formattedNote.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      
    );
    return id;
  }

  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update(
      "Note",
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<Note>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }

  static Future<Widget> getApplicantsButton(int id) async {
    return Future.value(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle button onPressed event
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 210, 102, 186),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 210, 102, 186),
                ),
                fixedSize: const MaterialStatePropertyAll(Size(200, 50))),
            child: const Text(
              "Get Applicants",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10), // Add spacing above the divider
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          const SizedBox(height: 10), //
        ],
      ),
    );
  }

   Future<Widget> getApplyButton(int id) async {
    return Future.value(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              
              count++;
                
              
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 210, 102, 186),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 210, 102, 186),
                ),
                fixedSize: const MaterialStatePropertyAll(Size(200, 50))),
            child: const Text(
              "Apply",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10), // Add spacing above the divider
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          const SizedBox(height: 10), //
        ],
      ),
    );
  }

  void navigateToUserHomeScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserHomeScreen(),
    ),
  );
}


   Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class WebPage {
}
