import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(String nome, email, String password, String bloco, String numeApartamento, String cpf) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,


    );

    User? user = userCredential.user;

        // Após criar o usuário, salvar informações adicionais no Firestore
    if (user != null) {
      try {
  await _firestore.collection('users').doc(user.uid).set({
    'nome': nome,
    'bloco': bloco,
    'numeroApartamento': numeApartamento,
    'cpf': cpf,
  });
} catch (e) {
  print('Erro ao cadastrar no Firestore: $e');
}
    }
    return user;
  }
}


