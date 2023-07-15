// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tun_tun/app/data/models/userModel.dart';

class ChatRoom {
  String id;
  UserModel tunatera;
  UserModel tunarungu;
  bool newMessage;
  Map? lastSender;
  ChatRoom({
    required this.id,
    required this.tunatera,
    required this.tunarungu,
    required this.newMessage,
    this.lastSender,
  });

  ChatRoom copyWith({
    String? id,
    UserModel? tunatera,
    UserModel? tunarungu,
    bool? newMessage,
    Map? lastSender,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      tunatera: tunatera ?? this.tunatera,
      tunarungu: tunarungu ?? this.tunarungu,
      newMessage: newMessage ?? this.newMessage,
      lastSender: lastSender ?? this.lastSender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tunatera': tunatera.toMap(),
      'tunarungu': tunarungu.toMap(),
      'newMessage': newMessage,
      'lastSender': lastSender,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'] as String,
      tunatera: UserModel.fromMap(map['tunatera'] as Map<String, dynamic>),
      tunarungu: UserModel.fromMap(map['tunarungu'] as Map<String, dynamic>),
      newMessage: map['newMessage'] as bool,
      lastSender: map['lastSender'] != null
          ? map['lastSender'] as Map<String, dynamic>
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatRoom(id: $id, tunatera: $tunatera, tunarungu: $tunarungu, newMessage: $newMessage, lastSender: $lastSender)';
  }

  @override
  bool operator ==(covariant ChatRoom other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tunatera == tunatera &&
        other.tunarungu == tunarungu &&
        other.newMessage == newMessage &&
        other.lastSender == lastSender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tunatera.hashCode ^
        tunarungu.hashCode ^
        newMessage.hashCode ^
        lastSender.hashCode;
  }
}
