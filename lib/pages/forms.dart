import 'package:atv_crud_flutter/components/button_custom.dart';
import 'package:atv_crud_flutter/components/input_field_custom.dart';
import 'package:atv_crud_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Forms extends StatefulWidget {
  final String titulo;
  final String nome;
  final String descricao;
  final int preco;
  final int quantidade;
  final String id;
  final bool editar;

  const Forms(
      {Key? key,
      this.id = '',
      this.titulo = 'Cadastro',
      this.nome = '',
      this.descricao = '',
      this.preco = 0,
      this.quantidade = 0,
      this.editar = false})
      : super(key: key);

  @override
  _Forms createState() => _Forms();
}

class _Forms extends State<Forms> {
  late final TextEditingController _nome =
      TextEditingController(text: widget.nome);
  late final TextEditingController _preco =
      TextEditingController(text: widget.preco.toString());
  late final TextEditingController _descricao =
      TextEditingController(text: widget.descricao);
  late final TextEditingController _quantidade =
      TextEditingController(text: widget.quantidade.toString());

  @override
  void dispose() {
    _nome.dispose();
    _descricao.dispose();
    _preco.dispose();
    _quantidade.dispose();
    super.dispose();
  }

  Future<void> cadastrarProduto() async {
    final nome = _nome.text;
    final descricao = _descricao.text;
    final preco = double.parse(_preco.text);
    final quantidade = double.parse(_quantidade.text);

    final http.Response response = await http.post(
      Uri.parse(
          'https://loja-mcyhir2om-rodrigoribeiro027.vercel.app/produtos/criar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome': nome,
        'descricao': descricao,
        'preco': preco,
        'quantidade': quantidade
      }),
    );
    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      print(
          'Erro ao cadastrar produto: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> editarProduto() async {
    final nome = _nome.text;
    final descricao = _descricao.text;
    final preco = double.parse(_preco.text);
    final quantidade = double.parse(_quantidade.text);

    final http.Response response = await http.put(
      Uri.parse(
          'https://loja-mcyhir2om-rodrigoribeiro027.vercel.app/produtos/atualizar/${widget.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome': nome,
        'descricao': descricao,
        'preco': preco,
        'quantidade': quantidade
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      print(
          'Erro ao cadastrar produto: ${response.statusCode} - ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
            ;
          },
        ),
        title: Text(widget.titulo),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(widget.titulo, style: TextStyle(fontSize: 25)),
            ),
            Column(
              children: [
                const SizedBox(height: 20, width: 20),
                InputFieldCustom(title: "Nome", controller: _nome),
                const SizedBox(height: 20, width: 20),
                InputFieldCustom(title: "Descricao", controller: _descricao),
                const SizedBox(height: 20, width: 20),
                InputFieldCustom(
                  title: "Preço",
                  controller: _preco,
                  onlynumber: true,
                ),
                const SizedBox(height: 20, width: 20),
                InputFieldCustom(
                  title: "Quantidade",
                  controller: _quantidade,
                  onlynumber: true,
                ),
                const SizedBox(height: 20, width: 20),
                ButtomCustom(
                  function: widget.editar ? editarProduto : cadastrarProduto,
                  title: widget.titulo,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
