class Records {
  int timestamp;
  String uidUser;
  int totalSegments;
  late String name;
  Records(
      {required this.uidUser,
      required this.timestamp,
      required this.totalSegments});

  static Records fromJson(Map<String, dynamic> json) => Records(
      timestamp: json["Timestamp"],
      uidUser: json["UuidUser"],
      totalSegments: json["TotalSegments"]);
}
