import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/utils/format_date.dart';
import 'package:bayshore_task_frontend/view_model/book_view_model.dart';
import 'package:bayshore_task_frontend/views/books/components/book_images.dart';
import 'package:bayshore_task_frontend/views/books/components/book_info.dart';
import 'package:bayshore_task_frontend/views/books/components/book_info_tile.dart';
import 'package:bayshore_task_frontend/views/books/components/modify_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookId;

  const BookDetailsPage({super.key, required this.bookId});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final bool isLibrarian = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookViewModel>(context, listen: false)
          .getBookDetails(widget.bookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isLibrarian
          ? ModifyBook(
              bookId: widget.bookId,
            )
          : null,
      body: SafeArea(
        child: Consumer<BookViewModel>(
          builder: (context, bookViewModel, child) {
            // Fetch book details if not already loaded
            if (bookViewModel.bookDetails == null ||
                bookViewModel.bookDetails!.id != widget.bookId) {
              return Center(child: CircularProgressIndicator());
            }

            // Check for errors
            if (bookViewModel.error != null) {
              return Center(child: Text('Error: ${bookViewModel.error}'));
            }

            // Check for data
            final book = bookViewModel.bookDetails;
            if (book == null) {
              return Center(child: Text('No data available'));
            }

            // Display book details
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  floating: true,
                ),
                BookImages(
                  image: book.coverPhoto,
                ),
                BookInfo(
                  title: book.title ?? 'No Title',
                  author: book.author ?? 'Unknown Author',
                  isbn: book.isbn ?? 'No ISBN',
                  description: book.description ?? 'No Description',
                  quantity: book.quantity ?? 0,
                ),
                BookInfoTile(
                  svgSrc: "assets/icons/date.svg",
                  title: "Published Date",
                  value: formatDate(
                      book.publicationDate ?? DateTime.now().toString()),
                ),
                BookInfoTile(
                  svgSrc: "assets/icons/publisher.svg",
                  title: "Publisher",
                  value: book.publisher ?? 'No Publisher',
                ),
                BookInfoTile(
                  svgSrc: "assets/icons/edition.svg",
                  title: "Edition",
                  value: book.edition ?? 'No Edition',
                ),
                BookInfoTile(
                  svgSrc: "assets/icons/genre.svg",
                  title: "Genre",
                  value: book.genre ?? 'No Genre',
                ),
                BookInfoTile(
                  svgSrc: "assets/icons/language.svg",
                  title: "Language",
                  value: book.language ?? 'No Language',
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: defaultPadding),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
