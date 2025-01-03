import 'package:bayshore_task_frontend/models/book_request_model.dart';
import 'package:bayshore_task_frontend/repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:bayshore_task_frontend/models/book_model.dart';

class BookViewModel with ChangeNotifier {
  final BookRepository _repository;
  List<BookModel> _books = [];
  BookModel? _bookDetails;
  String? _error;
  bool _isLoading = false;

  BookViewModel(this._repository);
  BookModel? get bookDetails => _bookDetails;
  String? get error => _error;
  List<BookModel> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> fetchBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _books = await _repository.getBooks();
    } catch (error) {
      print("Error fetching books: $error");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search books by criteria and keyword
  Future<void> searchBooks(String criteria, String keyword) async {
    _isLoading = true;
    notifyListeners();
    try {
      _books = await _repository.searchBooks(criteria.toLowerCase(), keyword);
    } catch (e) {
      print("Error searching books: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<BookModel?> getBookDetails(String id) async {
    _isLoading = true;
    _error = null;
    _bookDetails = null;
    notifyListeners();

    try {
      final book = await _repository.getBookDetails(id);
      _bookDetails = book;
      return book;
    } catch (error) {
      _error = "Error fetching book details: $error";
      print(_error);
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addBook(BookRequestModel bookRequest) async {
    try {
      await _repository.addBook(bookRequest);
      await fetchBooks();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateBook(String id, BookRequestModel bookRequest) async {
    try {
      await _repository.editBook(id, bookRequest);
      await getBookDetails(id);
      await fetchBooks();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      await _repository.deleteBook(bookId);
      await fetchBooks();
    } catch (error) {
      print("Error deleting book: $error");
    }
  }
}
