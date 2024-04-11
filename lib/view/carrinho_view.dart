import 'package:flutter/material.dart';
import '../model/lista_produto.dart';
import 'produto_lista_view.dart';

class CarrinhoView extends StatefulWidget {
  final ListaProduto listaProduto; // Lista de produtos
  final List<String> listasCriadas; // Lista de nomes das listas criadas

  CarrinhoView(
      {required this.listaProduto, required this.listasCriadas}); // Construtor

  @override
  _CarrinhoViewState createState() => _CarrinhoViewState();
}

class _CarrinhoViewState extends State<CarrinhoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas Criadas'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _mostrarInfoDialog(context); // Exibe o diálogo de informações
            },
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true, // Para evitar problemas de layout
            itemCount: widget.listasCriadas.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  _mostrarOpcoesLista(
                      widget.listasCriadas[index]); // Exibe as opções da lista
                },
                child: ListTile(
                  title: Text(widget.listasCriadas[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutosDaListaView(
                          nomeDaLista: widget.listasCriadas[index],
                          listaProduto: widget.listaProduto,
                        ),
                      ),
                    ); // Navega para a visualização dos produtos da lista
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Método para exibir opções da lista (remover)
  void _mostrarOpcoesLista(String nomeLista) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opções da Lista'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Remover Lista'),
                onTap: () {
                  Navigator.pop(context); // Fecha o diálogo
                  _removerLista(nomeLista); // Remove a lista
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para remover a lista
  void _removerLista(String nomeLista) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover Lista'),
          content: Text('Deseja realmente remover a lista "$nomeLista"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Remove a lista da lista de produtos
                widget.listaProduto.removerLista(nomeLista);
                // Remove a lista da lista de listas criadas
                setState(() {
                  widget.listasCriadas.remove(nomeLista);
                });
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  // Método para exibir diálogo de informações
  void _mostrarInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informações'),
          content: Text('Para remover uma lista, clique e segure sobre ela.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
