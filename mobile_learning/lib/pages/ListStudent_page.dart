import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_learning/detail_pages/listStudent.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Future<List<Student>> _studentDataFuture;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _studentDataFuture = _fetchStudentData();
  }

  Future<List<Student>> _fetchStudentData({String? searchText}) async {
    String apiUrl = 'https://stem-backend.vercel.app/api/v1/students';
    if (searchText != null && searchText.isNotEmpty) {
      apiUrl += '?search=$searchText';
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((student) => Student.fromJson(student)).toList();
    } else {
      throw Exception('Failed to load student data');
    }
  }

 _navigateToDetailPage(BuildContext context, String studentCode, String fullName, String email) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StudentDetailPage(
        studentCode: studentCode,
        fullName: fullName,
        email: email,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _studentDataFuture = _fetchStudentData(searchText: _searchController.text);
                    setState(() {});
                  },
                ),
              ),
              onChanged: (value) {
                // You can add live search if necessary
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Student>>(
              future: _studentDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Student> students = snapshot.data!;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return ListTile(
                        title: Text(student.fullName),
                        subtitle: Text(student.email),
                        onTap: () {
                          _navigateToDetailPage(context, student.studentCode, student.fullName, student.email);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
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


