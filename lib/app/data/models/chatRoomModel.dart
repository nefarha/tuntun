// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tun_tun/app/data/models/userModel.dart';

class ChatRoom {
  String id;
  UserModel tunatera;
  UserModel tunarungu;
  ChatRoom({
    required this.id,
    required this.tunatera,
    required this.tunarungu,
  });

  ChatRoom copyWith({
    String? id,
    UserModel? tunatera,
    UserModel? tunarungu,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      tunatera: tunatera ?? this.tunatera,
      tunarungu: tunarungu ?? this.tunarungu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tunatera': tunatera.toMap(),
      'tunarungu': tunarungu.toMap(),
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'] as String,
      tunatera: UserModel.fromMap(map['tunatera'] as Map<String, dynamic>),
      tunarungu: UserModel.fromMap(map['tunarungu'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatRoom(id: $id, tunatera: $tunatera, tunarungu: $tunarungu)';

  @override
  bool operator ==(covariant ChatRoom other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tunatera == tunatera &&
        other.tunarungu == tunarungu;
  }

  @override
  int get hashCode => id.hashCode ^ tunatera.hashCode ^ tunarungu.hashCode;
}
