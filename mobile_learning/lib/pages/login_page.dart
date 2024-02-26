import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Google'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleSignIn(context),
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }

  void _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final authentication = await googleUser.authentication;
        final idToken = authentication.idToken;

        final response = await http.get(
          Uri.parse('https://stem-backend.vercel.app/auth/google/callback'),
          headers: {'Authorization': 'Bearer $idToken'},
        );

        if (response.statusCode == 200) {
          // Handle successful authentication
          Navigator.pushReplacementNamed(context, '/');
        } else {
          // Handle authentication failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Authentication failed')),
          );
        }
      } else {
        // Handle Google Sign-In failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In failed')),
        );
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
      // Handle Google Sign-In error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Error')),
      );
    }
  }
}
