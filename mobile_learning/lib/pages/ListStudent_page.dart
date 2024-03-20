import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_learning/detail_pages/listStudent.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Future<List<Student>> _studentDataFuture;
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1; // Track current page number

  @override
  void initState() {
    super.initState();
    _studentDataFuture = _fetchStudentData();
  }

  Future<List<Student>> _fetchStudentData(
      {String? searchText, int page = 1}) async {
    String apiUrl =
        'https://stem-backend.vercel.app/api/v1/students?page=$page';
    if (searchText != null && searchText.isNotEmpty) {
      apiUrl += '&search=$searchText';
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Student> students =
          data.map((student) => Student.fromJson(student)).toList();
      if (students.isEmpty) {
        // If no data is returned, we've reached the end of available data
        // Set max page to the current page
        return [];
      }
      _currentPage = page; // Update current page
      return students;
    } else {
      throw Exception('Failed to load student data');
    }
  }

  _navigateToDetailPage(
      BuildContext context,
      String studentCode,
      String fullName,
      String email,
      int schoolYearId,
      String classCode,
      String schoolName,
      String studentAddress) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailPage(
          studentCode: studentCode,
          fullName: fullName,
          email: email,
          schoolYearId: schoolYearId,
          classCode: classCode,
          schoolName: schoolName,
          studentAddress: studentAddress,
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by name',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          _studentDataFuture = _fetchStudentData(
                              searchText: _searchController.text);
                          setState(() {});
                        },
                      ),
                    ),
                    onChanged: (value) {
                      // Thử add liveSearch nếu ổn :v
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.first_page),
                  onPressed: () {
                    _currentPage = 1;
                    _studentDataFuture = _fetchStudentData(
                        searchText: _searchController.text, page: _currentPage);
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _currentPage > 1
                      ? () {
                          _currentPage--;
                          _studentDataFuture = _fetchStudentData(
                              searchText: _searchController.text,
                              page: _currentPage);
                          setState(() {});
                        }
                      : null,
                ),
                Text('Page: $_currentPage'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    _currentPage++;
                    _studentDataFuture = _fetchStudentData(
                        searchText: _searchController.text, page: _currentPage);
                    setState(() {});
                  },
                ),
              ],
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
                          _navigateToDetailPage(
                              context,
                              student.studentCode,
                              student.fullName,
                              student.email,
                              student.schoolYearId,
                              student.classCode,
                              student.schoolName,
                              student.studentAddress);
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
  final int schoolYearId;
  final String classCode;
  final String schoolName;
  final String studentAddress;

  Student({
    required this.studentCode,
    required this.fullName,
    required this.email,
    required this.schoolYearId,
    required this.classCode,
    required this.schoolName,
    required this.studentAddress,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentCode: json['StudentCode'] ?? '',
      fullName: json['FullName'] ?? '',
      email: json['Email'] ?? '',
      schoolYearId: json['SchoolYearId'] ?? '',
      classCode: json['ClassCode'] ?? '',
      schoolName: json['SchoolName'] ?? '',
      studentAddress: json['StudentAddress'] ?? '',
    );
  }
}
