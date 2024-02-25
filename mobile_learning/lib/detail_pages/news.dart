import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String detail;
  final String imageUrl;

  const NewsDetailPage({super.key, 
    required this.title,
    required this.detail,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                detail,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
