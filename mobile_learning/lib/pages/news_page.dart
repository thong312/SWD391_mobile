import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_learning/detail_pages/news.dart';
import 'dart:convert';


class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchNewsData() async {
    final response = await http.get(Uri.parse('https://stem-backend.vercel.app/api/v1/news'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((news) {
        return {
          'Title': news['Title'],
          'Detail': news['Detail'],
          'Image': news['Image'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load news data');
    }
  }

  _navigateToDetailPage(BuildContext context, String title, String detail, String imageUrl) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchNewsData(),
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
                return Card(
                  child: ListTile(
                    leading: Image.network(news['Image']),
                    title: Text(news['Title']),
                    subtitle: Text(news['Detail']),
                    onTap: () {
                      _navigateToDetailPage(
                        context,
                        news['Title'],
                        news['Detail'],
                        news['Image'],
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
