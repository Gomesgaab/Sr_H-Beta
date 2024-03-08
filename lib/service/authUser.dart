import 'package:firebase_auth/firebase_auth.dart';

class AutentificacaoUsuario {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? cadastroUsuario({
    required String email,
    required String senha,
  }) {
    //tratando o erro de cadastro duplicado, cadastrar usuário já cadastrado
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado";
      }
      return "Erro desconhecido";
    }
  }

  // metodo de logar usuário
  Future<String?> logarUsuario(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //metodo de sair do usuário
  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }
}
