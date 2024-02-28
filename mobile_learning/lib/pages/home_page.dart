import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_learning/detail_pages/news.dart'; // Import NewsDetailPage
import 'package:mobile_learning/detail_pages/program.dart'; // Import ProgramDetailPage

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      final response = await http
          .get(Uri.parse('https://stem-backend.vercel.app/api/v1/groups'));

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
      final response = await http
          .get(Uri.parse('https://stem-backend.vercel.app/api/v1/news'));

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
      final response = await http
          .get(Uri.parse('https://stem-backend.vercel.app/api/v1/programs'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((program) {
          return {
            'Name': program['Name'],
            'Code': program['Code'], // Swap Name and Code
            'Image': program['Image'],
            'Description': program['Description'],
            'StartDate': program['StartDate'],
            'EndDate': program['EndDate'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load program data');
      }
    } catch (e) {
      throw Exception('Failed to fetch program data: $e');
    }
  }

  void _navigateToNewsDetailPage(
      BuildContext context, String title, String detail, String imageUrl) {
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

  void _navigateToProgramDetailPage(
      BuildContext context,
      String name,
      String code,
      String imageUrl,
      String description,
      String startDate,
      String endDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailPage(
            name: name,
            code: code,
            imageUrl: imageUrl,
            description: description,
            startDate: startDate,
            endDate: endDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Stack(
            // children: [
            //   Positioned(
            //     bottom: 0,
            //     left: 16,
            //     child: Text(
            //       'Good morning Tri',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 30,
            //         color: Colors.pink,
            //       ),
            //     ),
            //   ),
            // ],
            ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Image.network(
                    'https://www.bnet-tech.com/wp-content/uploads/2021/01/218_2-small.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Group ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _groupData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final groupData = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'News ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _newsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final newsData = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Program ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: programData.length,
                    itemBuilder: (context, index) {
                      final program = programData[index];
                      return ListTile(
                        title: Text(program['Name']),
                        subtitle:
                            Text(program['Code']), // Display Code as subtitle
                        leading: Image.network(program['Image']),
                        onTap: () {
                          _navigateToProgramDetailPage(
                              context,
                              program['Name'],
                              program['Code'],
                              program['Image'],
                              program['Description'],
                              program['StartDate'],
                              program['EndDate']);
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
