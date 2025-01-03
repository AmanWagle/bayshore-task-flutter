import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:flutter/material.dart';

class BookImages extends StatefulWidget {
  const BookImages({
    super.key,
    this.image,
  });

  final String? image;

  @override
  State<BookImages> createState() => _BookImagesState();
}

class _BookImagesState extends State<BookImages> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(defaultBorderRadious * 2),
              ),
              child: widget.image != null
                  ? Image.network(
                      widget.image!,
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(
                      placeholderImage,
                      fit: BoxFit.fitHeight,
                    ),
            ),
          )),
    );
  }
}
