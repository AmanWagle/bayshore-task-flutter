import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookInfoTile extends StatelessWidget {
  const BookInfoTile({
    super.key,
    required this.svgSrc,
    required this.title,
    required this.value,
  });

  final String svgSrc, title, value;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Divider(height: 1),
          ListTile(
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              svgSrc,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyMedium!.color!,
                  BlendMode.srcIn),
            ),
            title: Text(title),
            subtitle: Text(value),
          ),
        ],
      ),
    );
  }
}
