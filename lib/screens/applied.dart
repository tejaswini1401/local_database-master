import 'package:flutter/material.dart';
import 'package:local_database/screens/notes_screen.dart';
import 'package:local_database/screens/user.dart';

class SuccessScreenRec extends StatefulWidget {
  const SuccessScreenRec({Key? key}) : super(key: key);

  @override
  State<SuccessScreenRec> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreenRec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                "assets/traced-done.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'You are Successfully Applied for this job ',
                    style: TextStyle(
                        fontFamily: 'MyUniqueFont',
                        fontSize: 19,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ]),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 244, 53, 171),
                    ),
                    fixedSize: MaterialStatePropertyAll(
                        Size(MediaQuery.of(context).size.width * 0.6, 50))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const UserScreen()),
                    ),
                  ); ////<---
                },
                child: const Text(
                  'Continue  →',
                  style: TextStyle(
                      fontFamily: 'MyUniqueFont',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
