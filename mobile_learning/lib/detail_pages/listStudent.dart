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
        title: Text('Student Detail'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  fullName,
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Student Code:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  studentCode,
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Years:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  '$schoolYearId',
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Class Code:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  classCode,
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'School Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  schoolName,
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Student Address:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color to make it more visible
                  ),
                ),
                Text(
                  studentAddress,
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Colors.black87, // Change color to make it more visible
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
