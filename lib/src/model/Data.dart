class Data {
  List value_Array_number;
  String newdocument_record;
  int sequence;

  Data(
      {required this.newdocument_record,
      required this.value_Array_number,
      required this.sequence});

  static Data fromJson(Map<String, dynamic> json) => Data(
      value_Array_number: json["Value_Array_number"],
      newdocument_record: json["newdocument_record"],
      sequence: json["Sequence"]);
}
