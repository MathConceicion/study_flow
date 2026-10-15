import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get usuario => _auth.userChanges();

  Future<void> entrar(String email, String senha) async {
    await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
  }

  Future<void> cadastrar(String nome, String email, String senha) async {
    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
    await credencial.user!.updateDisplayName(nome.trim());
  }

  Future<void> sair() => _auth.signOut();

  String mensagem(FirebaseAuthException erro) {
    switch (erro.code) {
      case 'invalid-email':
        return 'Informe um e-mail válido.';
      case 'email-already-in-use':
        return 'Este e-mail já possui uma conta.';
      case 'weak-password':
        return 'A senha não atende à política do projeto.';
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Não foi possível entrar. Confira e-mail e senha.';
      case 'network-request-failed':
        return 'Sem conexão. Verifique sua internet.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde antes de tentar novamente.';
      case 'operation-not-allowed':
        return 'O acesso por e-mail ainda não está habilitado.';
      default:
        return 'Não foi possível concluir. Tente novamente.';
    }
  }
}
