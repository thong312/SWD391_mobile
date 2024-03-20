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
    final response = await http
        .get(Uri.parse('https://stem-backend.vercel.app/api/v1/programs'));

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
          'Id': program['Id'],
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
          programId: program['Id'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Programs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                    'https://www.bnet-tech.com/wp-content/uploads/2021/01/218_2-small.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken),
              ),
            ),
            child: const Center(
              child: Text(
                'Explore Programs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                      return InkWell(
                        onTap: () {
                          _navigateToDetailPage(context, program);
                        },
                        child: Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.blueGrey[50], // Adjust card color
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      program['Image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        program['Name'],
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        program['Code'],
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        program['Description'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
