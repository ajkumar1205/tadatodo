import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                constraints: BoxConstraints(minHeight: double.minPositive),
                hintText: "Note",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
