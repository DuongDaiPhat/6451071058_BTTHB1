import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return UserModel.fromFirebaseUser(userCredential.user!);
      } else {
        throw FirebaseAuthException(code: 'ERROR_USER_NOT_FOUND', message: 'User not found.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return UserModel.fromFirebaseUser(userCredential.user!);
      } else {
        throw FirebaseAuthException(code: 'ERROR_USER_NOT_CREATED', message: 'Could not create user.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
