import 'package:flutter/material.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program'),
      ),
      body: const Center(
        child: Text(
          'This is the Program Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
