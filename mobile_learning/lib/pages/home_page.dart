import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _groupData;

  @override
  void initState() {
    super.initState();
    _groupData = _fetchGroupData();
  }

  Future<List<Map<String, dynamic>>> _fetchGroupData() async {
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
    );
  }
}
