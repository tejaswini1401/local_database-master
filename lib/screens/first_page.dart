import 'package:flutter/material.dart';
import 'package:local_database/Authtentication/login.dart';
import 'package:local_database/Authtentication/loginRec.dart';

class FirstScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset("assets/cmp.jpg")),
            const Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                'Login as an Applicant',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement login functionality for applicants
                // Example:
                // loginAsApplicant(emailController.text, passwordController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const LoginScreen()),
                    ),
                  ); 
              },
              child: const Text('Login as Applicant'),
            ),
            const SizedBox(height: 50),

          const Row(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "or",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
            const SizedBox(height: 50),

            const Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                'Login as a Recruiter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
           
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement login functionality for recruiters
                // Example:
                // loginAsRecruiter(emailController.text, passwordController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const LoginScreenRec()),
                    ),
                  ); 
              },
              child: const Text('Login as Recruiter'),
            ),
          ],
        ),
      ),
    );
  }
}
