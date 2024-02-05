import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App', // Đặt tiêu đề của ứng dụng
      theme: ThemeData(
        // Đặt theme cho ứng dụng của bạn
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: const HomePage(), // Kết nối với trang home của ứng dụng
      ),
    );
  }
}
