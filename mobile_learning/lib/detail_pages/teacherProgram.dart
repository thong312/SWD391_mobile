import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_learning/detail_pages/groupPage.dart';

class TeacherProgramDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final int programId;

  const TeacherProgramDetailPage({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.programId,
  });

  Future<List<Map<String, dynamic>>> _fetchGroupData(int programId) async {
    const String baseUrl =
        'https://stem-backend.vercel.app/api/v1/groups/group-list/groups-of-a-teacher';
    final Uri uri = Uri.parse('$baseUrl?ProgramId=$programId&TeacherId=2');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((group) {
        return {
          'Id': group['Id'],
          'GroupName': group['GroupName'],
          'ProgramName': group['ProgramName'],
          'TeacherCode': group['TeacherCode'],
          'TeacherName': group['TeacherName'],
          'GroupCode': group['GroupCode'],
          'ProgramId': group['ProgramId']
        };
      }).toList();
    } else {
      throw Exception('Failed to load group data');
    }
  }

  void _navigateToGroupDetailPage(
    BuildContext context,
    String programName,
    String groupName,
    String groupCode,
    String teacherCode,
    String teacherName,
    int id,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailPage(
          programName: programName,
          groupName: groupName,
          groupCode: groupCode,
          teacherCode: teacherCode,
          teacherName: teacherName,
          groupId: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Program Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Groups:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchGroupData(programId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final groupData = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: groupData.map((group) {
                            return GestureDetector(
                              onTap: () => _navigateToGroupDetailPage(
                                context,
                                group['ProgramName'],
                                group['GroupName'],
                                group['GroupCode'],
                                group['TeacherCode'],
                                group['TeacherName'],
                                group['Id'],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      group['GroupName'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    // Add other fields as needed
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
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
