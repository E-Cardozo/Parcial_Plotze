import 'package:flutter/material.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controladores para os campos de texto
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Função para salvar um usuário
    void saveUser() {
      // Aqui você pode implementar a lógica para salvar o usuário
      // Exemplo: chamar uma função da camada de serviço para salvar os dados no banco de dados
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // Adicionado para suportar o overflow quando o teclado aparecer
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Nome de Usuário'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true, // Para ocultar a senha
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveUser, // Chama a função para salvar o usuário
                child: Text('Criar Usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
