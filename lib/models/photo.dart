class Photo {
  int id;
  int width;
  int height;
  String photographer;
  String photographerUrl;
  String avgColor;

  Src scr;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.photographer,
    required this.photographerUrl,
    required this.avgColor,
    required this.scr,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      avgColor: json['avg_color'],
      scr: Src.fromJson(json['src']),
    );
  }
}

class Src {
  String original;
  String portrait;
  String medium;
  String large;

  Src({
    required this.original,
    required this.portrait,
    required this.medium,
    required this.large,
  });

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      original: json['original'],
      portrait: json['portrait'],
      medium: json['medium'],
      large: json['large'],
    );
  }
}
