part of "./notes_cubit.dart";

abstract class NoteState {}

final class DefaultNoteState extends NoteState {}

final class EditNoteState extends NoteState {}

final class ErrorNoteState extends NoteState {}
