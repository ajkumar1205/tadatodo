import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/colors.dart';
import '../provider/auth/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              height: 200,
              decoration: BoxDecoration(
                color: bColor,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 150),
            );
          }),
      floatingActionButtonLocation: FabLocation(context: context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: pColor,
        foregroundColor: white,
        onPressed: () {
          Navigator.of(context).pushNamed("/edit");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Widget?> openDialog(BuildContext context) {
    return showDialog<Widget>(
      context: context,
      useRootNavigator: true,
      builder: (context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ErrorAuthState) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacementNamed("/auth");
          }
        },
        child: Dialog(
          backgroundColor: bColor,
          child: SizedBox(
            width: 300,
            height: 210,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const CircleAvatar(
                  backgroundColor: pColor,
                  foregroundColor: white,
                  radius: 50,
                  child: Text("A", style: TextStyle(fontSize: 40)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ajthakur1205@gmail.com",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await BlocProvider.of<AuthCubit>(context).signOut();
                      },
                      child: const Text("Sign Out"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Close"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        width: double.minPositive,
        margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: sColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: TextField(
                style: TextStyle(fontSize: 20, color: black),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 30, color: pColor),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () async {
                await openDialog(context);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(pColor),
                shape: MaterialStatePropertyAll(
                  CircleBorder(side: BorderSide.none),
                ),
                padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                fixedSize: MaterialStatePropertyAll(
                  Size(50, 50),
                ),
              ),
              child: const Text(
                "A",
                style: TextStyle(
                  fontSize: 25,
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FabLocation extends FloatingActionButtonLocation {
  final BuildContext context;
  FabLocation({required this.context});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final fabw = scaffoldGeometry.floatingActionButtonSize.width;
    return Offset(w - fabw - 25, h - fabw - 30);
  }
}
