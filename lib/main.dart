import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'model/image_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixabay Image Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGallery(),
    );
  }
}

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final _apiKey = '46318942-42e8b9b738784e54fb5719a82';
  final _perPage = 10;
  late var _page = 1;
  final _images = <ImageModel>[];

  Future<void> _loadImages() async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=$_apiKey&q=yellow+flowers&image_type=photo&per_page=$_perPage&page=$_page'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final hits = jsonData['hits'] as List<dynamic>;
      final newImages = hits.map<ImageModel>((image) => ImageModel.fromJson(image)).toList();

      setState(() {
        _images.addAll(newImages);
        _page++;
      });
    } else {
      print('Failed to load images');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pixabay Image Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];

          return Column(
            children: [
              Image.network(image.previewURL),
              Text(
                '${NumberFormat.compact().format(image.likes)} likes',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '${NumberFormat.compact().format(image.views)} views',
                style: TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}