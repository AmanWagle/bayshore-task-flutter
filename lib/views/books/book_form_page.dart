import 'dart:io';
import 'package:bayshore_task_frontend/models/book_model.dart';
import 'package:bayshore_task_frontend/models/book_request_model.dart';
import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/utils/ui_helper.dart';
import 'package:bayshore_task_frontend/view_model/book_view_model.dart';
import 'package:bayshore_task_frontend/views/books/components/book_image_picker.dart';
import 'package:bayshore_task_frontend/views/books/components/book_text_field.dart';
import 'package:bayshore_task_frontend/views/books/components/date_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key, this.bookId});

  final String? bookId;

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _publishedDateController =
      TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _editionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.bookId != null) {
      _fetchBookDetails();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _publishedDateController.dispose();
    _languageController.dispose();
    _descriptionController.dispose();
    _publisherController.dispose();
    _editionController.dispose();
    _genreController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _fetchBookDetails() async {
    if (widget.bookId != null) {
      final book =
          await context.read<BookViewModel>().getBookDetails(widget.bookId!);
      if (book != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _titleController.text = book.title ?? '';
            _authorController.text = book.author ?? '';
            _isbnController.text = book.isbn ?? '';
            _publishedDateController.text = book.publicationDate != null
                ? DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(book.publicationDate!))
                : '';
            _languageController.text = book.language ?? '';
            _descriptionController.text = book.description ?? '';
            _publisherController.text = book.publisher ?? '';
            _editionController.text = book.edition ?? '';
            _genreController.text = book.genre ?? '';
            _quantityController.text = book.quantity.toString();
            _selectedImage =
                book.coverPhoto != null ? File(book.coverPhoto!) : null;
          });
        });
      }
    }
  }

  Future<void> _updateBook(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        BookModel book = BookModel(
          title: _titleController.text.trim(),
          author: _authorController.text.trim(),
          isbn: _isbnController.text.trim(),
          publicationDate: _publishedDateController.text.trim(),
          language: _languageController.text.trim(),
          description: _descriptionController.text.trim(),
          publisher: _publisherController.text.trim(),
          edition: _editionController.text.trim(),
          genre: _genreController.text.trim(),
          quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
        );
        BookRequestModel request =
            BookRequestModel(book: book, image: _selectedImage);
        bool success = widget.bookId != null
            ? await context
                .read<BookViewModel>()
                .updateBook(widget.bookId!, request)
            : await context.read<BookViewModel>().addBook(request);

        if (success) {
          UIHelper.showSuccessSnackBar(
              context: context, message: "Book updated successfully");
          Navigator.pop(context);
        } else {
          UIHelper.showErrorSnackBar(
              context: context, message: "Failed to update book");
        }
      } catch (e) {
        UIHelper.showErrorSnackBar(context: context, message: e.toString());
      }
    }
  }

  Future<void> _addBook(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final book = BookModel(
          title: _titleController.text.trim(),
          author: _authorController.text.trim(),
          isbn: _isbnController.text.trim(),
          publicationDate: _publishedDateController.text.trim(),
          language: _languageController.text.trim(),
          description: _descriptionController.text.trim(),
          publisher: _publisherController.text.trim(),
          edition: _editionController.text.trim(),
          genre: _genreController.text.trim(),
          quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
        );
        final request = BookRequestModel(book: book, image: _selectedImage);

        final success = await context.read<BookViewModel>().addBook(request);
        if (success) {
          UIHelper.showSuccessSnackBar(
              context: context, message: "Book added successfully");
          Navigator.pop(context);
        } else {
          UIHelper.showErrorSnackBar(
              context: context, message: "Failed to add book");
        }
      } catch (e) {
        UIHelper.showErrorSnackBar(context: context, message: e.toString());
      }
    }
  }

  String? _validateRequiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.bookId != null ? 'Edit Book' : 'Add Book',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookTextField(
                  controller: _titleController,
                  validator: _validateRequiredField,
                  hintText: "Book Title",
                  prefixIcon: "assets/icons/title.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _authorController,
                  validator: _validateRequiredField,
                  hintText: "Author",
                  prefixIcon: "assets/icons/author.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _isbnController,
                  validator: _validateRequiredField,
                  hintText: "ISBN",
                  prefixIcon: "assets/icons/isbn.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                DatePickerField(
                  hintText: "Published Date",
                  prefixIcon: "assets/icons/date.svg",
                  controller: _publishedDateController,
                  onDateSelected: (value) {
                    _publishedDateController.text = value;
                  },
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _quantityController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Quantity is required";
                    }
                    if (int.tryParse(value) == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                  hintText: "Quantity",
                  prefixIcon: "assets/icons/quantity.svg",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _descriptionController,
                  hintText: "Description",
                  prefixIcon: "assets/icons/description.svg",
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _publisherController,
                  hintText: "Publisher",
                  prefixIcon: "assets/icons/publisher.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _editionController,
                  hintText: "Edition",
                  prefixIcon: "assets/icons/edition.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _genreController,
                  hintText: "Genre",
                  prefixIcon: "assets/icons/genre.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                BookTextField(
                  controller: _languageController,
                  hintText: "Language",
                  prefixIcon: "assets/icons/language.svg",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: defaultPadding),
                BookImagePicker(
                  onImageSelected: (image) {
                    _selectedImage = image;
                  },
                  imageUrl: widget.bookId != null ? _selectedImage?.path : null,
                ),
                const SizedBox(height: defaultPadding),
                ElevatedButton(
                  onPressed: () {
                    widget.bookId == null
                        ? _addBook(context)
                        : _updateBook(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 50),
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    widget.bookId != null ? 'Edit Book' : 'Add Book',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
