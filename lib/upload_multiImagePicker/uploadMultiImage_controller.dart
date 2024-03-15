import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

Future<List<ImageFile>> uploadProfileImages(List<File> imageFiles) async {
  List<ImageFile> uploadedImages = [];
  try {
    for (var file in imageFiles) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http:example/addImage'),
      );
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        file.path,
      ));
      var response = await request.send();
      if (response.statusCode == 201) {
        // Image uploaded successfully
        print('Image uploaded successfully');
        //
      } else {
        // Image upload failed
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
  return uploadedImages;
}
