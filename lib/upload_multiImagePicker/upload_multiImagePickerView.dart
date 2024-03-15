import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:phonenumber_otp/upload_multiImagePicker/uploadMultiImage_controller.dart';

class MyImagePickerWidget extends StatefulWidget {
  const MyImagePickerWidget({Key? key}) : super(key: key);

  @override
  _MyImagePickerWidgetState createState() => _MyImagePickerWidgetState();
}

class _MyImagePickerWidgetState extends State<MyImagePickerWidget> {
  final controller = MultiImagePickerController(
    // Initialize your controller settings here
    maxImages: 15,
    images: [], // Initial list of selected images
    picker: (bool allowMultiple) async {
      // Logic to pick images
      // Example: return await pickImagesUsingImagePicker(allowMultiple);
      return []; // Return a list of selected images
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Image Picker View'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Expanded(
              child: MultiImagePickerView(
                controller: controller,
                builder: (context, imageFile) {
                  return DefaultDraggableItemWidget(
                    imageFile: imageFile,
                    // Customize the appearance of the draggable item
                    // You can use DefaultDraggableItemWidget or create your own widget
                  );
                },
                initialWidget: const DefaultInitialWidget(
                    // Customize the appearance of the initial widget
                    // You can use DefaultInitialWidget or create your own widget
                    ),
                addMoreButton: const DefaultAddMoreWidget(
                    // Customize the appearance of the add more button
                    // You can use DefaultAddMoreWidget or create your own widget
                    ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to trigger image selection
                controller.pickImages();
              },
              child: const Text('Select Images'),
            ),
          ],
        ),
      ),
    );
  }
}

final controller = MultiImagePickerController(
  maxImages: 15,
  images: <ImageFile>[], // array of pre/default selected images
  picker: (bool allowMultiple) async {
    // Use multi image picker to pick images
    List<File> pickedImages = await pickImagesUsingImagePicker(allowMultiple);
    // Upload the picked images
    return uploadProfileImages(pickedImages);
  },
);

pickImagesUsingImagePicker(bool allowMultiple) {}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Upload Multi Image Picker View'),
    ),
    body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Expanded(
            child: MultiImagePickerView(
              controller: controller,
              builder: (BuildContext context, ImageFile imageFile) {
                // here returning DefaultDraggableItemWidget. You can also return your custom widget as well.
                return DefaultDraggableItemWidget(
                  imageFile: imageFile,
                  boxDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  closeButtonAlignment: Alignment.topLeft,
                  fit: BoxFit.cover,
                  closeButtonIcon:
                      const Icon(Icons.delete_rounded, color: Colors.red),
                  closeButtonBoxDecoration: null,
                  showCloseButton: true,
                  closeButtonMargin: const EdgeInsets.all(3),
                  closeButtonPadding: const EdgeInsets.all(3),
                );
              },
              initialWidget: DefaultInitialWidget(
                centerWidget: const Icon(Icons.image_search_outlined),
                backgroundColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                margin: EdgeInsets.zero,
              ),
              addMoreButton: const DefaultAddMoreWidget(
                icon: Icon(Icons.image_search_outlined),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            onPressed: () {
              // logic here
              controller.pickImages();
            },
            child: const Text("Upload Profile"),
          ),
        ],
      ),
    ),
  );
}
