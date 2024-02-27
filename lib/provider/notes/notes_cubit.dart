import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/note.dart';

part "./notes_states.dart";

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(DefaultNoteState());

  Note? currentNote;

  Future<void> saveNote() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final ins = FirebaseFirestore.instance.collection(user);
    try {
      await ins.add({
        "title": currentNote!.title,
        "note": currentNote!.note,
        "created": currentNote!.created,
      });
    } on FirebaseException catch (e) {
      //
    }
  }

  Future getNotes() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ins = FirebaseFirestore.instance.collection(uid);
    final query = await ins
        .orderBy(
          "created",
          descending: true,
        )
        .get();
    final list = query.docs;
    return list;
  }
}
