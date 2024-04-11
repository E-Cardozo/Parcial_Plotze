class Produto {
  String nome;
  double preco;
  int quantidade;
  bool comprado;

  Produto({
    required this.nome,
    required this.preco,
    required this.quantidade,
    this.comprado = false,
  });

  @override
  String toString() {
    // Método para converter o produto em uma string
    return '$nome - Preço: $preco - Quantidade: $quantidade - Comprado: $comprado';
  }
}
