import 'produto.dart';

class ListaProduto {
  static final ListaProduto _singleton = ListaProduto._internal();

  factory ListaProduto() {
    return _singleton;
  }

  ListaProduto._internal();

  List<String> _listasCriadas = [];
  Map<String, List<Produto>> _produtosPorLista = {};

  void salvarLista(String nomeLista) {
    if (!_listasCriadas.contains(nomeLista)) {
      _listasCriadas.add(nomeLista);
    }
  }

  List<String> getListasCriadas() {
    return _listasCriadas;
  }

  void adicionarProduto(
      String nomeLista, String nomeProduto, double preco, int quantidade) {
    final produto =
        Produto(nome: nomeProduto, preco: preco, quantidade: quantidade);

    if (!_produtosPorLista.containsKey(nomeLista)) {
      _produtosPorLista[nomeLista] = [];
    }
    _produtosPorLista[nomeLista]!.add(produto);
  }

  List<Produto> getProdutosPorLista(String nomeLista) {
    return _produtosPorLista[nomeLista] ?? [];
  }

  void marcarComoComprado(String nomeLista, String nomeProduto, bool comprado) {
    _produtosPorLista[nomeLista]?.forEach((produto) {
      if (produto.nome == nomeProduto) {
        produto.comprado = comprado;
      }
    });
  }

  void removerProduto(String nomeLista, Produto produto) {
    _produtosPorLista[nomeLista]?.remove(produto);
  }

  void removerLista(String nomeLista) {
    _produtosPorLista.remove(nomeLista);
    _listasCriadas.remove(nomeLista);
  }
}
