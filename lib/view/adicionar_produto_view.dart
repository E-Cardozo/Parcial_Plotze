import 'package:flutter/material.dart';

import '../model/lista_produto.dart'; // Importe a classe ListaProduto

class AdicionarProdutoView extends StatelessWidget {
  final String nomeLista; // Nome da lista onde o produto será adicionado
  final ListaProduto listaProduto; // Instância da classe ListaProduto

  AdicionarProdutoView(
      {required this.nomeLista, required this.listaProduto}); // Construtor

  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();

  // Método para salvar o produto na lista
  void _salvarProduto(BuildContext context) {
    // Obtém os valores dos campos de texto
    String nomeProduto = _nomeController.text.trim();
    String precoString = _precoController.text.trim();
    String quantidadeString = _quantidadeController.text.trim();

    // Verifica se algum campo está vazio
    if (nomeProduto.isEmpty ||
        precoString.isEmpty ||
        quantidadeString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          duration: Duration(seconds: 3), // Duração da mensagem
        ),
      );
      return;
    }

    // Converte os valores para os tipos apropriados
    double preco = double.tryParse(precoString) ?? 0.0;
    int quantidade = int.tryParse(quantidadeString) ?? 0;

    // Adiciona o produto à lista de produtos
    listaProduto.adicionarProduto(nomeLista, nomeProduto, preco, quantidade);

    // Limpa os campos de texto
    _nomeController.clear();
    _precoController.clear();
    _quantidadeController.clear();

    // Exibe uma mensagem de sucesso utilizando um SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Produto "$nomeProduto" adicionado à lista "$nomeLista" com sucesso!',
        ),
        duration: Duration(seconds: 2), // Duração da mensagem
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(nomeLista), // Exibe o nome da lista no AppBar
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _salvarProduto(context),
              child: Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
