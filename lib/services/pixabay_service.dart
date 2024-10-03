import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/image_model.dart';

class PixabayService {
  final String _apiKey = '46318942-42e8b9b738784e54fb5719a82';
  final String _baseUrl = 'https://pixabay.com/api';

  Future<List<ImageModel>> fetchImages(int page) async {
    final response = await http.get(Uri.parse('$_baseUrl/?key=$_apiKey&page=$page'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final images = jsonData['hits'].map((json) => ImageModel.fromJson(json)).toList();
      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
