import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/image_gallery.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery',
      home: ImageGallery(),
    );
  }
}
