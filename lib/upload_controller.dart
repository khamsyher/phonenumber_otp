import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> uploadProfileImage(File imageFile) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http:example/addImage'),
    );
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));
    var response = await request.send();
    if (response.statusCode == 201) {
      // Image uploaded successfully
      print('Image uploaded successfully');
    } else {
      // Image upload failed
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}