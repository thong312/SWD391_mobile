import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_learning/detail_pages/news.dart'; // Import NewsDetailPage
import 'package:mobile_learning/detail_pages/program.dart'; // Import ProgramDetailPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _groupData;
  late Future<List<Map<String, dynamic>>> _newsData;
  late Future<List<Map<String, dynamic>>> _programData;

  @override
  void initState() {
    super.initState();
    _groupData = _fetchGroupData();
    _newsData = _fetchNewsData();
    _programData = _fetchProgramData();
  }

  Future<List<Map<String, dynamic>>> _fetchGroupData() async {
    try {
      final response = await http.get(Uri.parse('https://stem-backend.vercel.app/group'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((group) {
          return {
            'GroupName': group['GroupName'],
            'ProgramName': group['ProgramName'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load group data');
      }
    } catch (e) {
      throw Exception('Failed to fetch group data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchNewsData() async {
    try {
      final response = await http.get(Uri.parse('https://stem-backend.vercel.app/news'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((news) {
          return {
            'Title': news['Title'],
            'Image': news['Image'],
            'Detail': news['Detail'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load news data');
      }
    } catch (e) {
      throw Exception('Failed to fetch news data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchProgramData() async {
    try {
      final response = await http.get(Uri.parse('https://stem-backend.vercel.app/program'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((program) {
          return {
            'Name': program['Name'],
            'Code': program['Code'], // Swap Name and Code
            'Image': program['Image'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load program data');
      }
    } catch (e) {
      throw Exception('Failed to fetch program data: $e');
    }
  }

  // Function to navigate to NewsDetailPage
  _navigateToNewsDetailPage(BuildContext context, String title, String detail, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          title: title,
          detail: detail,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  // Function to navigate to ProgramDetailPage
  _navigateToProgramDetailPage(BuildContext context, String name, String code, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailPage(
          name: name,
          code: code,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Good morning Tri',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.pink,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Group Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _groupData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final groupData = snapshot.data!;
                  return ListView.builder(
                    itemCount: groupData.length,
                    itemBuilder: (context, index) {
                      final group = groupData[index];
                      return ListTile(
                        title: Text(group['GroupName']),
                        subtitle: Text(group['ProgramName']),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'News Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _newsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final newsData = snapshot.data!;
                  return ListView.builder(
                    itemCount: newsData.length,
                    itemBuilder: (context, index) {
                      final news = newsData[index];
                      return ListTile(
                        title: Text(news['Title']),
                        leading: Image.network(news['Image']),
                        onTap: () {
                          _navigateToNewsDetailPage(
                            context,
                            news['Title'],
                            news['Detail'],
                            news['Image'],
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Program Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
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
                        subtitle: Text(program['Code']), // Display Code as subtitle
                        leading: Image.network(program['Image']),
                        onTap: () {
                          _navigateToProgramDetailPage(
                            context,
                            program['Name'],
                            program['Code'],
                            program['Image'],
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
