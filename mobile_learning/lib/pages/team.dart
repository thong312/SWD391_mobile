import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:mobile_learning/detail_pages/team_detail.dart';

class TeamList extends StatelessWidget {
  const TeamList({super.key});

  Future<List<Map<String, dynamic>>> _fetchTeamData() async {
    final response = await http.get(Uri.parse(
        'https://stem-backend.vercel.app/api/v1/teams/team-in-group?GroupId=2'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((team) {
        return {
          'TeamName': team['TeamName'],
          // 'Members': team['Members'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load team data');
    }
  }

  // _navigateToDetailPage(BuildContext context, String teamName, int members) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => TeamDetailPage(
  //         teamName: teamName,
  //         members: members,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Team List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
                'Explore Teams',
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
              future: _fetchTeamData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final teamData = snapshot.data!;
                  return ListView.builder(
                    itemCount: teamData.length,
                    itemBuilder: (context, index) {
                      final team = teamData[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            team['TeamName'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
