import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/services/pixabay_service.dart';

import '../model/image_model.dart';

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  final PixabayService _pixabayService = PixabayService();
  List<ImageModel> _images = [];
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final images = await _pixabayService.fetchImages(_page);
    setState(() {
      _images.addAll(images);
      _page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          _loadImages();
        }
        return true;
      },
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2, // adjust this value based on screen width
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.network(_images[index].url),
                Text('Likes: ${_images[index].likes}'),
                Text('Views: ${_images[index].views}'),
              ],
            ),
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      ),
    );
  }
}