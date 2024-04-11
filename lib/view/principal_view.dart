import 'package:flutter/material.dart';
import '../model/lista_produto.dart';
import 'adicionar_produto_view.dart';
import 'carrinho_view.dart';
import 'login_screen.dart';

class PrincipalView extends StatelessWidget {
  final ListaProduto listaProduto; // Lista de produtos

  PrincipalView({required this.listaProduto}); // Construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Commerce'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _confirmarSaida(context), // Botão de sair
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 100), // Ícone de carrinho
            SizedBox(height: 20), // Espaçamento
            ElevatedButton(
              onPressed: () {
                _exibirDialogo(context); // Botão para adicionar produto à lista
              },
              child: Text('Lançar no Carrinho'),
            ),
            SizedBox(height: 20), // Espaçamento
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarrinhoView(
                      listaProduto: listaProduto,
                      listasCriadas: listaProduto.getListasCriadas(),
                    ),
                  ),
                ); // Botão para ver o carrinho
              },
              child: Text('Ver Carrinho'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para exibir diálogo para inserir nome da lista
  void _exibirDialogo(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Chave global para o Form

    TextEditingController _nomeListaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nome da Lista'),
          content: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: _nomeListaController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um nome para a lista.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Digite o nome da lista",
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancela a criação da lista
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String nomeLista = _nomeListaController.text.trim();
                  listaProduto.salvarLista(nomeLista); // Salva a lista
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lista "$nomeLista" salva com sucesso!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdicionarProdutoView(
                        nomeLista: nomeLista,
                        listaProduto: listaProduto,
                      ),
                    ),
                  ); // Navega para a tela de adicionar produto
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Método para confirmar saída do app
  void _confirmarSaida(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sair'),
          content: Text('Deseja realmente sair?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha a caixa de diálogo
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                ); // Retorna à tela de login e remove todas as rotas anteriores
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
