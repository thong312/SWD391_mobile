import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_learning/detail_pages/news.dart';
import 'dart:convert';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key});

  Future<List<Map<String, dynamic>>> _fetchNewsData() async {
    final response =
        await http.get(Uri.parse('https://stem-backend.vercel.app/api/v1/news'));

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

  _navigateToDetailPage(BuildContext context, String title, String detail,
      String imageUrl) {
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
        automaticallyImplyLeading: false,
        title: Text(
          'News',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchNewsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final newsData = snapshot.data!;
            return Column(
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
                  child: Center(
                    child: Text(
                      'Explore News',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsData.length,
                    itemBuilder: (context, index) {
                      final news = newsData[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              news['Image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            news['Title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            news['Detail'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
