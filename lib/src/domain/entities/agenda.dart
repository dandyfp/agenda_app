import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda.freezed.dart';

@freezed
class Agenda with _$Agenda {
  const factory Agenda({
    int? id,
    String? title,
    String? description,
    String? dateTime,
    List<int>? imagePath,
    String? imageName,
    String? timeReminder,
  }) = _Agenda;

  factory Agenda.fromJSON(Map<String, dynamic> json) {
    Uint8List image = json["imagePath"];

    return Agenda(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      dateTime: json["dateTimeAgenda"],
      imageName: json["imageName"],
      imagePath: image,
      timeReminder: json["timeReminder"],
    );
  }
}
