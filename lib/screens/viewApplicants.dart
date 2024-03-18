import 'package:flutter/material.dart';


Future<ElevatedButton> getApplicants(int id) async {
  
    return ElevatedButton(

               onPressed: () {
                },

                style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color:  Color.fromARGB(255, 210, 102, 186),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll( Color.fromARGB(255, 210, 102, 186),)
                          ),
              
                child: const Text("View Applicants",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                        ),),
                  );
  }
