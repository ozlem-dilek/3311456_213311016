import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SelectPhotoPage extends StatefulWidget {
  @override
  _SelectPhotoPageState createState() => _SelectPhotoPageState();
}

class _SelectPhotoPageState extends State<SelectPhotoPage> {
  final ImagePicker _imagePicker = ImagePicker();
  String? selectedImagePath;

  Future<void> _selectPhoto() async {
    PickedFile? pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      setState(() {
        selectedImagePath = imagePath;
      });
    }
  }

  Future<void> _savePhoto() async {
    if (selectedImagePath != null) {
      Directory appDir = await getApplicationDocumentsDirectory();
      String appPath = appDir.path;
      String destPath = '$appPath/profile_photo.jpg';
      File selectedImageFile = File(selectedImagePath!);
      await selectedImageFile.copy(destPath);

      Navigator.pop(context, destPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedImagePath != null)
                Image.file(
                  File(selectedImagePath!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              else
                Icon(Icons.account_circle, size: 200),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectPhoto,
                child: Text('Select Photo'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _savePhoto,
                child: Text('Save Photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
