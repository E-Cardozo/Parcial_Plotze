import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Aplicativo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tema Escolhido:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            const Text('E-Commerce Online.'),
            const SizedBox(height: 16.0),
            Text(
              'Objetivo do Aplicativo:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            const Text('Aplicativo desenvolvido para compras de produtos.'),
            const SizedBox(height: 16.0),
            Text(
              'Desenvolvedor:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            const Text('Eloy Cardozo Augusto - 836463'),
          ],
        ),
      ),
    );
  }
}
