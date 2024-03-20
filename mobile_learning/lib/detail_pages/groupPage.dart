import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupDetailPage extends StatelessWidget {
  final String programName;
  final String groupName;
  final String groupCode;
  final String teacherCode;
  final String teacherName;
  final int groupId;

  const GroupDetailPage({
    Key? key,
    required this.programName,
    required this.groupName,
    required this.groupCode,
    required this.teacherCode,
    required this.teacherName,
    required this.groupId,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchMemberData(int groupId) async {
    const String baseUrl =
        'https://stem-backend.vercel.app/api/v1/members/member-in-group';

    final Uri uri = Uri.parse('$baseUrl?GroupId=$groupId');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((member) {
        return {
          'FullName': member['FullName'],
          'StudentCode': member['StudentCode'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load members');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Detail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://www.mkctraining.com/img/STEM.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoItem('Group Name:', groupName),
                      _buildInfoItem('Group Code:', groupCode),
                      _buildInfoItem('Teacher Code:', teacherCode),
                      _buildInfoItem('Teacher Name:', teacherName),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: AlertDialog(
                                  title: const Text('Members'),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.8, // 80% of screen width
                                    height: MediaQuery.of(context).size.height *
                                        0.4, // 40% of screen height
                                    child: FutureBuilder<
                                        List<Map<String, dynamic>>>(
                                      future: _fetchMemberData(groupId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          );
                                        } else {
                                          final memberData = snapshot.data!;
                                          return ListView(
                                            children: memberData.map((member) {
                                              return _buildMemberItem(
                                                member['FullName'],
                                                member['StudentCode'],
                                              );
                                            }).toList(),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('View Members'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildMemberItem(String name, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: $name',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Code: $code',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
