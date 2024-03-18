import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/note_model.dart';
import '../../services/database_helper.dart';
import '../../widgets/note_widget.dart';
import './note_screen.dart';
import './user_profile.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _selectedIndex = 0;

  final  List<Widget> _widgetOptions = <Widget>[
    UserHomeScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  'Hello ,',
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
      body: _widgetOptions.elementAt(_selectedIndex),

 bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          const Icon(CupertinoIcons.home, size: 30, color: Colors.black45),
          
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UserProfileScreen()),
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

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
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
                          // Assuming you want to refresh the list after returning from NoteScreen
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
                        future: DatabaseHelper().getApplyButton(note.id!),
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
    );
  }
}

