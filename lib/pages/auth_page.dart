import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/colors.dart';
import '../provider/auth/auth_cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ErrorAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              content: Text(
                state.error,
                style: const TextStyle(color: white),
              ),
            ),
          );
        } else if (state is AuthorizedState) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pushReplacementNamed("/home");
          } else {
            Navigator.of(context).pushNamed("/home");
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SizedBox(
              width: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Input(controller: email),
                  const SizedBox(height: 10),
                  Input(controller: pass),
                  const SizedBox(height: 6),
                  state is ProcessingAuthState
                      ? const LinearProgressIndicator(color: pColor)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SignUp(onTap: () async {
                              await BlocProvider.of<AuthCubit>(context)
                                  .signUp(email.text, pass.text);
                            }),
                            Login(
                              onTap: () async {
                                await BlocProvider.of<AuthCubit>(context)
                                    .login(email.text, pass.text);
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        textStyle: const MaterialStatePropertyAll(
          TextStyle(color: pColor, fontSize: 18),
        ),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              side: const BorderSide(color: pColor),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: const Text("Login"),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(pColor),
        foregroundColor: const MaterialStatePropertyAll(white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20)),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(color: white, fontSize: 18),
        ),
      ),
      child: const Text("Sign Up"),
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: sColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
