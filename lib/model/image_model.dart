class ImageModel {
  final String id;
  final String url;
  final int likes;
  final int views;

  ImageModel({required this.id, required this.url, required this.likes, required this.views});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}