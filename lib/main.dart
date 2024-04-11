// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'model/lista_produto.dart';
import 'view/adicionar_produto_view.dart';
import 'view/create_user.dart';
import 'view/login_screen.dart';
import 'view/principal_view.dart';
import 'view/sobre.dart';
import 'view/carrinho_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

//
// MainApp
//
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      initialRoute: 't1',
      routes: {
        't1': (context) => LoginScreen(),
        't2': (context) => PrincipalView(listaProduto: ListaProduto()),
        't3': (context) => Sobre(),
        't5': (context) => AdicionarProdutoView(
              listaProduto: ListaProduto(),
              nomeLista: '',
            ),
        't6': (context) => CreateUser(),
        't7': (context) => CarrinhoView(
              listaProduto: ListaProduto(),
              listasCriadas: const [],
            ), // Passando a lista de listas criadas
      },
    );
  }
}
