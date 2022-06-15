class Binary {
  String status;
  String original;
  String converted;
  String from;
  String to;

  Binary({
    required this.status,
    required this.original,
    required this.converted,
    required this.from,
    required this.to,
  });

  factory Binary.fromJson(Map<String, dynamic> json) => Binary(
        status: (json["status"]),
        original: (json["original"]),
        converted: (json["converted"]),
        from: (json["from"]),
        to: (json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "original": original,
        "converted": converted,
        "from": from,
        "to": to,
      };
}
