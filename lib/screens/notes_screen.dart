import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_database/screens/RecUser_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../models/note_model.dart';
import '../services/database_helper.dart';
import '../widgets/note_widget.dart';
import 'note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'Hello Recruiter,',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Stack(children: [Text("")]),
            ],
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 210, 102, 186),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: FutureBuilder<List<Note>?>(
          future: DatabaseHelper.getAllNotes(),
          builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Note note = snapshot.data![index];
                    return Column(
                      children: [
                        NoteWidget(
                          note: note,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteScreen(
                                  note: note,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          onLongPress: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to delete this hiring?'),
                                  actions: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.red,
                                        ),
                                      ),
                                      onPressed: () async {
                                        await DatabaseHelper.deleteNote(note);
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        FutureBuilder<Widget>(
                          future: DatabaseHelper.getApplicantsButton(note.id!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else {
                              return snapshot.data ?? Container();
                            }
                          },
                        )
                      ],
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      /*bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color:  Color.fromARGB(255, 210, 102, 186),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 1) {
              // Navigate to the profile screen
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserProfileScreenRec()));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'Profile',
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 210, 102, 186),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 16,
          unselectedFontSize: 16,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          /*type: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),*/
        ),
      ),*/

      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          const Icon(CupertinoIcons.home, size: 30, color: Colors.black45),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoteScreen()),
              );
            },
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(CupertinoIcons.add, size: 30, color: Colors.black45),
                Text(
                  "Add Job",
                  style: TextStyle(color: Colors.black45),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfileScreenRec()),
              );
            },
            child: const Icon(
              CupertinoIcons.profile_circled,
              size: 30,
              color: Colors.black45,
            ),
          )
        ],
        color: const Color.fromARGB(255, 210, 102, 186),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            //_pageIndex = index;
            
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
