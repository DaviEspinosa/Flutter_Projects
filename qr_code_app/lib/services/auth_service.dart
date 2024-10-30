import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função para cadastrar um novo morador
  Future<User?> signUp(
      String nome, String email, String password, String bloco, String numeroApartamento, String cpf) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'nome': nome,
          'bloco': bloco,
          'numeroApartamento': numeroApartamento,
          'cpf': cpf,
        });
      }

      return user;
    } catch (e) {
      print("Erro ao criar usuário: $e");
      throw Exception("Falha no cadastro do usuário: $e");
    }
  }

  // Função para cadastrar um novo visitante
  Future<void> signUpVisitor(String nome, String cpf) async {
    try {
      // Verifica se há um usuário logado (morador)
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('visitors').add({
          'nome': nome,
          'cpf': cpf,
          'moradorId': currentUser.uid, // Adiciona o ID do morador ao visitante
        });
      } else {
        throw Exception("Nenhum morador logado.");
      }
    } catch (e) {
      print("Erro ao criar visitante: $e");
      throw Exception("Falha no cadastro do visitante: $e");
    }
  }
}
