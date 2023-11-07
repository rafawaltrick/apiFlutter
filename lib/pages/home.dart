import 'dart:convert';

import 'package:atv_crud_flutter/components/button_custom.dart';
import 'package:atv_crud_flutter/pages/forms.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:atv_crud_flutter/components/list_view_custom.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<dynamic> _data = [];

  Future<void> getProducts() async {
    final response = await http.get(Uri.parse(
        'https://loja-mcyhir2om-rodrigoribeiro027.vercel.app/produtos/buscar'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _data = jsonResponse;
      });
    } else {}
  }

  void navigate() {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Forms()),
    );
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem"),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Align(
          alignment: Alignment.topCenter,
          child: Text("Listagem", style: TextStyle(fontSize: 25)),
        ),
        const SizedBox(height: 20, width: 20),
        SizedBox(
          child: Container(
            width: 400,
            height: 600,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.3),
            ),
            child: ListViewCustom(data: _data),
          ),
        ),
        const SizedBox(height: 20, width: 20),
        ButtomCustom(
            function: navigate, title: "Novo Produto", width: 150, height: 50)
      ])),
    );
  }
}
