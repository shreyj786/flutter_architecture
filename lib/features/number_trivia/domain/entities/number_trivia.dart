import 'package:equatable/equatable.dart';

class NumberTrivia {
  String? text;
  int? number;
  bool? found;
  String? type;

  NumberTrivia({this.text, this.number, this.found, this.type});

  NumberTrivia.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    number = json['number'];
    found = json['found'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['number'] = number;
    data['found'] = found;
    data['type'] = type;
    return data;
  }
}
