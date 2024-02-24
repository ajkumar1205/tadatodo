import 'package:flutter/material.dart';
import 'package:tadatodo/theme/colors.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final note = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: bColor,
                borderRadius: BorderRadius.circular(10),
                border: const Border(
                  right: BorderSide(color: sColor, width: 2),
                  bottom: BorderSide(color: sColor, width: 2),
                ),
              ),
              child: const TextField(
                style: TextStyle(color: black, fontSize: 20),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: bColor,
                  borderRadius: BorderRadius.circular(10),
                  border: const Border(
                    right: BorderSide(color: sColor, width: 2),
                    bottom: BorderSide(color: sColor, width: 2),
                  ),
                ),
                child: TextField(
                  controller: note,
                  style: const TextStyle(color: black, fontSize: 16),
                  maxLines: double.maxFinite.toInt(),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    constraints: BoxConstraints(minHeight: double.minPositive),
                    hintText: "Note",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
