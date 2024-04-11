import 'package:flutter/material.dart';
import '../model/lista_produto.dart';
import '../model/produto.dart';
import 'adicionar_produto_view.dart';

class ProdutosDaListaView extends StatefulWidget {
  final String nomeDaLista;
  final ListaProduto listaProduto;

  const ProdutosDaListaView({
    Key? key,
    required this.nomeDaLista,
    required this.listaProduto,
  }) : super(key: key);

  @override
  _ProdutosDaListaViewState createState() => _ProdutosDaListaViewState();
}

class _ProdutosDaListaViewState extends State<ProdutosDaListaView> {
  List<Produto> _produtosFiltrados = [];

  @override
  void initState() {
    super.initState();
    // Inicializa a lista de produtos filtrados com os produtos da lista específica
    _produtosFiltrados =
        widget.listaProduto.getProdutosPorLista(widget.nomeDaLista);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeDaLista),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _exibirDialogoPesquisa(context); // Exibe o diálogo de pesquisa
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _exibirInformacoes(
                  context); // Exibe informações sobre os produtos
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Atualiza a lista de produtos
              setState(() {
                _produtosFiltrados =
                    widget.listaProduto.getProdutosPorLista(widget.nomeDaLista);
              });
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdicionarProdutoView(
                    nomeLista: widget.nomeDaLista,
                    listaProduto: widget.listaProduto,
                  ),
                ),
              ); // Navega para a tela de adicionar produto
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              _finalizarCompra(context); // Finaliza a compra
            },
            child: Icon(Icons.check),
          ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true, // Para evitar problemas de layout
            itemCount: _produtosFiltrados.length,
            itemBuilder: (context, index) {
              var produto = _produtosFiltrados[index];
              return Card(
                child: ListTile(
                  title: Text(
                    '${produto.nome} - Preço: R\$ ${produto.preco.toStringAsFixed(2)} - Quantidade: ${produto.quantidade}',
                  ),
                  trailing: Checkbox(
                    value: produto.comprado,
                    onChanged: (bool? newValue) {
                      setState(() {
                        produto.comprado = newValue!;
                      });
                    },
                  ),
                  onLongPress: () {
                    _removerProduto(produto); // Remove o produto da lista
                  },
                  onTap: () {
                    _editarProduto(produto); // Edita o produto
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Método para remover um produto da lista
  void _removerProduto(Produto produto) {
    setState(() {
      widget.listaProduto.removerProduto(widget.nomeDaLista, produto);
      _produtosFiltrados =
          widget.listaProduto.getProdutosPorLista(widget.nomeDaLista);
    });
  }

  // Método para editar um produto da lista
  void _editarProduto(Produto produto) {
    TextEditingController _nomeController =
        TextEditingController(text: produto.nome);
    TextEditingController _precoController =
        TextEditingController(text: produto.preco.toString());
    TextEditingController _quantidadeController =
        TextEditingController(text: produto.quantidade.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Atualiza as informações do produto
                produto.nome = _nomeController.text.trim();
                produto.preco =
                    double.tryParse(_precoController.text.trim()) ?? 0.0;
                produto.quantidade =
                    int.tryParse(_quantidadeController.text.trim()) ?? 0;

                // Atualiza a lista de produtos na interface
                setState(() {
                  // Atualiza a lista de produtos filtrados
                  _produtosFiltrados = widget.listaProduto
                      .getProdutosPorLista(widget.nomeDaLista);
                });

                Navigator.pop(context); // Fecha o diálogo de edição
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Método para finalizar a compra
  void _finalizarCompra(BuildContext context) {
    // Lista dos nomes dos produtos comprados
    List<String> produtosComprados = [];

    // Identificar os produtos marcados como comprados
    _produtosFiltrados.forEach((produto) {
      if (produto.comprado) {
        produtosComprados.add(produto.nome);
      }
    });

    // Verificar se há produtos marcados como comprados
    if (produtosComprados.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Compra Finalizada'),
            content: Text('Nenhum produto marcado como comprado.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Mostrar os nomes dos produtos comprados em uma caixa de diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Compra Finalizada'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  produtosComprados.map((produto) => Text(produto)).toList(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Método para exibir informações sobre os produtos
  void _exibirInformacoes(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informações sobre os produtos'),
          content: Text(
              'Para remover o produto da lista, pressione e segure sobre o item.\n\n'
              'Para editar o produto, toque sobre o item.\n\n'
              'Para comprar o produto, marque o item e clique no botão finalizado.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Método para exibir o diálogo de pesquisa de produto
  void _exibirDialogoPesquisa(BuildContext context) {
    String? termoPesquisa;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pesquisar Produto'),
          content: TextField(
            onChanged: (value) {
              termoPesquisa = value;
            },
            decoration: InputDecoration(hintText: 'Digite o nome do produto'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  if (termoPesquisa != null && termoPesquisa!.isNotEmpty) {
                    _produtosFiltrados = widget.listaProduto
                        .getProdutosPorLista(widget.nomeDaLista)
                        .where((produto) => produto.nome
                            .toLowerCase()
                            .contains(termoPesquisa!.toLowerCase()))
                        .toList();
                  } else {
                    _produtosFiltrados = widget.listaProduto
                        .getProdutosPorLista(widget.nomeDaLista);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Pesquisar'),
            ),
          ],
        );
      },
    );
  }
}
