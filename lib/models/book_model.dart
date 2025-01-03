import 'package:bayshore_task_frontend/utils/constants.dart';

class BookModel {
  final String? id;
  final String? title;
  final String? author;
  final String? isbn;
  final String? description;
  final String? publisher;
  final String? publicationDate;
  final String? edition;
  final String? genre;
  final String? language;
  final String? coverPhoto;
  final int? quantity;

  BookModel({
    this.id,
    this.title,
    this.author,
    this.isbn,
    this.description,
    this.publisher,
    this.publicationDate,
    this.edition,
    this.genre,
    this.language,
    this.coverPhoto,
    this.quantity,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    String apiUrl = appURL;
    if (json['coverPhoto'] != null && json['coverPhoto'] != '') {
      json['coverPhoto'] = apiUrl + json['coverPhoto'];
    }
    return BookModel(
      id: json['_id'],
      title: json['title'],
      author: json['author'],
      isbn: json['isbn'],
      description: json['description'],
      publisher: json['publisher'],
      publicationDate: json['publicationDate'],
      edition: json['edition'],
      genre: json['genre'],
      language: json['language'],
      coverPhoto: json['coverPhoto'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'description': description,
      'publisher': publisher,
      'publicationDate': publicationDate,
      'edition': edition,
      'genre': genre,
      'language': language,
      'coverPhoto': coverPhoto,
      'quantity': quantity,
    };
  }
}
