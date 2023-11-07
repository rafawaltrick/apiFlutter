import 'package:atv_crud_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'pages/forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
