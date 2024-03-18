import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage {
  static const int _version = 1;
  static const String _dbName = "UserDB.db";
  static Uri  URL = Uri.parse("https://www.core2web.in"); 


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

  

  static Future<Widget> getApplyButton(int id) async {
    return Future.value(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle button onPressed event
              launchUrl( URL); // Launch the URL
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

  static Future<void> _launchUrl() async {
  if (!await launchUrl(URL)) {
    throw Exception('Could not launch $URL');
  }
}
}
