import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:bayshore_task_frontend/views/books/components/author_tag.dart';
import 'package:flutter/material.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({
    super.key,
    required this.title,
    required this.author,
    required this.isbn,
    required this.description,
    required this.quantity,
  });

  final String title, author, isbn, description;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ISBN: ${isbn.toUpperCase()}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              title,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                AuthorTag(author: author),
                const Spacer(),
                Text("Quantity:"),
                Text(
                  "$quantity",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Text(
              "Book Description",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              description,
              style: const TextStyle(height: 1.4),
            ),
            const SizedBox(height: defaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
