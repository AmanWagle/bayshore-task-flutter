import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:flutter/material.dart';

class AuthorTag extends StatelessWidget {
  const AuthorTag({
    super.key,
    required this.author,
  });

  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: successColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultBorderRadious / 2),
        ),
      ),
      child: Text(
        author,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
