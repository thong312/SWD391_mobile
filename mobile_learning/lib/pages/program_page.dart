import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_learning/detail_pages/program.dart';
import 'dart:convert';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key});

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  late Future<List<Map<String, dynamic>>> _programData;

  @override
  void initState() {
    super.initState();
    _programData = _fetchProgramData();
  }

  Future<List<Map<String, dynamic>>> _fetchProgramData() async {
    final response = await http.get(Uri.parse('https://stem-backend.vercel.app/api/v1/programs'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((program) {
        return {
          'Code': program['Code'],
          'Name': program['Name'],
          'Image': program['Image'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load program data');
    }
  }

  _navigateToDetailPage(BuildContext context, String code, String name, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailPage(
          code: code,
          name: name,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://www.bnet-tech.com/wp-content/uploads/2021/01/218_2-small.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _programData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final programData = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: programData.length,
                    itemBuilder: (context, index) {
                      final program = programData[index];
                      return ListTile(
                        title: Text(program['Name']),
                        subtitle: Text(program['Code']),
                        leading: Image.network(program['Image']),
                        onTap: () {
                          _navigateToDetailPage(
                            context,
                            program['Code'],
                            program['Name'],
                            program['Image'],
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
