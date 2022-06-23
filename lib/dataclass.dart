class cBerita {
  String cLink;
  String cTitle;
  String cPubDate;
  String cDescription;
  String cThumbnail;

  cBerita(
      {required this.cLink,
      required this.cTitle,
      required this.cPubDate,
      required this.cDescription,
      required this.cThumbnail});

  factory cBerita.fromJson(Map<String, dynamic> json) {
    return cBerita(
        cLink: json["link"],
        cTitle: json["title"],
        cPubDate: json["pubDate"],
        cDescription: json["description"],
        cThumbnail: json["thumbnail"]);
  }
}
