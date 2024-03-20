import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_learning/detail_pages/news.dart'; // Import NewsDetailPage
import 'package:mobile_learning/detail_pages/program.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_learning/detail_pages/groupPage.dart';
import 'package:mobile_learning/detail_pages/teacherProgram.dart'; // Import ProgramDetailPage

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
      final response = await http.get(Uri.parse(
          'https://stem-backend.vercel.app/api/v1/groups/group-list/groups-of-a-teacher?ProgramId=1&TeacherId=1'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((group) {
          return {
            'GroupName': group['GroupName'],
            'ProgramName': group['ProgramName'],
            'TeacherCode': group['TeacherCode'],
            'TeacherName': group['TeacherName'],
            'GroupCode': group['GroupCode'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load group data');
      }
    } catch (e) {
      throw Exception('Failed to fetch group data: $e');
    }
  }

  void _navigateToGroupDetailPage(
      BuildContext context,
      String programName,
      String groupName,
      String groupCode,
      String teacherCode,
      String teacherName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailPage(
          programName: programName,
          groupName: groupName,
          groupCode: groupCode,
          teacherCode: teacherCode,
          teacherName: teacherName,
        ),
      ),
    );
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
      final response = await http.get(Uri.parse(
          'https://stem-backend.vercel.app/api/v1/programs/program-list/programs-of-a-teacher?TeacherId=1'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((program) {
          return {
            'Name': program['Name'],
            // 'Code': program['Code'], // Swap Name and Code
            'Image': program['Image'],
            'Description': program['Description'],
            // 'StartDate': program['StartDate'],
            // 'EndDate': program['EndDate'],
            // 'Id': program['Id'], // Thêm 'Id' vào dữ liệu chương trình
          };
        }).toList();
      } else {
        throw Exception('Failed to load program data');
      }
    } catch (e) {
      throw Exception('Failed to fetch program data: $e');
    }
  }

  void _navigateToTeacherProgramDetailPage(
    BuildContext context,
    String name,
    String image,
    String description,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherProgramDetailPage(
          name: name,
          image: image,
          description: description,
        ),
      ),
    );
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
      String endDate,
      int programId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramDetailPage(
            name: name,
            code: code,
            imageUrl: imageUrl,
            description: description,
            startDate: startDate,
            endDate: endDate,
            programId: programId),
      ),
    );
  }

  void signOut() async {
    await GoogleSignIn().disconnect().then((value) {
      Navigator.pushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
        flexibleSpace: const Stack(),
      ),
      resizeToAvoidBottomInset: false, // Set resizeToAvoidBottomInset to false
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
                'My Group ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200, // or any other height as you need
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _groupData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final groupData = snapshot.data!;
                      return Row(
                        children: groupData.map((group) {
                          return GestureDetector(
                            onTap: () => _navigateToGroupDetailPage(
                              context,
                              group['ProgramName'],
                              group['GroupName'],
                              group['GroupCode'],
                              group['TeacherCode'],
                              group['TeacherName'],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group['GroupName'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        group['ProgramName'],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'News ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _newsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final newsData = snapshot.data!;
                      return Row(
                        children: newsData.map((news) {
                          return GestureDetector(
                            onTap: () => _navigateToNewsDetailPage(
                              context,
                              news['Title'],
                              news['Detail'],
                              news['Image'],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  width: 150,
                                  height: 200,
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        news['Title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            news['Image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        news['Detail'],
                                        style: TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'My Program',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _programData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final programData = snapshot.data!;
                      return Row(
                        children: programData.map((program) {
                          return GestureDetector(
                            onTap: () => _navigateToTeacherProgramDetailPage(
                              context,
                              program['Name'],
                              // program['Code'],
                              program['Image'],
                              program['Description'],
                              // program['StartDate'],
                              // program['EndDate'],
                              // program['Id'],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  width: 150,
                                  height: 200,
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        program['Name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            program['Image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        program['Description'],
                                        style: TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
