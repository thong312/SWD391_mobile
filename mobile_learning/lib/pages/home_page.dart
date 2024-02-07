import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Good morning Tri', // Tiêu đề của trang home
          style: TextStyle(
            fontWeight: FontWeight.bold, // Đặt font chữ in đậm
            fontSize: 30, // Đặt kích thước font chữ
            color: Colors.pink, // Đặt màu chữ là màu trắng
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'This is not the home page!', // Nội dung của trang home
        ),
      ),
    );
  }
}
