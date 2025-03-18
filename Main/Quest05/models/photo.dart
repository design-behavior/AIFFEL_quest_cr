class Photo {
  final String id;
  final String url;
  final String title;
  final DateTime dateTimeOriginal;
  final String location;
  final String weather;
  final String story;

  Photo({
    required this.id,
    required this.url,
    required this.title,
    required this.dateTimeOriginal,
    required this.location,
    required this.weather,
    required this.story,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      dateTimeOriginal: DateTime.parse(json['dateTimeOriginal']),
      location: json['location'],
      weather: json['weather'],
      story: json['story'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'dateTimeOriginal': dateTimeOriginal.toIso8601String(),
      'location': location,
      'weather': weather,
      'story': story,
    };
  }
}
