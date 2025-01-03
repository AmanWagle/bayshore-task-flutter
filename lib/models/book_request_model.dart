import 'dart:io';
import 'package:bayshore_task_frontend/models/book_model.dart';

class BookRequestModel {
  final BookModel book;
  final File? image;

  BookRequestModel({
    required this.book,
    this.image,
  });
}
