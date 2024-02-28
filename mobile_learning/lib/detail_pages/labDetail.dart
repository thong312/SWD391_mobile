import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LabDetailPage extends StatelessWidget {
  final String code;
  final String topic;
  final String description;
  final String startDate;
  final String endDate;
  final String programName;

  const LabDetailPage({
    Key? key,
    required this.code,
    required this.topic,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.programName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lab Code: $code',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
              Image.network(
              'https://www.gse.harvard.edu/sites/default/files/banner/1500x750-student-test.jpg',
              width: MediaQuery.of(context).size.width, // Set image width to screen width
              fit: BoxFit.cover, // Scale image to cover entire area
            ),
            Text(
              'Topic: $topic',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
               'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
             'End Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate))}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Text(
            //   'Program Name: $programName',
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
