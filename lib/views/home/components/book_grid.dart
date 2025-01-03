import 'package:bayshore_task_frontend/views/books/book_details_page.dart';
import 'package:flutter/material.dart';
import 'package:bayshore_task_frontend/models/book_model.dart';
import 'package:bayshore_task_frontend/views/home/components/book_card.dart';

class BookGrid extends StatelessWidget {
  final List<BookModel> books;

  const BookGrid({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.66,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final book = books[index];
                return BookCard(
                  title: book.title ?? 'Unknown Title',
                  author: book.author ?? 'Unknown Author',
                  isbn: book.isbn ?? 'Unknown ISBN',
                  publishedDate: book.publicationDate ?? 'Unknown Date',
                  quantity: book.quantity ?? 0,
                  coverImage: book.coverPhoto,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsPage(bookId: book.id!),
                      ),
                    );
                  },
                );
              },
              childCount: books.length,
            ),
          ),
        ),
      ],
    );
  }
}
