import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BookImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String? imageUrl; // URL of the existing image (if available)

  const BookImagePicker({
    super.key,
    required this.onImageSelected,
    this.imageUrl, // Add this parameter to accept the existing image URL
  });

  @override
  State<BookImagePicker> createState() => _BookImagePickerState();
}

class _BookImagePickerState extends State<BookImagePicker> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Initialize the _selectedImage if there's an existing image URL
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      _selectedImage =
          File(widget.imageUrl!); // If there's an existing image, use it
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: Text(_selectedImage != null || widget.imageUrl != null
              ? 'Edit Image' // If image is selected or already available, show "Edit Image"
              : 'Select Image'),
        ),
        SizedBox(height: 20),
        if (_selectedImage != null || widget.imageUrl != null)
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    widget.imageUrl!,
                    fit: BoxFit.cover,
                  ), // Display the existing image from the URL if available
          )
        else
          Text(
            'No image selected',
            style: TextStyle(color: Colors.grey),
          ),
      ],
    );
  }
}
