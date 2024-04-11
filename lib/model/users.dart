class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});
}

class Users {
  static final List<User> _userList = [];

  // Método para verificar se um usuário é válido
  static bool isValidUser(String email, String password) {
    // Verifica se existe algum usuário na lista que corresponda ao email e senha fornecidos
    return _userList
        .any((user) => user.email == email && user.password == password);
  }
}
