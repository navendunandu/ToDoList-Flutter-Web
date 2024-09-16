import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _email = '', _password = '', _name = '';
  final _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      // Create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // Update the user's display name
      await userCredential.user!.updateDisplayName(_name);

      // Display success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful!')),
      );

      // Navigate back to login
      Navigator.pop(context);
    } catch (e) {
      // Display error message
      String errorMessage = e.toString();
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'Signup failed';
      }
      
      // Use a SnackBar or Dialog for the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _name = value,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              onChanged: (value) => _email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => _password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}