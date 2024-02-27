import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadatodo/theme/colors.dart';

import '../provider/notes/notes_cubit.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final note = TextEditingController();
    final title = TextEditingController();
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
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
                ),
                child: TextField(
                  controller: title,
                  style: const TextStyle(color: black, fontSize: 20),
                  decoration: const InputDecoration(
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
                  ),
                  child: TextField(
                    controller: note,
                    style: const TextStyle(color: black, fontSize: 16),
                    maxLines: double.maxFinite.toInt(),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      constraints:
                          BoxConstraints(minHeight: double.minPositive),
                      hintText: "Note",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
