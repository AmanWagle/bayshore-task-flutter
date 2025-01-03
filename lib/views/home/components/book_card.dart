import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publishedDate,
    required this.quantity,
    this.coverImage,
    required this.press,
  });

  final String title, author, isbn, publishedDate;
  final String? coverImage;
  final int quantity;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultBorderRadious),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5,
              color: darkGreyColor.withValues(alpha: 0.5),
            ),
          ],
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: coverImage != null
                  ? Image.network(
                      coverImage!,
                      fit: BoxFit.fitWidth,
                    )
                  : Image.asset(
                      placeholderImage,
                      fit: BoxFit.fitWidth,
                    ),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultPadding / 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    Text(
                      "ISBN $isbn",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      "Quantity: $quantity",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
