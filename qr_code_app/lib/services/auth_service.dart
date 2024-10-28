import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(
      String nome, String email, String password, String bloco, String numeroApartamento, String cpf) async {
    try {
      // Criar o usuário com email e senha no Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obter o usuário criado
      User? user = userCredential.user;

      // Após criar o usuário, salvar informações adicionais no Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'nome': nome,
          'bloco': bloco,
          'numeroApartamento': numeroApartamento,
          'cpf': cpf,
        });
      }

      return user; // Retorna o usuário criado
    } catch (e) {
      print("Erro ao criar usuário: $e"); // Log do erro
      throw Exception("Falha no cadastro do usuário: $e"); // Lança a exceção com o erro
    }
  }


  Future<void> signUpVisitor(String nome, String cpf) async {
    try {
      // Cria o documento do visitante no Firestore usando um ID único
      await _firestore.collection('visitors').add({
        'nome': nome,
        'cpf': cpf,
      });
    } catch (e) {
      print("Erro ao criar visitante: $e");
      throw Exception("Falha no cadastro do visitante: $e");
    }
  }
}
