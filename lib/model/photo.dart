class Photo {
  String photographer;
  String photographerUrl;
  Src scr;

  Photo({this.photographer, this.photographerUrl, this.scr});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      scr: Src.fromJson(json['src']),
    );
  }
}

class Src {
  String original;
  String portrait;
  String medium;
  String large;

  Src({this.original, this.portrait, this.medium, this.large});

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
      original: json['original'],
      portrait: json['portrait'],
      medium: json['medium'],
      large: json['large'],
    );
  }
}
