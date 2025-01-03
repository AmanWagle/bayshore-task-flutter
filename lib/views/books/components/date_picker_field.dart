import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bayshore_task_frontend/utils/constants.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final TextEditingController controller; // Accept controller here
  final Function(String) onDateSelected;

  const DatePickerField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller, // Make controller a required parameter
    required this.onDateSelected,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        widget.controller.text = formattedDate;
      });
      widget.onDateSelected(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
              child: SvgPicture.asset(
                widget.prefixIcon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withValues(alpha: 0.3),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          readOnly: true,
          controller: widget.controller, // Use the passed controller
        ),
      ),
    );
  }
}
