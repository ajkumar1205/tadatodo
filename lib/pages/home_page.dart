import 'package:flutter/material.dart';

import '../theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
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

  PreferredSize appBar() {
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
              onPressed: () {},
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
