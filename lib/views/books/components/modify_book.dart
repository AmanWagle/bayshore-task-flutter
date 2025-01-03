// ignore_for_file: use_build_context_synchronously

import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/utils/ui_helper.dart';
import 'package:bayshore_task_frontend/view_model/book_view_model.dart';
import 'package:bayshore_task_frontend/views/books/book_form_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyBook extends StatelessWidget {
  const ModifyBook({
    super.key,
    required this.bookId,
  });

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultBorderRadious),
            ),
            border: Border.all(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withValues(alpha: 0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookFormPage(bookId: bookId)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: Text(
                      "Edit Book",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text(
                                "Are you sure you want to delete this book?"),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(
                                      context, false); // Cancel action
                                },
                                isDefaultAction: true,
                                child: Text("Cancel"),
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(
                                      context, true); // Confirm action
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      // Proceed only if the user confirms the action
                      if (confirm == true) {
                        final bookViewModel =
                            Provider.of<BookViewModel>(context, listen: false);
                        try {
                          await bookViewModel.deleteBook(bookId);
                          Navigator.pop(
                              context); // Navigate back after deleting
                        } catch (error) {
                          UIHelper.showErrorSnackBar(
                            context: context,
                            message: "Error deleting book",
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "Delete Book",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
