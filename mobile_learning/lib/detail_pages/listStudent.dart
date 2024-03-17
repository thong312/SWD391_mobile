import 'package:flutter/material.dart';

class StudentDetailPage extends StatelessWidget {
  final String studentCode;
  final String fullName;
  final String email;

  const StudentDetailPage({super.key, 
    required this.studentCode,
    required this.fullName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name: $fullName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Email: $email'),
            SizedBox(height: 8),
            Text('Student Code: $studentCode'),
            SizedBox(height: 8),
            // Add more fields here if needed
          ],
        ),
      ),
    );
  }
}
