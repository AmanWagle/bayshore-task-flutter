import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookTextField extends StatelessWidget {
  const BookTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    this.controller,
    this.isLastField = false,
    this.validator,
  });

  final String hintText, prefixIcon;
  final TextInputType keyboardType;
  final bool isLastField;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction:
          isLastField ? TextInputAction.done : TextInputAction.next,
      keyboardType: keyboardType,
      maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
      minLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
          child: SvgPicture.asset(
            prefixIcon,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
