import 'package:flutter/material.dart';

class ProgramDetailPage extends StatelessWidget {
  final String code;
  final String name;
  final String imageUrl;

  const ProgramDetailPage({super.key, 
    required this.code,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Code: $code',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
