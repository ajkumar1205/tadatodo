import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part './auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(DefaultAuthState());

  Future<void> signUp(String email, String pass) async {
    final ins = FirebaseAuth.instance;
    try {
      await ins.createUserWithEmailAndPassword(email: email, password: pass);
      emit(AuthorizedState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorAuthState(e.code));
    }
  }
}
