import 'dart:io';

import 'package:bayshore_task_frontend/models/book_model.dart';
import 'package:bayshore_task_frontend/models/book_request_model.dart';
import 'package:bayshore_task_frontend/services/api_service.dart';

class BookRepository {
  final ApiService _apiService;

  BookRepository(this._apiService);

  Future<List<BookModel>> getBooks() async {
    try {
      final response = await _apiService.get('/books');
      if (response is List) {
        return response.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid data format: Expected a list of books');
      }
    } catch (error) {
      throw Exception('Error fetching books: $error');
    }
  }

  Future<List<BookModel>> searchBooks(String criteria, String keyword) async {
    try {
      final response = await _apiService
          .get('/books/search?criteria=$criteria&keyword=$keyword');
      if (response is List) {
        return response.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid data format: Expected a list of books');
      }
    } catch (error) {
      print(error);
      throw Exception('Error searching books: $error');
    }
  }

  Future<BookModel> getBookDetails(String id) async {
    try {
      final response = await _apiService.get('/books/$id');

      if (response is Map<String, dynamic>) {
        return BookModel.fromJson(response);
      } else {
        throw Exception('Invalid data format: Expected book details');
      }
    } catch (error) {
      throw Exception('Error fetching book details for ID $id: $error');
    }
  }

  Future<BookModel> addBook(BookRequestModel request) async {
    try {
      final data = {
        'title': request.book.title,
        'author': request.book.author,
        'isbn': request.book.isbn,
        'publicationDate': request.book.publicationDate,
        'language': request.book.language,
        'description': request.book.description,
        'publisher': request.book.publisher,
        'edition': request.book.edition,
        'genre': request.book.genre,
        'quantity': request.book.quantity.toString(),
      };

      final imageFile = request.image;

      final response = await _apiService.postWithImage(
          '/books', data, "coverPhoto", imageFile);

      if (response is Map<String, dynamic>) {
        return BookModel.fromJson(response);
      } else {
        throw Exception('Invalid data format: Expected book details');
      }
    } catch (error) {
      print(error);
      throw Exception('Error adding book: $error');
    }
  }

  // Edit an existing book (PUT request)
  Future<BookModel> editBook(String bookId, BookRequestModel request) async {
    try {
      final data = {
        'title': request.book.title,
        'author': request.book.author,
        'isbn': request.book.isbn,
        'publicationDate': request.book.publicationDate,
        'language': request.book.language,
        'description': request.book.description,
        'publisher': request.book.publisher,
        'edition': request.book.edition,
        'genre': request.book.genre,
        'quantity': request.book.quantity.toString(),
      };
      File? imageFile = (request.image?.path.contains("http") ?? false)
          ? null
          : request.image;

      final response = await _apiService.putWithImage(
          '/books/$bookId', data, "coverPhoto", imageFile);

      if (response is Map<String, dynamic>) {
        return BookModel.fromJson(response);
      } else {
        throw Exception('Invalid data format: Expected book details');
      }
    } catch (error) {
      print(error);
      throw Exception('Error editing book: $error');
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await _apiService.delete('/books/$bookId');
    } catch (error) {
      throw Exception('Error deleting book: $error');
    }
  }
}
