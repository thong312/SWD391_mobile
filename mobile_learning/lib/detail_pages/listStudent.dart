import 'package:flutter/material.dart';

class StudentDetailPage extends StatelessWidget {
  final String studentCode;
  final String fullName;
  final String email;
  final int schoolYearId;
  final String classCode;
  final String schoolName;
  final String studentAddress;

  const StudentDetailPage({
    Key? key,
    required this.studentCode,
    required this.fullName,
    required this.email,
    required this.schoolYearId,
    required this.classCode,
    required this.schoolName,
    required this.studentAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Full Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Student Code:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  studentCode,
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Years:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  '$schoolYearId',
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Class Code:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  classCode,
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'School Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  schoolName,
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Student Address:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  studentAddress,
                  style: const TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
