import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part './auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(DefaultAuthState());

  Future<void> signUp(String e, String p) async {
    if (e.isEmpty || p.isEmpty) {
      emit(ErrorAuthState("Please Enter email and password"));
      return;
    }
    final ins = FirebaseAuth.instance;
    final email = e.trim();
    final pass = p.trim();
    try {
      emit(ProcessingAuthState());
      await ins.createUserWithEmailAndPassword(email: email, password: pass);
      emit(AuthorizedState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorAuthState(e.code));
    }
  }

  Future<void> login(String e, String p) async {
    if (e.isEmpty || p.isEmpty) {
      emit(ErrorAuthState("Please Enter email and password"));
      return;
    }
    final ins = FirebaseAuth.instance;
    final email = e.trim();
    final pass = p.trim();
    try {
      emit(ProcessingAuthState());
      await ins.signInWithEmailAndPassword(email: email, password: pass);
      emit(AuthorizedState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorAuthState(e.code));
    }
  }

  Future<void> signOut() async {
    final ins = FirebaseAuth.instance;
    if (ins.currentUser != null) {
      await ins.signOut();
    }
    emit(ErrorAuthState("You have logged out"));
  }
}
