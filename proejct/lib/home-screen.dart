import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? selectedFileBytes;

  void _pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      // allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      _processSelectedFile(result.files.single.bytes);
    }
  }

  void _pickImageFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      final File file = File(image.path);
      _processSelectedFile(await file.readAsBytes());
    }
  }

  void _processSelectedFile(Uint8List? fileBytes) {
    if (fileBytes != null) {
      setState(() {
        selectedFileBytes = fileBytes;
      });
    } else {
      print("File is empty or couldn't be read.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker for Web and Camera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (selectedFileBytes != null)
              Image.memory(
                selectedFileBytes!,
                width: 300, // Adjust the width as needed
              ),
            IconButton(
              onPressed: _pickImageFromGallery,
             icon:Icon(Icons.add_a_photo_outlined)
            ),
           
          ],
        ),
      ),
    );
  }
}
