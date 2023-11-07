import 'package:atv_crud_flutter/pages/forms.dart';
import 'package:atv_crud_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListViewCustom extends StatefulWidget {
  final List<dynamic> data;

  const ListViewCustom({Key? key, required this.data}) : super(key: key);

  @override
  _ListViewCustomState createState() => _ListViewCustomState();
}

class _ListViewCustomState extends State<ListViewCustom> {
  Future<void> deleteProduct(id) async {
    final http.Response response = await http.delete(
      Uri.parse(
          'https://loja-mcyhir2om-rodrigoribeiro027.vercel.app/produtos/excluir/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.data[index];
          final nome = item["nome"];
          final descricao = item["descricao"];
          final preco = item["preco"];
          final quantidade = item["quantidade"];
          final _id = item["_id"];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20, width: 20),
                Text(
                  'Nome: $nome',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Descrição: $descricao',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Preço: ${preco.toStringAsFixed(2)} Reais',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Quantidade: $quantidade',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.blue.shade700,
                  icon: Icon(Icons.edit), // Ícone de lápis para edição
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Forms(
                              titulo: "Editar",
                              nome: nome,
                              descricao: descricao,
                              preco: preco,
                              quantidade: quantidade,
                              id: _id,
                              editar: true)),
                    ); // Implemente a ação de edição aqui
                  },
                ),
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete), // Ícone de lixeira para exclusão
                  onPressed: () {
                    deleteProduct(_id);
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: widget.data.length,
      ),
    );
  }
}
