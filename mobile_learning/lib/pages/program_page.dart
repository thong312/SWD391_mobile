import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../detail_pages/program.dart';

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
          'Description': program['Description'],
          'StartDate': program['StartDate'],
          'EndDate': program['EndDate'],
          'Id': program['Id'], // Thêm 'Id' vào dữ liệu chương trình
        };
      }).toList();
    } else {
      throw Exception('Failed to load program data');
    }
  }

  _navigateToDetailPage(BuildContext context, Map<String, dynamic> program) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailPage(
          code: program['Code'],
          name: program['Name'],
          imageUrl: program['Image'],
          description: program['Description'],
          startDate: program['StartDate'],
          endDate: program['EndDate'],
          programId: program['Id'], // Truyền 'Id' của chương trình
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
      body: Column(
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
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _programData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final programData = snapshot.data!;
                  return ListView.builder(
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
                            program,
                          );
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
