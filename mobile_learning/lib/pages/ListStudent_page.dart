import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentPage extends StatelessWidget {
  const StudentPage({Key? key});

  Future<List<Student>> _fetchStudentData() async {
    final response = await http.get(Uri.parse('https://stem-backend.vercel.app/student'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((student) => Student.fromJson(student)).toList();
    } else {
      throw Exception('Failed to load student data');
    }
  }

  _navigateToDetailPage(BuildContext context, String studentCode, String fullName, String email) {
    // Implement navigation to detail page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: FutureBuilder<List<Student>>(
        future: _fetchStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final studentData = snapshot.data!;
            return ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Student Code')),
                      DataColumn(label: Text('Full Name')),
                      DataColumn(label: Text('Email')),
                    ],
                    rows: studentData
                        .map(
                          (student) => DataRow(cells: [
                            DataCell(Text(student.studentCode)),
                            DataCell(Text(student.fullName)),
                            DataCell(Text(student.email)),
                          ]),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class Student {
  final String studentCode;
  final String fullName;
  final String email;

  Student({
    required this.studentCode,
    required this.fullName,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentCode: json['StudentCode'] ?? '',
      fullName: json['FullName'] ?? '',
      email: json['Email'] ?? '',
    );
  }
}
