import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Good morning Tri', // Tiêu đề của trang home
          style: TextStyle(
            fontWeight: FontWeight.bold, // Đặt font chữ in đậm
            fontSize: 30, // Đặt kích thước font chữ
            color: Colors.black, // Đặt màu chữ là màu trắng
          ),
        ),
      ),
      body: Center(
        child: const Text(
          'This is the home page!', // Nội dung của trang home
        ),
      ),
    );
  }
}
