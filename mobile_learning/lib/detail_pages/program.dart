import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_learning/detail_pages/labCard.dart';
import 'dart:convert';
class ProgramDetailPage extends StatelessWidget {
  final String code;
  final String name;
  final String imageUrl;
  final String description;
  final String startDate;
  final String endDate;

  const ProgramDetailPage({
    Key? key,
    required this.code,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchLabData() async {
    final response = await http.get(Uri.parse('https://stem-backend.vercel.app/api/v1/labs'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((lab) {
        return {
          'Code': lab['Code'],
          'Topic': lab['Topic'],
          'Description': lab['Description'],
          'StartDate': lab['StartDate'],
          'EndDate': lab['EndDate'],
          'ProgramName': lab['ProgramName'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load lab data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code: $code',
                    style: const TextStyle(fontSize: 18),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Labs:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchLabData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final labData = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: labData.map((lab) => LabCard(
                            labCode: lab['Code'],
                            labTopic: lab['Topic'],
                            labDescription: lab['Description'],
                            labStartDate: lab['StartDate'],
                            labEndDate: lab['EndDate'],
                            labProgramName: lab['ProgramName'],
                          )).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
