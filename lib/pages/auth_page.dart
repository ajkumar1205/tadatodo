import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/colors.dart';
import '../provider/auth/auth_cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  InputDecoration inputdecor() {
    return const InputDecoration(
      border: InputBorder.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) => {
          if (state is ErrorAuthState)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  showCloseIcon: true,
                  content: Text(
                    state.error,
                    style: const TextStyle(color: white),
                  ),
                ),
              )
            }
          else if (state is AuthorizedState)
            {Navigator.of(context).pushReplacementNamed("/home")}
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SizedBox(
              width: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: sColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: inputdecor(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: sColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: pass,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: inputdecor(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context)
                              .signUp(email.text, pass.text);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(pColor),
                          foregroundColor:
                              const MaterialStatePropertyAll(white),
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
                      ),
                      TextButton(
                        onPressed: () {},
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
                            )),
                        child: const Text("Login"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
